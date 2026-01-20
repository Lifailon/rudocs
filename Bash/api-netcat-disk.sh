#!/bin/bash
port=8888
while true; do
    request=$(nc -l -w 1 -p $port)
    request=$(echo "$request" | head -n 1)
    method=$(echo "$request" | cut -d " " -f 1)
    endpoint=$(echo "$request" | cut -d " " -f 2)
    if [[ $endpoint == "/api/disk" ]]
        then
        response="HTTP/1.1 200 OK\nContent-Type: application/json\n\n$(lsblk -e7 --json)"
    else
        response="HTTP/1.1 404 Not Found\n\n404 Not Found\n"
    fi
    echo -e "$response" | nc -l -w 1 -p $port
done