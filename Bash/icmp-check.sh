#!/bin/bash

ADDRESS="${1:-google.com}"
TIMEOUT="${2:-30}"

host "$ADDRESS" > /dev/null || { echo "DNS ERROR"; exit 1; }
systemd-notify --ready --status="DNS OK"

while true; do
    date=$(date '+%Y.%m.%d %H:%M')
    loss=$(ping -c 2 $ADDRESS | grep -Ewo "[0-9]+%")
    if [ $loss = "100%" ]; then
        echo "$date: $ADDRESS - unavailable"
    else
        echo "$date: $ADDRESS - available"
    fi
    sleep $TIMEOUT
done