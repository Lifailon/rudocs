#!/bin/bash

# Создать файл заполненный нулями указанного размера
# dd if=/dev/zero of=/var/log/test.log count=11 bs=1M

# Удалить все лог-файлы, объёмом больше 10 Мбайт
find /var/log -type f -name "*.log" -size +10M -exec rm -f {} \;

# Создать файл с указанной датой создания
# touch -t 202306222200.15 /tmp/test.txt

# Удалить все файлы, которые не изменялись больше 30 дней
# find /tmp -type f -mtime +30 -exec rm -f {} \;