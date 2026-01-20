#!/bin/bash
while true; do
    ip="192.168.3.104"
    db="dbash"
    table="icmp_metrics_table"
    server="google.com"
    host=$(hostname)
    date=$(echo $EPOCHREALTIME | sed -E "s/\..+//")"000000000"
    ping=$(ping $server -c 2)
    loss=$(printf "%s\n" "${ping[@]}" | grep -Eo "[0-9]+%" | sed "s/%//")
    if (( $(echo "$loss != 100" | bc) )); then
        status="true"
        rtt=$(printf "%s\n" "${ping[@]}" | grep rtt | awk -F"/" '{print $5}')
    else
        status="false"
        rtt="0"
    fi
    curl -i -XPOST "http://$ip:8086/write?db=$db" --data-binary "$table,host=$host,server=$server status=$status,rtt=$rtt $date"
    sleep 5
done