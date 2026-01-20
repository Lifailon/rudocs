#!/bin/bash
path="/var/log/metrics/iostat-metrics.log"
while :
do
date=$(date | awk '{print $3,$2,$4}')
sd=($(ls -l /dev | grep -wo sd.))
iostat=$(iostat -hy /dev/sd* 1 1 | grep -w sd.)
for d in ${sd[@]}
do
print=$(printf "%s\n" "${iostat[@]}" | grep $d)
tps=$(echo $print | awk '{print $1}' | sed -E "s/\..+//")
rs=$(echo $print | awk '{print $2}')
ws=$(echo $print | awk '{print $3}')
echo "$date  tps = $tps  read/s = $rs  write/s = $ws" >> $path
cat $path | tail -n 1
done
sleep 5
done