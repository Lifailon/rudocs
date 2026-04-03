#!/bin/bash

host="yandex.ru"
protocol="ping"
host="yandex.ru:443"
protocol="tcp" # udp/http/dns

# Забрать id хостов проверки для получения результатов
check_id=$(curl -s -H "Accept: application/json" "https://check-host.net/check-$protocol?host=$host&max_nodes=10" | jq -r .request_id)

# Функция получения результатов проверки по id
function check-result {
    curl -s -H "Accept: application/json" https://check-host.net/check-result/$1 | jq .
}

# Получить суммарное количество хостов, с которых производится проверка
hosts_length=$(check-result $check_id | jq length)
while true; do
    check_result=$(check-result $check_id)
    # Забираем результат и проверем, что содержимое всех проверок не равны null
    check_values_not_null=$(echo $check_result | jq -e 'to_entries | map(select(.value != null)) | length')
    if [[ $check_values_not_null == $hosts_length ]]; then
        echo $check_result | jq
        break
    fi
    sleep 1
done