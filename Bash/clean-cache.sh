#!/bin/bash

cat /proc/meminfo | grep Dirty
# Принудительно заставляет систему записать все данные (Dirty) из памяти на физический диск 
sync
cat /proc/meminfo | grep Dirty

cat /proc/meminfo | grep -iE "^cache|^buff"
# Очистить только кеш файловых данных (PageCache)
echo 1 | sudo tee /proc/sys/vm/drop_caches
# Очистить кеш структуры каталогов
# echo 2 | sudo tee /proc/sys/vm/drop_caches
# Полная очистка всех кешей (1+2)
# echo 3 | sudo tee /proc/sys/vm/drop_caches
cat /proc/meminfo | grep -iE "^cache|^buff"