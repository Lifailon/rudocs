#!/bin/bash

# Переменные: название образа и файла для внесения изменений
imageName=lifailon/docker-socket-proxy:arm64
fileName=haproxy.cfg

# Экспортируем и распаковываем образ
docker save $imageName -o image.tar
mkdir image && cd image
tar -xf ../image.tar
ls
# blobs  index.json  manifest.json  oci-layout  repositories

# Ищем файл в слоях
for blob in blobs/sha256/*; do
  if file "$blob" | grep -q "tar archive"; then
    if tar -tf "$blob" 2>/dev/null | grep -q "$fileName"; then
      echo "Blob path: $blob"
      filePath=$(tar -tf "$blob" | grep "$fileName")
      echo "File path: $filePath"
      break
    fi
  fi
done

# Распаковываем слой и вносим изменения в файл
hashOld=$(basename $blob)
sizeOld=$(stat -c%s $blob)
mkdir layer
tar -xf "$blob" -C layer/
nano "layer/$filePath"

# Упаковываем слой обратно в архив (получаем новый hash и размер)
tar -C layer/ -cf layer.tar .
rm -rf layer
hashNew=$(sha256sum layer.tar | cut -f 1 -d " ")
mv layer.tar $hashNew
sizeNew=$(stat -c%s $hashNew)

# Заменяем старый слой на новый
mv $hashNew blobs/sha256/
rm blobs/sha256/$hashOld

echo -e "\nСписок слоев и их размер до обновления манифеста:\n"
cat manifest.json | jq
# Обновляем хеш и размер слоя в манифесте
sed "s/$hashOld/$hashNew/g" -i manifest.json
sed "s/$sizeOld/$sizeNew/g" -i manifest.json
echo -e "\nCписок слоев и их размер после обновления:\n"
cat manifest.json | jq

# Находим хеш конфигурации индекса и обновляем его в blobs
indexHash=$(cat index.json | jq -r .manifests[0].digest)
indexHashOld=${indexHash#*:}
indexPath=$(echo "blobs/sha256/$indexHashOld")
indexSizeOld=$(stat -c%s $indexPath)
# cat $indexPath | jq
sed "s/$hashOld/$hashNew/g" -i $indexPath
sed "s/$sizeOld/$sizeNew/g" -i $indexPath
# cat $indexPath | jq
indexHashNew=$(sha256sum $indexPath | cut -f 1 -d " ")
indexSizeNew=$(stat -c%s $indexPath)
mv $indexPath blobs/sha256/$indexHashNew

# Обновляем хеш конфигурации в файле индекса
# cat index.json | jq
sed "s/$indexHashOld/$indexHashNew/g" -i index.json
sed "s/$indexSizeOld/$indexSizeNew/g" -i index.json
# cat index.json | jq

# Находим хеш конфигурации манифеста и обновляем его в blobs
manifestConfigHashPath=$(cat manifest.json | jq -r '.[0].Config')
manifestConfigHash=$(basename $manifestConfigHashPath)
manifestConfigSize=$(stat -c%s "$manifestConfigHashPath")
# Внутри конфигурации манифеста можно изменить Env и отобразить history (все команды при сборке Dockerfile)
echo -e "\nСписок слоев из rootfs diff в конфигурации манифеста до обновления:\n"
cat $manifestConfigHashPath  | jq -r .rootfs.diff_ids[]
# Обновляем хеш слоя на новый в директиве порядка сборки
sed "s/$hashOld/$hashNew/g" -i $manifestConfigHashPath
echo -e "\nСписок слоев из rootfs diff в конфигурации манифеста после обновления:\n"
cat $manifestConfigHashPath  | jq -r .rootfs.diff_ids[]

# Обновляем хеш конфигурации в файле манифесте
manifestConfigHashNew=$(sha256sum "$manifestConfigHashPath" | cut -f 1 -d " ")
manifestConfigSizeNew=$(stat -c%s "$manifestConfigHashPath")
mv $manifestConfigHashPath blobs/sha256/$manifestConfigHashNew
sed -i "s/$manifestConfigHash/$manifestConfigHashNew/g" manifest.json
sed -i "s/$manifestConfigSize/$manifestConfigSizeNew/g" manifest.json

# Упаковываем содержимое образа в архив
cd ..
tar -cf image_new.tar -C image/ .
rm -rf image image.tar

# Загружаем образ в систему
docker load -i image_new.tar