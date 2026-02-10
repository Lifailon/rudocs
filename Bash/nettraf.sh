#!/bin/bash

function Get-Traf {
    interface=$1
    interfaces=($(ip a | grep -E "^[0-9]+:" | cut -d " " -f 2 | sed "s/:$//"))
    if [[ " ${interfaces[@]} " =~ " ${interface} " ]]
        then
        netdev=$(cat /proc/net/dev)
        ### Receive
        ReceiveBytes=$(printf "%s\n" "${netdev[@]}" | grep $interface | awk '{print $2}')
        ReceiveMBytes=$(echo "print($ReceiveBytes/1024/1024)" | python3 | xargs printf "%.0f \n")
        ReceiveGBytes=$(echo "print($ReceiveMBytes*0.001)" | python3 | xargs printf "%.3f \n")
        ReceivePackets=$(printf "%s\n" "${netdev[@]}" | grep $interface | awk '{print $3}')
        ReceiveErrors=$(printf "%s\n" "${netdev[@]}" | grep $interface | awk '{print $4}')
        ReceiveDrop=$(printf "%s\n" "${netdev[@]}" | grep $interface | awk '{print $5}')
        ### Transmit
        TransmitBytes=$(printf "%s\n" "${netdev[@]}" | grep $interface | awk '{print $10}')
        TransmitMBytes=$(echo "print($TransmitBytes/1024/1024)" | python3 | xargs printf "%.0f \n")
        TransmitGBytes=$(echo "print($TransmitMBytes*0.001)" | python3 | xargs printf "%.3f \n")
        TransmitPackets=$(printf "%s\n" "${netdev[@]}" | grep $interface | awk '{print $11}')
        TransmitErrors=$(printf "%s\n" "${netdev[@]}" | grep $interface | awk '{print $12}')
        TransmitDrop=$(printf "%s\n" "${netdev[@]}" | grep $interface | awk '{print $13}')
        ### Convert to JSON
        json='{"Receive GBytes":"'"$ReceiveGBytes"'","Receive Packets":"'"$ReceivePackets"'",'
        json+='"Receive Errors":"'"$ReceiveErrors"'","Receive Drop":"'"$ReceiveDrop"'",'
        json+='"Transmit GBytes":"'"$TransmitGBytes"'","Transmit Packets":"'"$TransmitPackets"'",'
        json+='"Transmit Errors":"'"$TransmitErrors"'","Transmit Drop":"'"$TransmitDrop"'"}'
        echo $json
    else
        echo "Interface $interface not found, use the parameter -l"
    fi
}

help="-h, --help \t\t Get help\n"
help+="-l, --list \t\t List all interfaces,\n"
help+="-i, --interface \t Interface name for get network statistics\n"
help+="-j, --json \t\t Get statistics in json format"

case $1 in
"-h" | "--help")
    echo -e $help
;;
"-l" | "--list")
    echo
    ip a | grep -E "^[0-9]+:" | cut -d " " -f 2 | sed "s/:$//"
    echo
;;
"-i" | "--interface")
    echo
    Get-Traf $2 | jq -r 'to_entries | .[] | "\(.key): \(.value)"'
    echo
;;
"-j" | "--json")
    Get-Traf $2 | jq .
;;
*)
    echo -e $help
;;
esac