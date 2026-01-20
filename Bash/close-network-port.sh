#!/bin/bash
port=8080
ports=($(ss -ntp | grep $port | sed -E "s/.+pid=//; s/,.+//"))
for p in ${ports[@]}; do
    kill $p
    echo kill $p
done