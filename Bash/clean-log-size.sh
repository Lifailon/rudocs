#!/bin/bash
# dd if=/dev/zero of=/var/log/test.log count=11 bs=1M # создать файл заполненный нулями указанного размера
find /var/log -type f -name "*.log" -size +10M -exec rm -f {} \; # удалить все лог-файлы, объёмом больше 10 Мбайт