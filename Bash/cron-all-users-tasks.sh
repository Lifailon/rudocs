#!/bin/bash
users=($(cat /etc/passwd | awk -F ":" '{print $1}'))
cron_all=0
echo -e "Tasks\tUser Name"
echo -e "-----\t---------"
for u in ${users[@]}
do
count=$(crontab -l -u $u 2> /dev/null | sed "/^#\|^$/d" | wc -l)
cron_all=$(( $cron_all + $count ))
echo -e "$count\t$u"
done
echo "All tasks count: $cron_all"