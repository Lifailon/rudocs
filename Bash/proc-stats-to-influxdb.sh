#!/bin/bash
process_name=("mysqld" "jenkins")
ip="192.168.3.104"
db="dbash"
table="proc_metrics_table"
host=$(hostname)
while :
do
date=$(echo $EPOCHREALTIME | sed -E "s/\..+//")"000000000"
ps=$(ps -Ao comm,user,cputime,pcpu,pmem,sz,rss,vsz,nlwp,psr,pri,ni)
for p in ${process_name[@]}
do
proc=$(printf "%s\n" "${ps[@]}" | grep $p)
pcpu=$(echo $proc | awk '{print $4}')
pmem=$(echo $proc | awk '{print $5}')
sz=$(echo $proc | awk '{print $6}')
sz=$(( $sz / 1024 ))
rss=$(echo $proc | awk '{print $7}')
rss=$(( $rss / 1024 ))
vsz=$(echo $proc | awk '{print $8}')
vsz=$(( $vsz / 1024 ))
nlwp=$(echo $proc | awk '{print $9}')
psr=$(echo $proc | awk '{print $10}')
data="$table,host=$host,process=$p cpu_proc=$pcpu,mem_proc=$pmem,sz_mb=$sz,rss_mb=$rss,vsz_mb=$vsz,threads=$nlwp,core=$psr $date"
echo "process=$p cpu_proc=$pcpu,mem_proc=$pmem,sz_mb=$sz,rss_mb=$rss,vsz_mb=$vsz,threads=$nlwp,core=$psr" # >> date+logfile
curl -s -o /dev/null -i -XPOST "http://$ip:8086/write?db=$db" --data-binary "$data" > /dev/null
done
sleep 5
done