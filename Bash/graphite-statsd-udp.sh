#!/bin/bash

# StatsD (UDP)
# Формат: метрика:значение|type
# g (gauge) - запоминает последнее число
# c (counter) - счетчик, которй суммирует значение
# ms (timer) - считает среднее или перцентили
# s (set) - считает количество уникальных записей
# Хранятся в stats и stats_counts по указанном пути через точку

while true; do
  echo "test.dev.random:$(($RANDOM % 100))|c" | nc -u 127.0.0.1 8125
  sleep 1
done