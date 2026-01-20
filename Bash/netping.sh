#!/bin/bash
function test-ping () {
    ping -c 1 $1 > /dev/null
    if [ $? -eq 0 ] # check exit code
    then
    echo -e "$1 \t \033[32mtrue\033[0m" >> $tmp
    else
    echo -e "$1 \t false" >> $tmp
    fi
}
tmp="/tmp/ping.tmp"
rm $tmp 2> /dev/null # delete the file if the script was interrupted
test_param=$(echo $1 | grep -E "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]")
if [ ${#1} -eq 0 ]
    then
    ip=$(ip -br a | grep -Evi "lo|down" | sed -n 1p)
    ip=$(echo $ip | awk '{print $3}' | awk -F "." '{print $1"."$2"."$3"."}')
elif [ ${#test_param} -eq 0 ]
    then
    echo "Error: Parameter set incorrectly. Use the format 192.168.3.* or leave blank."
    exit
else
    ip=$(echo $1 | awk -F "." '{print $1"."$2"."$3"."}')
fi
net=("$ip"{1..254})
for host in ${net[@]}
    do
    test-ping $host &
done
num=$(cat $tmp | wc -l)
#num=$(jobs -l | wc -l) # get the number of jobs running
while :
do
    if [ $num -eq 254 ] # check the completion of all jobs
        then
        true=$(cat $tmp | grep true | wc -l)
        false=$(cat $tmp | grep false | wc -l)
        cat $tmp | sort -t "." -nk4 # sort by column four
        echo
        echo -e "Available: \t $true" 
        echo -e "Unavailable: \t $false"
		echo
        rm $tmp
        break
    else
        num=$(cat $tmp | wc -l)
    fi
done