#!/bin/bash
ip="192.168.3.104"
db="dbash"
table="iostat_metrics_table"
host=$(hostname)
while :
do
date=$(echo $EPOCHREALTIME | sed -E "s/\..+//")"000000000"
sd=($(ls -l /dev | grep -wo sd.))
iostat=$(iostat -ky /dev/sd* 1 1 | grep -w sd.)
for d in ${sd[@]}
do
print=$(printf "%s\n" "${iostat[@]}" | grep $d)
tps=$(echo $print | awk '{print $2}' | sed -E "s/\..+//")
rs=$(echo $print | awk '{print $6}')
ws=$(echo $print | awk '{print $7}')
curl -i -XPOST "http://$ip:8086/write?db=$db" --data-binary "$table,host=$host,disk=$d tps=$tps,read_kb_sec=$rs,write_kb_sec=$ws $date"
done
sleep 5
done