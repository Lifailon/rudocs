#!/bin/bash

function tcp-scan () {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo "Using: tcp-scan <DST HOST> <START PORT> <END PORT>"
        exit 0
    fi
    dstHost=$1
    if [ "$dstHost" == "" ]; then
        dstHost="localhost"
    fi
    startPort=$2; [ -z "$startPort" ] && startPort=1
    endPort=$3; [ -z "$endPort" ] && endPort=65535
    protocol="tcp"
    port-scan() {
        PORT_NUMBER=$1
        PORT_SCAN_RESULT=`2>&1 echo "" > /dev/$protocol/$dstHost/$PORT_NUMBER | grep connect`
        [ "$PORT_SCAN_RESULT" == "" ] && echo -e $PORT_NUMBER\/$protocol' \t 'open' \t\t '`grep $PORT_NUMBER/$PROTOCOL /etc/services | head -n1 | awk '{print $1}'`
    }
    echo -e 'PORT \t\t STATE \t\t SERVICE'
    for PORT_NUMBER in `seq $startPort $endPort`; do
        port-scan $PORT_NUMBER
    done
}

tcp-scan "$1" "$2" "$3"