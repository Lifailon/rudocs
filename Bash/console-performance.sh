#!/bin/bash
function Console-Performance() {
    while true; do
        #data=$(uptime | awk '{print $10,$11,$12}' | awk -F',' '{print $1,$2,$3}')
        data=$(date +"%H:%M:%S")
        tput sc                                   # Сохраняем положение курсора
        tput cup 0 $(( $(tput cols) - ${#data} )) # Перемещаем курсор в нужное место
        tput civis                                # Скрыть курсор
        echo -n "$data"                           # Выводим uptime
        tput rc                                   # Восстанавливаем положение курсора
        tput cnorm                                # Показать курсор
        sleep 1
    done
}

Console-Performance &
# kill %1