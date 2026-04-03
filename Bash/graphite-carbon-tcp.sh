#!/bin/bash

# Carbon (TCP)
# Формат: метрика значение timestamp

while true; do
  echo "test.dev.random $(($RANDOM % 100)) $(date +%s)" | nc -w 1 127.0.0.1 2003
  sleep 1
done