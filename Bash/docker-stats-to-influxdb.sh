#!/bin/bash
# Source: https://github.com/Lifailon/docker-stats-to-influxdb

################# Variables #################
ip="192.168.3.104" # IP address influx server
port="8086"        # Port influx server
db="docker"        # Databases name
table="stats"      # Measurement
host=$(hostname)   # Current hostname
#############################################

### Warning: For the function to work correct, use LANG=en_US.UTF-8 to /etc/default/locale
function ConvertTo-MByte {
    type=$(echo $1 | grep -Eo "[a-zA-Z]+")
    numer=$(echo $1 | sed -r "s/[a-zA-Z]+//")
    if [ $type == "GiB" ] || [ $type == "GB" ]
        then
        out=$(echo "print $numer*1000" | perl)
        echo $(printf "%.2f" $out)
    elif [ $type == "kB" ] || [ $type == "KiB" ]
        then
        out=$(echo "print $numer/1000" | perl)
        echo $(printf "%.2f" $out)
    else
        echo $(printf "%.2f" $numer)
    fi
}

while :
    do
    date=$(echo $EPOCHREALTIME | sed -E "s/\..+//")"000000000"
    cpu_sum=0
    mem_use_proc_sum=0
    mem_use_sum=0
    net_in_sum=0
    net_out_sum=0
    disk_in_sum=0
    disk_out_sum=0
    pids_sum=0
    size_sum=0
    # Get stats
    docker_stats=$(docker stats --no-stream | sed 1d)
    # Get size
    docker_ps=$(docker ps -s)
    num=$(printf "%s\n" "${docker_stats[@]}" | wc -l)
    # Debug: original output and after convert
    # printf "%s\n" "${docker_stats[@]}" | awk '{print -e $3"\t"$7"\t"$4"/"$6"\t"$8"/"$10"\t"$11"/"$13"\t"$NF"\t"$2}' && echo
    printf "%s\n" "${docker_stats[@]}" | while read line
        do
        id=$(echo $line | awk '{print $1}')
        container=$(echo $line | awk '{print $2}')
        cpu=$(echo $line | awk '{print $3}' | sed "s/%//")
        mem_use_proc=$(echo $line | awk '{print $7}' | sed "s/%//")
        mem_use=$(ConvertTo-MByte $(echo $line | awk '{print $4}'))
        mem_all=$(ConvertTo-MByte $(echo $line | awk '{print $6}'))
        net_in=$(ConvertTo-MByte $(echo $line | awk '{print $8}'))
        net_out=$(ConvertTo-MByte $(echo $line | awk '{print $10}'))
        disk_in=$(ConvertTo-MByte $(echo $line | awk '{print $11}'))
        disk_out=$(ConvertTo-MByte $(echo $line | awk '{print $13}'))
        pids=$(echo $line | awk '{print $NF}')
        ps_size=$(printf "%s\n" "${docker_ps[@]}" | grep $id | awk '{print $NF}' | sed "s/)//")
        size=$(ConvertTo-MByte $ps_size)
        ### Output sum to stdin perl or python3
        cpu_sum=$(echo "print $cpu_sum+$cpu" | perl)
        mem_use_proc_sum=$(echo "print $mem_use_proc_sum+$mem_use_proc" | perl)
        mem_use_sum=$(echo "print $mem_use_sum+$mem_use" | perl)
        net_in_sum=$(echo "print $net_in_sum+$net_in" | perl)
        net_out_sum=$(echo "print $net_out_sum+$net_out" | perl)
        disk_in_sum=$(echo "print $disk_in_sum+$disk_in" | perl)
        disk_out_sum=$(echo "print $disk_out_sum+$disk_out" | perl)
        pids_sum=$(echo "print $pids_sum+$pids" | perl)
        size_sum=$(echo "print $size_sum+$size" | perl)
        ### Logging to systemctl status
        echo -e "$cpu\t$mem_use_proc\t$mem_use/$mem_all\t$net_in/$net_out\t$disk_in/$disk_out\t$pids\t$size\t$container"
        ### Output to InfluxDB
        data="$table,host=$host,container=$container cpu_use%=$cpu,mem_use%=$mem_use_proc,mem_use=$mem_use,mem_all=$mem_all,"
        data+="net_in=$net_in,net_out=$net_out,disk_in=$disk_in,disk_out=$disk_out,pids=$pids,size=$size $date"
        curl -s -o /dev/null -i -XPOST "http://$ip:$port/write?db=$db" --data-binary "$data"
        ### Check and output sum
        if [ $num -ne 1 ]
            then
            num=$(( $num - 1 ))
        else
            echo -e "$cpu_sum\t$mem_use_proc_sum\t$mem_use_sum/$mem_all\t$net_in_sum/$net_out_sum\t$disk_in_sum/$disk_out_sum\t$pids_sum\t$size_sum\tSUM"
            data="$table,host=$host,container=sum cpu_use%=$cpu_sum,mem_use%=$mem_use_proc_sum,mem_use=$mem_use_sum,mem_all=$mem_all,"
            data+="net_in=$net_in_sum,net_out=$net_out_sum,disk_in=$disk_in_sum,disk_out=$disk_out_sum,pids=$pids_sum,size=$size_sum $date"
            curl -s -o /dev/null -i -XPOST "http://$ip:$port/write?db=$db" --data-binary "$data"
        fi
    done
    sleep 5
done