#!/bin/bash

PORT=8085

# Добавить обработку сигналов kill -2 (ctrl+c) и kill -15
trap 'fuser -k -15 $PORT/tcp; break' SIGINT SIGTERM

while true; do
    request=$(nc -l -w 1 -p $PORT)
    request=$(echo "$request" | head -n 1)
    method=$(echo "$request" | cut -d " " -f 1 | tr '[:lower:]' '[:upper:]')
    endpoint=$(echo "$request" | cut -d " " -f 2)
    if [[ $method != "GET" ]]; then
        response="HTTP/1.1 405 Method Not Allowed\n\nMethod $method not supported on $endpoint\n"
    elif [[ $endpoint == "/api/date" ]]; then
        response="HTTP/1.1 200 OK\nContent-Type: text/plain\n\n$(date)"
    elif [[ $endpoint == "/api/disk" ]]; then
        response="HTTP/1.1 200 OK\nContent-Type: application/json\n\n$(lsblk -e7 --json)"
    elif [[ $endpoint == "/api/systemd/analyze" ]]; then
        response="HTTP/1.1 200 OK\nContent-Type: image/svg+xml\n\n$(systemd-analyze plot)"
    else
        response="HTTP/1.1 404 Not Found\n\n404 Not Found\n"
    fi
    echo -ne "$response" | nc -l -w 1 -p $PORT
done

# curl -s http://localhost:8085/api/date
# curl -s http://localhost:8085/api/disk | jq .blockdevices[]