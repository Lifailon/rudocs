#!/bin/bash
path_mon="/var/lib/jenkins"
path_log="/var/log/metrics/dir-monitor.log"
precount=0
while :
do
date=$(date | awk '{print $3,$2,$4}')
size=$(du -sh $path_mon | awk '{print $1}')
du=$(du -ah $path_mon)
count=$(printf "%s\n" "${du[@]}" | wc -l)
modify=$(ls -ld $path_mon | awk '{print $7,$6,$8}')
echo -e "$date  Size: $size  File Count: $count  Modify: $modify" >> $path_log
cat $path_log | tail -n 1
if (( $(echo "$precount > $count" | bc) )) || (( $(echo "$precount < $count" | bc) )) && (( $(echo "$precount != 0" | bc) ))
then
diff -c <(echo "$predu") <(echo "$du") | sed -E "s/^---//" | grep -E "^\-|^\+" >> $path_log
fi
predu=$du
precount=$count
sleep 10
done

# Example test:
# touch /var/lib/jenkins/test /var/lib/jenkins/test2
# sleep 10
# rm /var/lib/jenkins/test /var/lib/jenkins/test2
# sleep 10
# cat "/var/log/dir-monitor.log" | tail -n 15

# Display only changes:
# cat "/var/log/dir-monitor.log" | grep -E "..:..:.." | sed -E "s/.+..:..:..\s\s//" | sort | uniq