#!/bin/bash

port=$1

ports=$(lsof -t -i:"$port")
for p in ${ports[@]}; do
    kill -9 $p
    echo "$p killed"
done