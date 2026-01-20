source_directory="/home/lifailon"
backup_directory="/backup"
backup_name="$(echo $source_directory | sed -r "s/.+\///")-$(date +"%d.%m.%Y-%H:%M").tar.gz"
if [ ! -d "$backup_directory" ] # проверка существования директории
    then
    mkdir -p "$backup_directory"
fi
tar czf "$backup_directory/$backup_name" -C "$source_directory" .
if [ $? -eq 0 ] # проверка выполнения последней команды
    then
    echo "Successfully: $backup_name"
else
    echo "Error"
fi