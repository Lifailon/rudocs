#!/bin/bash

while true; do
    addr="google.com"
    path="/var/log/metrics/icmp-test.log"
    date=$(date | awk '{print $3,$2,$4}')
    loss=$(ping -c 2 $addr | grep -Ewo "[0-9]+%")
    if [ $loss = "100%" ]; then
        echo "$date $addr : unavailable" >> $path
    else
        echo "$date $addr : available" >> $path
        tail -n 1 $path
    fi
    sleep 5
done

# cat icmp-test-log.service > /etc/systemd/system/icmp-test-log.service
# systemctl daemon-reload
# systemctl enable icmp-test-log.service
# systemctl start icmp-test-log
# systemctl status icmp-test-log