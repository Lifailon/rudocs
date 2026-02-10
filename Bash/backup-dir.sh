#!/bin/bash

source_directory="/home/lifailon"
backup_directory="/backup"
backup_name="$(echo $source_directory | sed -r "s/.+\///")-$(date +"%d.%m.%Y-%H:%M").tar.gz"
# Проверка присутствия директории
if [ ! -d "$backup_directory" ]; then
    mkdir -p "$backup_directory"
fi
tar czf "$backup_directory/$backup_name" -C "$source_directory" .
# Проверка выполнения последней команды
if [ $? -eq 0 ]; then
    echo "Successfully: $backup_name"
else
    echo "Error"
fi