<p align="center">
    <a href="https://github.com/Lifailon/PS-Commands"><img title="PS-Commands Logo"src="Logo/devops-tools.png"></a>
</p>

<p align="center">
    Заметки по инструментам направления <b>DevOps</b>.
</p>

---

<h2 align="left">
    Навигация:
</h2>

- [Git](#git)
- [Docker](#docker)
  - [WSL](#wsl)
  - [Install](#install)
  - [Proxy](#proxy)
  - [Mirror](#mirror)
  - [Nexus](#nexus)
  - [Run](#run)
  - [Update](#update)
  - [Stats](#stats)
  - [Logs](#logs)
  - [Volume](#volume)
  - [Network](#network)
  - [Inspect](#inspect)
  - [Exec](#exec)
  - [Prune](#prune)
  - [Remove](#remove)
  - [Diff](#diff)
  - [Docker Socket API](#docker-socket-api)
  - [Docker TCP API](#docker-tcp-api)
  - [Context](#context)
  - [dcm](#dcm)
  - [ctop](#ctop)
  - [Dockly](#dockly)
  - [LazyDocker](#lazydocker)
  - [Lazyjournal](#lazyjournal)
  - [Push](#push)
  - [Buildx](#buildx)
- [Dockerfile](#dockerfile)
- [Compose](#compose)
  - [Uptime-Kuma](#uptime-kuma)
  - [Dozzle](#dozzle)
  - [Watchtower](#watchtower)
  - [Portainer](#portainer)
- [Docker.DotNet](#dockerdotnet)
- [Swarm](#swarm)
- [Kubernetes](#kubernetes)
  - [K3s](#k3s)
  - [Dashboard](#dashboard)
  - [Micro8s](#micro8s)
  - [Minikube](#minikube)
  - [kubectl](#kubectl)
  - [Deployment](#deployment)
  - [HPA](#hpa)
  - [Ingress](#ingress)
  - [Secrets](#secrets)
  - [Kompose](#kompose)
  - [k9s](#k9s)
- [GitHub API](#github-api)
- [GitHub Actions](#github-actions)
  - [Runner (Agent)](#runner-agent)
  - [Build (Pipeline)](#build-pipeline)
  - [CI](#ci)
  - [Logs](#logs-1)
  - [act](#act)
- [Vercel](#vercel)
  - [CD](#cd)
- [GitLab](#gitlab)
- [Jenkins](#jenkins)
  - [API](#api)
  - [Plugins](#plugins)
  - [SSH Steps and Artifacts](#ssh-steps-and-artifacts)
  - [Upload File Parameter](#upload-file-parameter)
  - [Input Text and File](#input-text-and-file)
  - [HttpURLConnection](#httpurlconnection)
  - [httpRequest](#httprequest)
  - [Active Choices Parameter](#active-choices-parameter)
  - [Vault](#vault)
  - [Email Extension](#email-extension)
  - [Parallel](#parallel)
- [Groovy](#groovy)
- [Ansible](#ansible)
  - [Hosts](#hosts)
  - [Windows Modules](#windows-modules)
  - [Jinja](#jinja)
- [Puppet](#puppet)
  - [Bolt](#bolt)
- [Sake](#sake)
- [DSC](#dsc)
- [Secret Manager](#secret-manager)
  - [Bitwarden](#bitwarden)
  - [Infisical](#infisical)
  - [HashiCorp/Vault](#hashicorpvault)
  - [HashiCorp/Consul](#hashicorpconsul)
- [Prometheus](#prometheus)
  - [PromQL Functions](#promql-functions)

---

## Git

`git --version` \
`git config --global user.name "Lifailon"` добавить имя для коммитов \
`git config --global user.email "lifailon@yandex.ru"` \
`git config --global --edit` \
`git config --global core.editor "code --wait"` изменить редактор коммитов по умолчанию \
`ssh-keygen -t rsa -b 4096` \
`Get-Service | where name -match "ssh-agent" | Set-Service -StartupType Automatic` \
`Get-Service | where name -match "ssh-agent" | Start-Service` \
`Get-Service | where name -match "ssh-agent" | select Name,Status,StartType` \
`ssh-agent` \
`ssh-add C:\Users\Lifailon\.ssh\id_rsa` \
`cat ~\.ssh\id_rsa.pub | Set-Clipboard` copy to [settings keys](https://github.com/settings/keys) \
`cd $home\Documents\Git` \
`git clone git@github.com:Lifailon/lifailon.github.io` \
`cd lifailon.github.io` \
`git grep "ping ya.ru"` поиск текста в файлах \
`git fetch` загрузить изменения из удаленного хранилища для обновления всех веток локального репозитория, не затрагивая текущую рабочую ветку (загружает все коммиты, ветки и т.д. которые не присутствуют в локальном репозитории) \
`git fetch --all` загрузить все ветки с удаленного репозитория (обновляет информацию о состоянии удаленного репозитория и загружает все изменения ваших веток без автоматического объединения) \
`git pull` загрузить изменения из удаленного хранилища для обновления локального репозитория (выполняет `git fetch`, чтобы получить последние изменения из удаленного репозитория, а затеим объеденяем изменения с локальной копией с помощью `git merge` для обновления текущей рабочей ветки) \
`git stash` сохраняет текущие незакоммиченные изменения в временное хранилище (например, на время выполнения `git pull`), в т.ч. неотслеживаемые файлы и очищает рабочую директорию (вернет в состояние, соответствующее последнему коммиту) \
`git stash pop` применяет последние изменения из стэша к текущей ветке (вернутся только измененные строки в файлах, при этом будут сохранены новые добавленные строки в файле без конфликтов) и удаляет их из стэша \
`git stash apply` применяет изменения, но не удаляет их из стэша \
`git status` отобразить статус изменений по файлам \
`git diff` отобразить историю изменений построчно \
`git diff pandoc` сравнивает изменения в текущей рабочей директории с последним коммитом в указанной ветке `pandoc` \
`git add .` добавить (проиндексировать) изменения во всех файлах текущего каталога \
`git commit -m "update powershell commands"` сохранить изменения с комментарием \
`git push` синхронизировать локальные изменения с репозиторием на сервере \
`git push origin mkdocs-material` отправить в конкретную ветку \
`git push origin --delete mkdocs` удалить ветку на удаленном сервере \
`git commit --amend` изменить комментарий в последнем коммите (до `push`) \
`git commit --amend --no-edit --date="Sun Oct 27 23:20:00 2024 +0300"` изменить дату последнего коммита \
`git branch -a` отобразить все ветки (в том числе удаленные remotes/origin) \
`git branch hugo` создать новую ветку \
`git branch -m hugo-public` переименовать текущую ветку \
`git branch -d hugo-public` удалить ветку \
`git switch hugo` переключиться на другую ветку \
`git push origin hugo` отправить изменения в указанную ветку \
`git branch --set-upstream-to=origin/hugo hugo` локальная ветка `hugo` будет отслеживать удаленную ветку `hugo` на удаленном сервере-репозитории `origin` (позволяет не указывать название удаленной ветки при каждом использовании команд `git push` или `git pull`) \
`git switch pandoc` переключиться на другую ветку \
`git merge hugo` слияние указанной ветки (`hugo`) в текущую ветку (`pandoc`)  \
`git log --oneline --all` отобразить список всех коммитов и их сообщений \
`git log --graph` коммиты и следование веток \
`git log --author="Lifailon"` показывает историю коммитов указанного пользователя \
`git blame .\posh.md` показывает, кто и когда внес изменения в каждую строку указанного файла (`НОМЕР_КОММИТА (ИМЯ_ПОЛЬЗОВАТЕЛЯ ДАТА НОМЕР_СТРОКИ) ТЕКСТ.`) \
`git show d01f09dead3a6a8d75dda848162831c58ca0ee13` отобразить подробный лог по номеру коммита \
`git checkout filename` устаревшая команда, откатить не проиндексированные изменения для коммита, возвращая его к состоянию, каким оно было на момент последнего коммита (если не было индексации через `add`) \
`git restore filename` отменить все локальные изменения в рабочей копии независимо от того, были они проиндексированы или нет (через `add`), возвращая его к состоянию на момент последнего коммита \
`git restore --source d01f09dead3a6a8d75dda848162831c58ca0ee13 filename` восстановить файл на указанную версию по хэшу индентификатора коммита \
`git reset HEAD filename` удалить указанный файл из индекса без удаления самих изменений в файле для последующей повторной индексации (если был `add` но не было `commit`, потом выполнить `checkout`) \
`git reset --soft HEAD^` отменяет последний (^) коммит, сохраняя изменения из этого коммита в рабочем каталоге и индексе (подготовленной области), можно внести изменения в файлы и повторно их зафиксировать через `commit` \
`git reset --hard HEAD^` полностью отменяет последний коммит, удаляя все его изменения из рабочего каталога и индекса до состояния предыдущего перед последним коммитом (аналогично `HEAD~1`) \
`git push origin main --force` удалить последний коммит на удаленном сервере репозитория после `reset --hard HEAD^`  \
`git reset --hard d01f09dead3a6a8d75dda848162831c58ca0ee13` откатывает изменения к указанному коммиту и удаляет все коммиты, которые были сделаны после него (будут потеряны все незакоммиченные изменения и историю коммитов после указанного) \
`git revert HEAD --no-edit` создает новый коммит, который отменяет последний коммит (`HEAD^`) и новый коммит будет добавлен поверх него (события записываются в `git log`) \
`git revert d01f09dead3a6a8d75dda848162831c58ca0ee13` создает новый коммит, который отменяет изменения, внесенные в указанный коммит с хешем (не изменяет историю коммитов, а создает новый коммит с изменениями отмены)

## Docker

### WSL

`wsl --list` список установленных дистрибутивов Linux \
`wsl --list --online` список доступных дистрибутивов \
`wsl --install -d Ubuntu` установить Ubuntu в Windows Subsystem for Linux \
`wsl --status` \
`wsl --exec "htop"` выполнить команду в подсистеме Linux по умолчанию \
`wsl -e bash -c "docker -v"` \
`wsl -e bash -c "systemctl status docker"`

### Install

`apt update && apt upgrade -y` \
`apt install docker.io` \
`systemctl status docker` \
`systemctl start docker` \
`systemctl enable docker` \
`iptables -t nat -N DOCKER` \
`docker -v` \
`docker -h`

`sudo usermod -aG docker lifailon` добавить пльзователя в группу docker \
`newgrp docker` применить изменения в группах

`curl https://registry-1.docker.io/v2/` проверить доступ к Docker Hub \
`curl -s -X POST -H "Content-Type: application/json" -d '{"username": "lifailon", "password": "password"}' https://hub.docker.com/v2/users/login | jq -r .token > dockerToken.txt` получить временный токен доступа для авторизации \
`sudo docker login` вход в реестр репозитория hub.docker.com \
`cat dockerToken.txt | sudo docker login --username lifailon --password-stdin` передать токен авторизации (https://hub.docker.com/settings/security) из файла через stdin \
`cat /root/.docker/config.json | jq -r .auths[].auth` место хранения токена авторизации в системе \
`cat /root/.docker/config.json | python3 -m json.tool`

### Proxy
```bash
mkdir -p /etc/systemd/system/docker.service.d
```
Создаем дополнительную конфигурацию для службы Docker в файле `/etc/systemd/system/docker.service.d/http-proxy.conf`:
```
[Service]
Environment="HTTP_PROXY=http://docker:password@192.168.3.100:9090"
Environment="HTTPS_PROXY=http://docker:password@192.168.3.100:9090"
```
`systemctl daemon-reload` \
`systemctl restart docker`

### Mirror

`echo '{ "registry-mirrors": ["https://dockerhub.timeweb.cloud"] }' > "/etc/docker/daemon.json"` \
`echo '{ "registry-mirrors": ["https://huecker.io"] }' > "/etc/docker/daemon.json"` \
`echo '{ "registry-mirrors": ["https://mirror.gcr.io"] }' > "/etc/docker/daemon.json"` \
`echo '{ "registry-mirrors": ["https://daocloud.io"] }' > "/etc/docker/daemon.json"` \
`echo '{ "registry-mirrors": ["https://c.163.com"] }' > "/etc/docker/daemon.json"`

`systemctl restart docker`

### Nexus

Разрешает небезопасные HTTP-соединения с Nexus сервером (если не использует HTTPS):
```bash
echo -e '{\n  "insecure-registries": ["http://192.168.3.105:8882"]\n}' | sudo tee "/etc/docker/daemon.json"
sudo systemctl restart docker
```
`docker login 192.168.3.105:8882` авторизируемся в репозитории Docker Registry на сервере Nexus \
`docker tag lifailon/docker-web-manager:latest 192.168.3.105:8882/docker-web-manager:latest` создаем тег с прявязкой сервера \
`docker push 192.168.3.105:8882/docker-web-manager:latest` загружаем образ на сервер Nexus

`curl -sX GET http://192.168.3.105:8882/v2/docker-web-manager/tags/list | jq` отобразить список доступных тегов \
`docker pull 192.168.3.105:8882/docker-web-manager:latest` загрузить образ из Nexus

### Run 

Commands: `search/pull/images/creat/start/ps/restart/pause/unpause/rename/stop/kill/rm/rmi`

`docker search speedtest` поиск образа в реестре \
`docker pull adolfintel/speedtest` скачать образ LibreSpeed из реестра Docker Hub (https://hub.docker.com/r/adolfintel/speedtest) \
`docker images (docker image ls)` отобразить все локальные (уже загруженные) образы docker (`image ls`) \
`docker images --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}"` отфильтровать вывод (json-формат) \
`docker create -it --name speedtest -p 8080:80 adolfintel/speedtest` создать контейнер из образа adolfintel/speedtest с именем speedtest и проброс 80 порта контейнера на 8080 порт хоста \
`docker start speedtest` запустить созданный контейнер \
`ss -ltp | grep 8080` проверить, что порт открыт \
`docker ps` отобразить все запущенные докер контейнеры \
`docker ps -a` список всех существующих контейнеров (для их запуска/удаления по NAMES/ID и код выхода Exited 0 - успешная остановка) \
`docker ps -s` размер контейнеров (--size) \
`docker restart speedtest` перезапустить контейнер \
`docker pause speedtest` приостановить контейнер \
`docker unpause uptime-kuma` возобновить работу контейнера \
`docker rename speedtest speedtest-2` переименоввать контейнер (`docker rename old_name new_name`) \
`docker stop speedtest-2` остановить работающий контейнер с отправкой главному процессу контейнера сигнал `SIGTERM`, и через время `SIGKILL` \
`docker kill uptime-kuma` остановить работающий контейнер с отправкой главному процессу контейнера сигнал `SIGKILL` \
`docker kill $(docker ps -q)` остановить все контейнеры \
`docker rm speedtest-2` удалить контейнер \
`docker rmi adolfintel/speedtest` удалить образ \
`docker run -p 8443:8443 -it --entrypoint /bin/sh container_name` запустить контейнер и подключиться к нему (даже если контейнер уходит в ошибку при запуске)  \
`docker run -d --restart=unless-stopped --name openspeedtest -p 3000:3000 -p 3001:3001 openspeedtest/latest` загрузить образ OpenSpeedTest (https://hub.docker.com/r/openspeedtest/latest), создать контейнер и запустить в одну команду в фоновом режиме (-d/--detach, терминал возвращает контроль сразу после запуска контейнера, если не используется, можно видеть логи, но придется остановить контейнер для выхода) \
`docker rm openspeedtest && docker rmi openspeedtest/latest` удаляем контейнер и образ в одну команду \
`docker run --name pg1 -p 5433:5432 -e POSTGRES_PASSWORD=PassWord -d postgres` создать контейнер postgres (https://hub.docker.com/_/postgres) с параметрами (-e) \
`docker run -d --restart=always --name uptime-kuma -p 8080:3001 louislam/uptime-kuma:1` создать и запустить контейнер Uptime-Kuma (https://hub.docker.com/r/elestio/uptime-kuma) в режиме always, при котором контейнер должен перезапускаться автоматически, если он остановится или если перезапустится Docker (например, после перезагрузки хоста) \
`docker history openspeedtest:latest` отображает слои образа, их размер и команды, которые были выполнены при его создании

### Alias
```bash
alias docker-all-start='docker ps -aq --filter "status=exited" | xargs -P 4 -I {} docker start {}' # параллельный запуск всех остановленных контейнеров со статус выхода exited
alias docker-all-stop='docker ps -aq | xargs -P 4 -I {} docker stop {}' # остановить все работающие контейнеры
alias docker-all-restart='docker ps -aq | xargs -P 4 -I {} docker restart {}' # перезапустить все контейнеры
```
### Update

`docker update --restart unless-stopped uptime-kuma` изменить режим перезапуска контейнера после его остановки на unless-stopped (режим аналогичен always, но контейнер не будет перезапущен, если он был остановлен вручную с помощью docker stop) \
`docker update --restart on-failure uptime-kuma` контейнер будет перезапущен только в случае его завершения с ошибкой, когда код завершения отличается от 0, через двоеточие можно указать количество попыток перезапуска (например, on-failure:3) \
`docker update --cpu-shares 512 --memory 500M uptime-kuma` задать ограничения по CPU, контейнер будет иметь доступ к указанной доле процессорного времени в диапазоне от 2 до 262,144 (2^18) или --cpus (количество процессоров), --memory/--memory-swap и --blkio-weight для IOps (относительный вес от 10 до 1000)

### Stats

`docker stats` посмотреть статистику потребляемых ресурсов запущенными контейнерами (top) \
`docker stats --no-stream --format json` вывести результат один раз в формате json

### Logs

`docker logs uptime-kuma --tail 100` показать логи конкретного запущенного контейнера в терминале (последние 100 строк) \
`docker system events` предоставляют события от демона dockerd в реальном времени \
`journalctl -xeu docker.service` \
`docker system df` отобразить сводную информацию занятого пространства образами и контейнерами \
`du -h --max-depth=1 /var/lib/docker` \
`du -h --max-depth=2 /var/lib/docker/containers`
```bash
docker run \
  --log-driver json-file \
  --log-opt max-size=10m \
  --log-opt max-file=3 \
  container_name
```
Настройка логирования в docker compose:
```yml
logging:
      driver: "json-file" # Стандартный драйвер логов Docker
      options:
        max-size: "10m"   # Максимальный размер каждого лог-файла (10 МБайт)
        max-file: "3"     # Максимальное количество файлов с логами (текущий и два предыдущих, Docker автоматически удаляет старые логи)

# systemd/journald
logging:
  driver: "journald"
  options:
    tag: "app_name"

# syslog/rsyslog
logging:
  driver: "syslog"
  options:
    syslog-address: "udp://127.0.0.1:514"
    tag: "app_name"

# Отправка логов в Graylog, Logstash или другие GELF-совместимые системы
logging:
  driver: "gelf"
  options:
    gelf-address: "udp://1.2.3.4:12201"
    tag: "app_name"
```
### Volume

`docker volume ls` показывает список томов и место хранения (механизмы хранения постояннымх данных контейнера на хостовой машине, которые сохраняются между перезапусками или пересозданиями контейнеров) \
`docker volume inspect uptime-kuma` подробная информация конфигурации тома (отображает локальный путь к данным в системе, Mountpoint: /var/lib/docker/volumes/uptime-kuma/_data) \
`docker volume create test` создать том \
`docker volume rm test` удалить том \
`docker run -d --restart=always --name uptime-kuma -p 8080:3001 -v uptime-kuma:/app/data louislam/uptime-kuma:1` создать и запустить контейнер на указанном томе (том создается автоматически, в дальнейшем его можно указывать при создании контейнера, если необходимо загружать из него сохраненные данные)

Временная файловая система для хранения данных в оперативной памяти (исчезают после остановки контейнера):
```yml
volumes:
  ram_disk:
    driver_opts:
      type: "tmpfs"
      device: "tmpfs"
      o: "size=512m,uid=1000"
```
Монтирование `NFS` (без необходимости предварительного монтирования на хосте) через драйвер `opts`:
```yml
volumes:
  nfs_volume:
    driver_opts:
      type: "nfs"
      o: "addr=192.168.3.106,nolock,soft,nfsvers=4"
      device: ":/backup" # путь к NFS-шаре на сервере
```
Монтирование `SMB` каталога:

`sudo apt install cifs smbclient -y` \
`smbclient //192.168.3.100/backup -U guest%` првоерить гостевой доступ \
`sudo mkdir /mnt/smb_backup && sudo chown -R 1000:1000 /mnt/smb_backup` создать директорию для монтирования \
`echo "//192.168.3.100/backup /mnt/smb_backup cifs username=guest,password=,uid=1000,gid=1000,rw,vers=3.0 0 0" | sudo tee -a /etc/fstab` \
`mount -a && systemctl daemon-reload && df -h` примонтировать (применить все записи из fstab)
```yml
volumes:
  - /mnt/smb_backup:/data
```
### Network

`docker network ls` список сетей \
`docker network inspect bridge` подробная информация о сети bridge \
`docker inspect uptime-kuma | jq .[].NetworkSettings.Networks` узнать наименование сетевого адаптера указанного контейнера \
`docker run -d --name uptime-kuma --network host nginx louislam/uptime-kuma:1` запуск контейнера с использованием host сети, которая позволяет контейнеру использовать сеть хостовой машины \
`docker network create network_test` создать новую сеть \
`docker network connect network_test uptime-kuma` подключить работающий контейнер к указанной сети \
`docker network disconnect network_test uptime-kuma` отключить от сети

### Inspect

`docker inspect uptime-kuma` подробная информация о контейнере (например, конфигурация NetworkSettings) \
`docker inspect uptime-kuma --format='{{.LogPath}}'` показать, где хранятся логи для конкретного контейнера в локальной системе \
`docker inspect uptime-kuma | grep LogPath` \
`docker inspect $(docker ps -q) --format='{{.NetworkSettings.Ports}}'` отобразить TCP порты всех запущенных контейнеров \
`docker inspect $(docker ps -q) --format='{{.NetworkSettings.Ports}}' | grep -Po "[0-9]+(?=}])"` отобразить порты хоста (внешние) \
`docker port uptime-kuma` отобразить проброшенные порты контейнера \
`for ps in $(docker ps -q); do docker port $ps | sed -n 2p | awk -F ":" '{print $NF}'; done` отобразить внешние порты всех запущенных контейнеров \
`id=$(docker inspect uptime-kuma | jq -r .[].Id)` узнать ID контейнера по его имени в конфигурации \
`cat /var/lib/docker/containers/$id/config.v2.json | jq .` прочитать конфигурационный файл контейнера

### Exec

`docker exec -it uptime-kuma /bin/bash` подключиться к работающему контейнеру (при выходе из оболочки, контейнер будет работать), используя интерпритатор bash \
`docker top uptime-kuma` отобразить работающие процессы контейнера \
`docker exec -it --user root uptime-kuma bash apt-get install -y procps` авторизоваться под пользователем root и установить procps \
`docker exec -it uptime-kuma ps -aux` отобразить работающие процессы внутри контейнера \
`docker exec uptime-kuma kill -9 25055` убить процесс внутри контейнера \
`docker exec -it uptime-kuma ping 8.8.8.8` \
`docker exec -it uptime-kuma pwd` \
`docker cp ./Console-Performance.sh uptime-kuma:/app` скопировать из локальной системы в контейнер \
`docker exec -it uptime-kuma ls` \
`docker cp uptime-kuma:/app/db/ backup/db` сокпировать из контейнера в локальную систему \
`ls backup/db`

### Prune

`docker network prune && docker image prune && docker volume prune && docker container prune` удалить все неиспользуемые сети, висящие образа, остановленные контейнеры, все неиспользуемые тома \
`system prune –volumes` заменяет все четыре команды для очистки и дополнительно очищает кеш сборки

### Remove

`systemctl stop docker.service` \
`systemctl stop docker.socket` \
`pkill -f docker` \
`pkill -f containerd` \
`apt purge docker.io -y || dpkg --purge docker.io` \
`dpkg -l | grep docker` \
`rm -rf /var/lib/docker` \
`rm -rf /run/docker` \
`rm -rf /run/docker.sock`

### Diff

`docker diff <container_id_or_name>` отображает изменения, внесённые в файловую систему контейнера по сравнению с исходным образом

`A` — добавленные файлы \
`C` — изменённые файлы \
`D` — удалённые файлы

### Docker Socket API

`curl --silent -XGET --unix-socket /run/docker.sock http://localhost/version | jq .` использовать локальный сокет (/run/docker.sock) для взаимодействия с Docker daemon через его API \
`curl --silent -XGET --unix-socket /run/docker.sock http://localhost/info | jq .` количество образов, запущенных и остановленных контейнеров и остальные метрики ОС \
`curl --silent -XGET --unix-socket /run/docker.sock http://localhost/events` логи Docker daemon \
`curl --silent -XGET --unix-socket /run/docker.sock -H "Content-Type: application/json" http://localhost/containers/json | jq .` список работающих контейнеров и их параметры конфигурации \
`curl --silent -XGET --unix-socket /run/docker.sock http://localhost/containers/uptime-kuma/json | jq .` подробные сведения (конфигурация) контейнера \
`curl --silent -XPOST --unix-socket /run/docker.sock -d "{"Image":"nginx:latest"}" http://localhost/containers/create?name=nginx` создать контейнер с указанным образом в теле запроса (должен уже присутствовать образ) \
`curl --silent -XPOST --unix-socket /run/docker.sock http://localhost/containers/17fab06a820debf452fe685d1522a9dd1611daa3a5087ff006c2dabbe25e52a1/start` запустить контейнер по Id \
`curl --silent -XPOST --unix-socket /run/docker.sock http://localhost/containers/17fab06a820debf452fe685d1522a9dd1611daa3a5087ff006c2dabbe25e52a1/stop` остановить контейнер \
`curl --silent -XDELETE --unix-socket /run/docker.sock http://localhost/containers/17fab06a820debf452fe685d1522a9dd1611daa3a5087ff006c2dabbe25e52a1` удалить контейнер

### Docker TCP API
```bash
echo '{
    "hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]
}' > "/etc/docker/daemon.json"
service=$(cat /lib/systemd/system/docker.service | sed "s/ -H fd:\/\///")
printf "%s\n" "$service" > /lib/systemd/system/docker.service
systemctl daemon-reload
systemctl restart docker
```
`curl --silent -XGET http://192.168.3.102:2375/version | jq .`

Конечная точка `/metrics` для Prometheus:
```yaml
{
  "metrics-addr": "0.0.0.0:9323"
}
```
`curl http://192.168.3.102:9323/metrics`

### Context

`docker context create rpi-106 --docker "host=tcp://192.168.3.106:2375"` добавить подключение к удаленному хосту через протокол `TCP` \
`docker context create rpi-106 --docker "host=ssh://lifailon@192.168.3.106:2121"` добавить подключение к удаленному хосту через протокол `SSH` \
`docker context ls` список всех доступных контекстов (`*` отображается текущий) \
`docker context inspect rpi-106` конфигурация указанного контекста \
`docker context use rpi-106` переключиться на выбранный контекст (возможно на прямую взаимосдействовать с удаленным Docker Engine через cli, за исключением взаимодействия через Socket) \
`docker context rm rpi-106` удалить контекст

### dcm

`dcm` (Docker Context Manager) - это простая реализация TUI интерфейса на базе [fzf](https://github.com/junegunn/fzf), для переключения контекста из перечисленного списка хостов. Т.к. для использовать TUI интерфейсов требуется взаимодействие с сокетом, недостаточно изменить только переменную `DOCKER_HOST` или использовать команду `docker context`, по этому используется механиз `ssh forwarding`, который пробрасывает сокета с удаленной машины в локальную систему (используется временный файл, с изменением пути в переменной окружения).

```bash
DCM_SSH_HOSTS=localhost,192.168.3.105,192.168.3.106
DCM_SSH_USER=lifailon
DCM_SSH_PORT=2121
DCM_SOCKET_PATH=/tmp/remote-docker.sock

# dcm (Docker Context Manager)
function dcm() {
    DCM_SSH_HOST=$(printf "%s\n" ${DCM_SSH_HOSTS//,/ } | fzf --exact --no-sort --height 20 --reverse)
    if [ -n "$DCM_SSH_HOST" ]; then
        if [ $DCM_SSH_HOST == "localhost" ]; then
            pkill -f "ssh -fNL $DCM_SOCKET_PATH"
            ps aux | grep "[s]sh -fNL" > /dev/null 2>&1 && echo -e "\e[31mError: socket not stopped\e[0m"
            rm -f /tmp/remote-docker.sock
            ls $DCM_SOCKET_PATH > /dev/null 2>&1 && echo -e "\e[31mError: socket not deleted\e[0m"
            unset DOCKER_HOST
        else
            pkill -f "ssh -fNL $DCM_SOCKET_PATH"
            ps aux | grep "[s]sh -fNL" > /dev/null 2>&1 && echo -e "\e[31mError: socket not stopped\e[0m"
            rm -f /tmp/remote-docker.sock
            ls $DCM_SOCKET_PATH > /dev/null 2>&1 && echo -e "\e[31mError: socket not deleted\e[0m"
            ssh -fNL $DCM_SOCKET_PATH:/var/run/docker.sock "$DCM_SSH_USER@$DCM_SSH_HOST" -p $DCM_SSH_PORT
            export DOCKER_HOST="unix://$DCM_SOCKET_PATH"
            ps aux | grep "[s]sh -fNL" 1> /dev/null || echo -e "\e[31mError: socket not forwarded\e[0m"
        fi
    fi
}

# lazydocker over dcm
alias ld=lazydocker
function dcl() {
    DCM_SSH_HOST=$(printf "%s\n" ${DCM_SSH_HOSTS//,/ } | fzf --exact --no-sort --height 20 --reverse)
    if [ -n "$DCM_SSH_HOST" ]; then
        # Delete socket 
        pkill -f "ssh -fNL $DCM_SOCKET_PATH"
        ps aux | grep "[s]sh -fNL" > /dev/null 2>&1 && echo -e "\e[31mError: socket not stopped\e[0m"
        rm -f /tmp/remote-docker.sock
        ls $DCM_SOCKET_PATH > /dev/null 2>&1 && echo -e "\e[31mError: socket not deleted\e[0m"
        # Create socket
        ssh -fNL $DCM_SOCKET_PATH:/var/run/docker.sock "$DCM_SSH_USER@$DCM_SSH_HOST" -p $DCM_SSH_PORT
        export DOCKER_HOST="unix://$DCM_SOCKET_PATH"
        ps aux | grep "[s]sh -fNL" 1> /dev/null || echo -e "\e[31mError: socket not forwarded\e[0m"
        ld
        # Delete socket 
        pkill -f "ssh -fNL $DCM_SOCKET_PATH"
        ps aux | grep "[s]sh -fNL" > /dev/null 2>&1 && echo -e "\e[31mError: socket not stopped\e[0m"
        rm -f /tmp/remote-docker.sock
        ls $DCM_SOCKET_PATH > /dev/null 2>&1 && echo -e "\e[31mError: socket not deleted\e[0m"
        unset DOCKER_HOST
    fi
}
```
### ctop

`scoop install ctop` установка в Windows (https://github.com/bcicen/ctop)
```bash
wget https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 -O /usr/local/bin/ctop
chmod +x /usr/local/bin/ctop
```
`ctop` отображает сводную таблицу (top) CPU, MEM, NET RX/TX, IO R/W \
`o` - графики \
`l` - логи контейнера в реальном времени \
`s` - stop/start \
`R` - remove после stop \
`p` - pause/unpause \
`r` - restart \
`e` - exec shell

### Dockly

`npm install -g dockly` TUI интерфейс на базе Node.js и Blessed.js \
`docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock lirantal/dockly` запуск в Docker \
`dockly`

### LazyDocker

`scoop install lazydocker || choco install lazydocker` установка в Windows (https://github.com/jesseduffield/lazydocker)
```bash
wget https://github.com/jesseduffield/lazydocker/releases/download/v0.23.1/lazydocker_0.23.1_Linux_x86.tar.gz -O ~/lazydocker.tar.gz
tar -xzf ~/lazydocker.tar.gz lazydocker
rm ~/lazydocker.tar.gz
mv lazydocker /usr/local/bin/lazydocker
chmod +x /usr/local/bin/lazydocker
```
lazydocker

### Lazyjournal

`curl -sS https://raw.githubusercontent.com/Lifailon/lazyjournal/main/install.sh | bash` установка в Unix \
`Invoke-RestMethod https://raw.githubusercontent.com/Lifailon/lazyjournal/main/install.ps1 | Invoke-Expression` установка в Windows \
`lazyjournal` \
`lazyjournal --help` \
`lazyjournal --version`

### Push

`docker login` \
`git clone https://github.com/Lifailon/TorAPI` \
`cd TorAPI` \
`docker build -t lifailon/torapi .` собрать образ для публикации на Docker Hub \
`docker push lifailon/torapi` загрузить образ на Docker Hub

`docker pull lifailon/torapi:latest` загрузить образ из Docker Hub \
`docker run -d --name TorAPI -p 8443:8443 lifailon/torapi:latest` загрузить образ и создать контейнер

### Buildx

`sudo apt install docker-buildx -y` установить систему для мультиплатформенной сборки \
`docker buildx create --use --name multiarch-builder --driver docker-container` оздать и запустить сборщик в контейнере \
`docker buildx ls` \
`docker buildx rm multiarch-builder`

`go list -u -m all && go get -u ./...` обновить пакеты приложения на Go

Добавить аргументы в Dockerfile и передать их в переменные для сборки:
```Dockerfile
ARG TARGETOS TARGETARCH
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /logporter
```
docker buildx build --platform linux/amd64,linux/arm64 .
docker buildx build --platform linux/amd64,linux/arm64 -t lifailon/logporter --push .

`npm outdated && npm update --save` обновить паеты node.jd приложения

Передаем аргументы в параметры платформы для образа:
```Dockerfile
ARG TARGETOS TARGETARCH
FROM --platform=${TARGETOS}/${TARGETARCH} node:alpine AS build
```
## Dockerfile

`FROM` указывает базовый образ, на основе которого будет создаваться новый образ \
`LABEL` добавляет метаданные к образу в формате ключ-значение \
`ENV` устанавливает переменные окружения, которые будут доступны внутри контейнера со значениями по умолчанию (можно переопределить через `-e`, который имеет повышенный приоритет) \
`ARG` определяет переменные, которые могут быть переданы и доступны только на этапе сборки образа (выполнения инструкций в dockerfile через `docker build --build-arg`) и недоступны в контейнере \
`USER` устанавливает пользователя, от имени которого будут выполняться следующие команды \
`WORKDIR` устанавливает рабочий каталог внутри контейнера для последующих команд \
`SHELL` задает командную оболочку, которая будет использоваться для выполнения команд RUN, CMD и ENTRYPOINT (по умолчанию `/bin/sh -c`, например на `SHELL ["/bin/bash", "-c"]`) \
`RUN` выполняет команды в контейнере во время сборки образа \
`COPY` копирует файлы и каталоги из указанного источника на локальной машине в файловую систему контейнера \
`ADD` копирует файлы и каталоги в контейнер, поддерживает загрузку файлов из URL и автоматическое извлечение архивов \
`CMD` определяет команду, которая будет выполняться при запуске контейнера, может быть переопределена при запуске \
`ENTRYPOINT` задает основную команду, которая будет выполняться при запуске контейнера без возможности ее переопредиления, но с возможностью передачи аргументов \
`VOLUME` создает точку монтирования для хранения данных в хостовой системе \
`EXPOSE` указывает, какие порты контейнера будут доступны извне \
`HEALTHCHECK` определяет команду для проверки состояния работающего контейнера \
`ONBUILD` задает команды, которые будут автоматически выполнены при сборке дочерних образов \
`STOPSIGNAL` определяет сигнал, который будет отправлен контейнеру для его остановки

Пример использования `ADD` для загрузки из `url`:
```bash
FROM alpine:latest
# Загрузка и распаковка архива напрямую из GitHub
ADD https://github.com/<username>/<repository>/archive/refs/heads/main.zip /app/
# Установка инструмента для работы с архивами
RUN apk add --no-cache unzip && \
    unzip /app/main.zip -d /app/ && \
    rm /app/main.zip
```
Пример сборки приложения на `node.js`:

`git clone https://github.com/Lifailon/TorAPI` \
`cd TorAPI` \
`nano Dockerfile`
```Dockerfile
# Указать базовый образ для сборки, который содержит последнюю версию Node.js и npm
FROM node:alpine AS build
# Установить рабочую директорию для контейнера (все последующие команды будут выполняться относительно этой директории)
WORKDIR /torapi
# Копирует файл package.json из текущей директории на хосте в рабочую директорию
COPY package.json ./
# Запускает команду (используя оболочку по умолчанию) для установки зависимостей, указанных в package.json
RUN npm install && npm update && npm cache clean --force
# Копирует все файлы из текущей директории на хосте в рабочую директорию контейнера
COPY . .
# Создает новый рабочий образ для создания контейнера
FROM node:alpine
WORKDIR /torapi
# Копирует только те файлы, которые необходимые для работы приложения
COPY --from=build /torapi/node_modules ./node_modules
COPY --from=build /torapi/package.json ./package.json
COPY --from=build /torapi/main.js ./main.js
COPY --from=build /torapi/swagger/swagger.js ./swagger/swagger.js
COPY --from=build /torapi/category.json ./category.json
# Определить переменные окружения по умолчанию, которые могут быть переопределены при запуске контейнера
ENV PORT=8443
ENV PROXY_ADDRESS=""
ENV PROXY_PORT=""
ENV USERNAME=""
ENV PASSWORD=""
# Открывает порт 8443 для доступа к приложению из контейнера
EXPOSE $PORT
# Определить команду для проверки работоспособности контейнера (для примера)
# Проверка будет запускаться каждые 120 секунд, если команда не завершится за 30 секунд, она будет считаться неуспешной, если команда не проходит 3 раза подряд, контейнер будет помечен как нездоровый
# Docker будет ждать 5 секунд после старта контейнера перед тем, как начать проверки здоровья
HEALTHCHECK --interval=120s --timeout=30s --retries=3 --start-period=10s \
    CMD ["sh", "-c", "npm start -- --test"]
# Устанавливает команду по умолчанию для запуска приложения при запуске контейнера
ENTRYPOINT ["sh", "-c", "npm start -- --port $PORT --proxyAddress $PROXY_ADDRESS --proxyPort $PROXY_PORT --username $USERNAME --password $PASSWORD"]
```
`docker build -t torapi .` собрать образ из dockerfile
```bash
docker run -d --name TorAPI -p 8443:8443 --restart=unless-stopped \
  -e PROXY_ADDRESS="192.168.3.100" \
  -e PROXY_PORT="9090" \
  -e USERNAME="TorAPI" \
  -e PASSWORD="TorAPI" \
  torapi
```
## Compose
```bash
mkdir -p $HOME/.local/bin
version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
curl -sSL "https://github.com/docker/compose/releases/download/$version/docker-compose-$(uname -s)-$(uname -m)" -o $HOME/.local/bin/docker-compose
chmod +x $HOME/.local/bin/docker-compose
mkdir -p $HOME/.docker/cli-plugins
cp $HOME/.local/bin/docker-compose $HOME/.docker/cli-plugins/docker-compose
docker compose version
```
### Uptime-Kuma

[Uptime-Kuma](https://github.com/louislam/uptime-kuma) - веб-интерфейс для мониторинга доступности хостов (ICMP), портов (TCP), веб-контент (HTTP/HTTPS запросы), gRPC, DNS, контейнеры Docker, базы данных и т.д с поддержкой уведомлений в Telegram.

`nano docker-compose.yml`
```yaml
services:
  uptime-kuma:
    image: louislam/uptime-kuma:latest
    container_name: uptime-kuma
    volumes:
      - uptime-kuma:/app/data
    ports:
      - "8081:3001"
    restart: unless-stopped
volumes:
  uptime-kuma:
```
`docker-compose up -d`

`kuma_db=$(docker inspect uptime-kuma | jq -r .[].Mounts.[].Source)` место хранения конфигураций в базе SQLite \
`cp $kuma_db/kuma.db $HOME/uptime-kuma-backup.db`

Сгенерировать API ключ: `http://192.168.3.101:8081/settings/api-keys` \
`curl -u":uk1_fl3JxkSDwGLzQuHk2FVb8z89SCRYq0_3JbXsy73t" http://192.168.3.101:8081/metrics`

Пример конфигурации для Prometheus:
```yaml
scrape_configs:
  - job_name: uptime-kuma
    scrape_interval: 30s
    metrics_path: /metrics
    static_configs:
      - targets:
        - '192.168.3.101:8081'
    basic_auth:
      password: uk1_fl3JxkSDwGLzQuHk2FVb8z89SCRYq0_3JbXsy73t
```
Dashboard для Grafana - [Uptime Kuma - SLA/Latency/Certs](https://grafana.com/grafana/dashboards/18667-uptime-kuma-metrics) (id 18667)

[Uptime-Kuma-Web-API](https://github.com/MedAziz11/Uptime-Kuma-Web-API) - оболочка API и Swagger документация написанная на Python с использованием FastAPI и [Uptime-Kuma-API](https://github.com/lucasheld/uptime-kuma-api).

`nano docker-compose.yml`
```yaml
services:
  # Web (frontend)
  uptime-kuma:
    container_name: uptime-kuma
    image: louislam/uptime-kuma:latest
    ports:
      - "8081:3001"
    restart: unless-stopped
    volumes:
      - ./kuma_data:/app/data

  # API (backend)
  uptime-kuma-api:
    container_name: uptime-kuma-api
    image: medaziz11/uptimekuma_restapi
    volumes:
      - ./kuma_api:/db
    restart: unless-stopped
    environment:
      - KUMA_SERVER=http://uptime-kuma:3001
      - KUMA_USERNAME=admin
      - KUMA_PASSWORD=KumaAdmin
      - ADMIN_PASSWORD=KumaApiAdmin
    depends_on:
      - uptime-kuma
    ports:
      - "8082:8000"
```
`docker-compose up -d`

OpenAPI Docs (Swagger): http://192.168.3.101:8082/docs
```bash
TOKEN=$(curl -sS -X POST http://192.168.3.101:8082/login/access-token --data "username=admin" --data "password=KumaApiAdmin" | jq -r .access_token)
curl -s -X GET -H "Authorization: Bearer ${TOKEN}" http://192.168.3.101:8082/monitors | jq .
curl -s -X GET -H "Authorization: Bearer ${TOKEN}" http://192.168.3.101:8082/monitors/1 | jq '.monitor | "\(.name) - \(.active)"'
```
### Dozzle

Dozzle (https://github.com/amir20/dozzle) - легковесное приложение с веб-интерфейсом для мониторинга журналов Docker (без хранения).

`mkdir dozzle && cd dozzle && mkdir dozzle_data`

`echo -n DozzleAdmin | shasum -a 256` получить пароль в формате sha-256 и передать в конфигурацию

`nano ./dozzle_data/users.yml`
```yaml
users:
  admin:
    name: "admin"
    password: "a800c3ee4dac5102ed13ba673589077cf0a87a7ddaff59882bb3c08f275a516e"
```
Запускаем контейнер:
```yaml
services:
  dozzle:
    image: amir20/dozzle:latest
    container_name: dozzle
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./dozzle_data:/data
    environment:
      - VIRTUAL_HOST=dozzle.local
      - DOZZLE_AUTH_PROVIDER=simple
      # Подключиться к удаленному хосту через Docker API (tcp socket)
      # - DOZZLE_REMOTE_HOST=tcp://192.168.3.101:2375|us-101
      # Подключиться к удаленному хосту через Dozzle Agent
      # - DOZZLE_REMOTE_AGENT=192.168.3.106:7007
    ports:
      - 9090:8080
```
`docker-compose up -d`

### Watchtower

[Watchtower](https://github.com/containrrr/watchtower) - следит за тегом `latest` в реестре Docker Hub и обновлять контейнер, если он станет устаревшим.
```yaml
services:
  watchtower:
    image: containrrr/watchtower
    container_name: watchtower
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - WATCHTOWER_NOTIFICATIONS=shoutrrr
      - WATCHTOWER_NOTIFICATIONS_HOSTNAME=<HOST_NAME>
      - WATCHTOWER_NOTIFICATION_URL=telegram://<BOT_API_KEY>@telegram/?channels=<CHAT/CHANNEL_ID>
      - WATCHTOWER_HTTP_API_TOKEN=demotoken
    command: --interval 600 # --http-api-metrics # --http-api-token demotoken # --http-api-update
    # ports:
    #   - 9095:8080
```
`docker-compose up -d`

Проброс потра используется для получения метрик через Prometheus (команда `--http-api-metrics`) с токеном доступа. Если нужно запускать обновления только через API, нужно добавить команду `--http-api-update`, или указать команду `--http-api-periodic-polls`, что бы использовать ручное и автоматическое обновление.

`curl -H "Authorization: Bearer demotoken" http://192.168.3.101:8070/v1/metrics` получить метрики \
`curl -H "Authorization: Bearer demotoken" http://192.168.3.101:8070/v1/update` проверить и запустить обновления

Добавить `scrape_configs` в `prometheus.yml` для сбора метрик:
```yaml
scrape_configs:
  - job_name: watchtower
    scrape_interval: 5s
    metrics_path: /v1/metrics
    bearer_token: demotoken
    static_configs:
      - targets:
        - '192.168.3.101:8070'
```
`docker-compose restart prometheus`

Чтобы исключить обновления, нужно добавить "lable" при запуске контейнера:
```bash
docker run -d --name kinozal-bot \
  -v /home/lifailon/kinozal-bot/torrents:/home/lifailon/kinozal-bot/torrents \
  --restart=unless-stopped \
  --label com.centurylinklabs.watchtower.enable=false \
  kinozal-bot
```
### Portainer

`curl -L https://downloads.portainer.io/portainer-agent-stack.yml -o portainer-agent-stack.yml` скачать yaml файл \
`version_update=$(cat portainer-agent-stack.yml | sed "s/2.11.1/latest/g")` \
`printf "%s\n" "$version_update" > portainer-agent-stack.yml` обновить версию в yaml файле на последнюю доступную в Docker Hub (2.19.5) \
`docker stack deploy -c portainer-agent-stack.yml portainer` развернуть в кластере swarm (на каждом node будет установлен агент, который будет собирать данные, а на manager будет установлен сервер с web панелью) \
https://192.168.3.101:9443

`docker run -d --name portainer_agent -p 9001:9001 --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:2.19.5` установить агент на удаленный хост \
https://192.168.3.101:9443/#!/endpoints добавить удаленный хост по URL 192.168.3.102:9001

`docker volume create portainer_data` создать volume для установки локального контейнера (не в кластер swarm) \
`docker create -it --name=portainer -p 9000:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer` создать локальный контейнер \
`docker start portainer` \
http://192.168.3.101:9000

## Docker.DotNet
```PowerShell
# Импорт библиотеки Docker.DotNet (https://nuget.info/packages/Docker.DotNet/3.125.15)
Add-Type -Path "$home\Documents\Docker.DotNet-3.125.15\lib\netstandard2.1\Docker.DotNet.dll"
# Указываем адрес удаленного сервера Docker, на котором слушает сокет Docker API
$config = [Docker.DotNet.DockerClientConfiguration]::new("http://192.168.3.102:2375")
# Подключаемся клиентом
$client = $config.CreateClient()
# Получить список методов класса клиента
$client | Get-Member
# Выводим список контейнеров
$containers = $client.Containers.ListContainersAsync([Docker.DotNet.Models.ContainersListParameters]::new()).GetAwaiter().GetResult()
# Забираем id по имени
$kuma_id = $($containers | Where-Object names -match "uptime-kuma-front").id
# Получить список дочерних методов
$client.Containers | Get-Member
# Остановить контейнер по его id
$StopParameters = [Docker.DotNet.Models.ContainerStopParameters]::new()
$client.Containers.StopContainerAsync($kuma_id, $StopParameters)
# Запустить контейнер
$StartParameters = [Docker.DotNet.Models.ContainerStartParameters]::new()
$client.Containers.StartContainerAsync($kuma_id, $StartParameters)
```
## Swarm

`docker swarm init` инициализировать `manager node` и получить токен для подключения `worker node` (на сервере) \
`docker swarm join-token worker` получить токен для подключения `worker` или `manager` \
`docker swarm join --token SWMTKN-1-1a078rm7vuenefp6me84t4swqtvdoveu6dh2pw34xjcf2gyw33-81f8r32jt3kkpk4dqnt0oort9 192.168.3.101:2377` подключение на worker node (на клиенте) \
`docker node ls` отобразить список node на manager node \
`docker node inspect u4u897mxb1oo39pbj5oezd3um` подробная информация (конфигурация) о node по id \
`docker swarm leave --force` выйти из кластера на `worker node` (на `manager node` изменится статус с `Ready` на `Down`) \
`docker node rm u4u897mxb1oo39pbj5oezd3um` удалить node (со статусом `Down`) на `manager node` \
`docker swarm init --force-new-cluster` заново инициализировать кластер (если упал, при наличии одного менеджера)

`docker pull lifailon/torapi:latest` \
`nano docker-stack.yml`
```yaml
services:
  torapi:
    image: lifailon/torapi:latest
    labels:
          - com.centurylinklabs.watchtower.enable=false
    deploy:
      # Режим развертывания
      mode: replicated                  # Фиксированное число реплик (по умолчанию)
      # mode: global                    # Одна копия на каждой ноде
      replicas: 2                       # Суммарное количество реплик на всех нодах (только в режиме replicated)

      # Политика перезапуска
      restart_policy:
        condition: on-failure           # Перезапускать только при ошибках (ненулевой код выхода)
        # condition: any                # Всегда перезапускать (аналог always в docker-compose)
        delay: 5s                       # Задержка перед перезапуском (по умолчанию, 5 секунд)
        max_attempts: 3                 # Максимум попыток перезапуска (по умолчанию, бесконечно)
        window: 30s                     # Время для оценки успешности перезапуска (по умолчанию, 0)

      # Политика обновления (старые контейнеры не удаляются сразу, а только останавливаются и создаются новые с обновленными образами)
      update_config:
        parallelism: 1                  # Количество реплик для одновременного обновения (по умолчанию, 1)
        delay: 10s                      # Задержка между обновлениями (по умолчанию, 0 секунд)
        order: start-first              # Порядок: start-first (сначала новый) или stop-first (сначала старый, по умолчанию)
        failure_action: rollback        # Действие при ошибке: continue, rollback, pause (по умолчанию, pause)
        monitor: 60s                    # Время мониторинга после обновления (по умолчанию, 0)

      # Политика отката (конфигурация аналогична update_config) при статусе unhealthy на новых контейнерах после update_config
      rollback_config:
        parallelism: 1
        delay: 10s
        order: stop-first
        failure_action: pause
        monitor: 60s

      # Ограничения размещения
      #   placement:
      #     constraints:
      #       - "node.role==worker"     # Только на worker-нодах
      #       - "node.labels.env==dev"  # Только на нодах с указаной меткой

      # Ограничения ресурсов
      resources:
        limits:
          cpus: "0.5"                   # Лимит CPU (0.5 = 50%)
          memory: 256M                  # Лимит RAM
        reservations:
          cpus: "0.1"                   # Гарантированные CPU
          memory: 128M                  # Гарантированная RAM

      # Режим балансировки (конечной точки)
      endpoint_mode: vip                # Балансировка через виртуальный IP внутри сети swarm
      # endpoint_mode: dnsrr            # Балансировка через DNS в режиме Round-Robin

    # Проверка здоровья (задается вне deploy)
    # Необходимо для работы:
    # 1. endpoint_mode - при статусе unhealthy исключает контейнер из балансировки
    # 2. restart_policy - пытается перезапустить контейнер
    # 3. update_config - ждет успешного прохождения healthcheck (статус healthy) перед обновлением следующей реплики или запускает rollback_config
    healthcheck:
      test: ["CMD", "curl", "-f", "http://127.0.0.1:8443/api/provider/list"] # HTTP проверка статуса ответа (0 = успех, 1 = ошибка)
    # test: ["CMD", "nc", "-z", "127.0.0.1 8443"] # TCP проверка порта
      interval: 30s                     # Интервал между проверками (по умолчанию, 30  секунд)
      timeout: 10s                      # Время ожидания ответа (по умолчанию, 30 секунд)
      retries: 3                        # Количество попыток перед объявлением статуса unhealthy
      start_period: 15s                 # Время на инициализацию перед проверками (по умолчанию, 0 секунд)

    ports:
      - target: 8443                    # Порт контейнера
        published: 8443                 # Порт на хосте
        protocol: tcp                   # Протокол (tcp/udp)
        # Режим балансировки
        mode: ingress                   # Балансировка через Swarm (только в режиме vip)
        # mode: host                    # Балансировка через хостовую систему (прямой проброс, только в режиме dnsrr)
    volumes:
    # - type: config                    # Swarm Configs (статические конфиги, права только на чтение)
    # - type: secret                    # Swarm Secrets (пароли, TLS-ключи. и т.п.)
    # - type: nfs                       # Удалённый NFS-сервер для общих данных в кластере
    # - type: tmpfs                     # RAM Временные файлы (/tmp)
    # - type: bind                      # Файлы на хосте (только если файлы есть на всех нодах)
    - type: volume                    # Управляется Docker (данные БД, кеш)
        source: torapi
        target: /rotapi

volumes:
  torapi:
```
`docker stack deploy -c docker-stack.yml TorAPI` собрать стек сервисов (на `worker node` появится контейнер `TorAPI_torapi.1.ug5ngdlqkl76dt`)

`docker stack ls` отобразить список стеков (название стека и количество в нем сервисов, без учета реплик) \
`docker stack services TorAPI` аналог `docker service ls`, но для отображения списока сервисов указанного стека \
`docker service ls` отобразить список всех сервисов для всех стеков (имя формате `<stackName_serviceName>`, с количеством и статусом реплик)

`docker stack ps TorAPI` статистика работы всех сервисов внутри стека (аналог `docker ps`) \
`docker service ps TorAPI_torapi` аналог `docker stack ps`, но для отображения статистики указанного сервиса \
`docker service logs TorAPI_torapi -fn 0` просмотреть логи сервиса по всех репликам кластера одновременно

`docker node update --label-add dev=true iebj3itgan6xso8px00i3nizc` добавить ноду в группу по метке для линковки при запуске \
`docker service update --image lifailon/torapi:fake TorAPI_torapi` запустить обновление образа для сервиса \
`docker service scale TorAPI_torapi=3` масштабировать сервис до указанного числа реплик

`docker service inspect --pretty TorAPI_torapi` отобразить конфигурацию сервиса \
`docker service inspect TorAPI_torapi` отобразить подробную конфигурацию сервиса в формате `json` \
`docker stack rm TorAPI` удалить стек (не требует остановки контейнеров)

<!--
# Uncloud

[Uncloud](https://github.com/psviderski/uncloud) - легковесный инструмент для кластеризации и оркестровки контейнеров.

`curl -fsS https://get.uncloud.run/install.sh | sh` установка \
`uncloud machine init lifailon@192.168.3.106:2121 -i ~/.ssh/id_rsa` инициализация кластера (на удаленной ноде будет установлен Caddy в Docker)
-->

## Kubernetes

`Node` - Физическая или виртуальная машина, входящая в состав кластера. На каждом узле работает kubelet (агент Kubernetes) и контейнерная среда. \
`Pod` - наименьшая и самая простая единица в Kubernetes. Содержит один или несколько контейнеров, которые разделяют одно сетевое пространство (общий IP и порты) и имеют общие тома (volumes) для хранения данных. \
`Deployment` - управляет состоянием группы идентичных подов (реплик). Отвечает за их масштабируемость (увеличение или уменьшение числа подов), восстановление (перезапуск подов при сбоях), обновление (rolling updates) и откат (rollback) версий приложения. \
`Service` - отвечает за балансировку нагрузки (обрабатывает входящий трафик и распределяет его между подами), а также обеспечивая постоянный IP-адрес и DNS-имя, даже в случае их пересоздания. \
`ConfigMap` и `Secret` – хранит конфигурационные данные (например, настройки приложения) в виде пар "ключ-значение" или содержимого файлов (в открытом или зашифрованном виде).

### Minikube

[Minikube](https://github.com/kubernetes/minikube) - это локальный кластер (одноузловой экземпляр, запускаемый в виртуальной среде) Kubernetes от создателя оригинального k8s.
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-windows-amd64.exe
mv minikube-windows-amd64.exe minikube.exe
```
`sudo cp ~/.minikube/ca.crt /usr/local/share/ca-certificates/minikube.crt && update-ca-certificates && openssl verify /usr/local/share/ca-certificates/minikube.crt` установка сертификатов в Linux \
`Import-Certificate -FilePath "$HOME\.minikube\ca.crt" -CertStoreLocation Cert:\LocalMachine\Root && Import-Certificate -FilePath "$HOME\.minikube\profiles\minikube\client.crt" -CertStoreLocation Cert:\CurrentUser\My && ls Cert:\LocalMachine\Root | Where-Object Subject -Match "minikube"` установка сертификатов в Windows

`minikube start --vm-driver=hyperv --memory=4g --cpus=2` запустить кластер и создать виртуальную машину \
`minikube status` статус работы кластера \
`minikube stop` остановить кластер \
`minikube delete` удалить виртуальную машину \
`minikube profile list` узнать информацию о драйвере, ip, версии и количество Nodes \
`minikube dashboard --port 8085` запустить api сервер и интерфейс состояния

`minikube addons list`  список доступных дополнений и их статус работы \
`minikube addons enable metrics-server` активировать дополнение, которое предоставляет метрики для HPA, такие как загрузка процессора и использование памяти \
`kubectl get deployment metrics-server -n kube-system` текущее состояние развертывания metrics-server в кластере \
`kubectl get pod,svc -n kube-system` отобразить список системных подов и сервисов в кластере (pod/metrics-server-7fbb699795-wvfxb) \
`kubectl logs -n kube-system deployment/metrics-server` отобразить логи metrics-server \
`kubectl top pods` отобразить метрики на подах (CPU/MEM) \
`minikube addons disable metrics-server` отключить дополнение

`minikube addons enable ingress` включить Nginx Ingress Controller \
`kubectl get pods -n kube-system` отобразить список системных подов (должен появиться ingress-nginx-controller) \
`minikube tunnel --alsologtostderr` создает виртуальный LoadBalancer в Minikube, для перенаправления трафика на нужный сервис, вместо использования NodePort

### Microk8s

[Microk8s](https://github.com/canonical/microk8s) - это полностью совместимый и легкий Kubernetes в одном пакете, работающий на 42 разновидностях Linux от компании Canonical.

`snap install microk8s --classic` установка \
`microk8s status --wait-ready` отобразить статус работы (дождаться инициализации служб Kubernetes) и список дополнений \
`microk8s start` запустить или остановить (`stop`) MicroK8s и его службы \
`microk8s enable dashboard` запустить dashboard \
`microk8s enable dns` установка обновлений \
`sudo usermod -a -G microk8s $USER && mkdir -p ~/.kube && chmod 0700 ~/.kube` добавить текущего пользователя в группу управления microk8s (создается при установке) \
`alias kubectl='microk8s kubectl'` добавить псевдоним, для использования команды kubectl через microk8s \
`kubectl get nodes` отобразить список нод \
`kubectl config view --raw > $HOME/.kube/config` передать конфигурацию в MicroK8s, для использования с существующим kubectl

### K3s

[K3s](https://github.com/k3s-io/k3s) — это полностью совместимый дистрибутив Kubernetes в формате единого двоичного файле, который удаляет хранение драйверов и поставщика облачных услуг, а также добавляет поддержку `sqlite3` для `backend` хранилища от компании Rancher Labs (SUSE).

`curl -sfL https://get.k3s.io | sh -` установка службы в systemd и утилит `kubectl`, `crictl`, `k3s-killall.sh` и `k3s-uninstall.sh` \
`sudo chmod 644 /etc/rancher/k3s/k3s.yaml && sudo chown $(id -u):$(id -g) /etc/rancher/k3s/k3s.yaml` назначить права на конфигурацию текущему пользователю \
`sudo cat /var/lib/rancher/k3s/server/node-token` токен авторизации \
`curl -sfL https://get.k3s.io | K3S_URL=https://192.168.3.101:6443 K3S_TOKEN=<TOKEN> sh -` передать переменные окружения `K3S_URL` и `K3S_TOKEN` токен для установки на рабочие ноды (команда удаления: `sudo /usr/local/bin/k3s-agent-uninstall.sh`) \
`sudo nano /boot/firmware/cmdline.txt` включить cgroups v1 вместо v2 => `systemd.unified_cgroup_hierarchy=0 cgroup_enable=memory cgroup_memory=1` \
`k3s kubectl get nodes` отобразить список нод в кластере \
`sudo k3s crictl ps` отобразить список всех запущенных контейнеров, включая системные для работы класетра \
`sudo k3s etcd-snapshot save` создать снапшот etcd (распределённого `key-value` хранилища, которое отвечает за состояние всего кластера Kubernetes) \
`sudo k3s etcd-snapshot restor` восстановление кластера из снапшота

### Dashboard

Пример развертывания Kubernetes Dashboard в кластере k3s:
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml # загружаем deployment
kubectl create serviceaccount dashboard-admin -n kubernetes-dashboard # создаем сервисный аккаунт
kubectl create clusterrolebinding dashboard-admin --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:dashboard-admin # выдаем права cluster-admin
kubectl -n kubernetes-dashboard create token dashboard-admin # получаем JWT-токен сервисного аккаунта для авторизации
kubectl -n kubernetes-dashboard patch svc kubernetes-dashboard-kong-proxy -p '{"spec":{"type":"NodePort"}}' # меняем тип сервиса на NodePort
kubectl -n kubernetes-dashboard get svc kubernetes-dashboard-kong-proxy # узнаем назначенный порт (в диапазоне 30000-32767) для внешнего подключения
```
### Headlamp

[Headlamp](https://github.com/kubernetes-sigs/headlamp) - это современная альтернатива Dashboard c расширенным функционалом, созданная сообществом Kubernetes Special Interest Groups.
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/headlamp/main/kubernetes-headlamp.yaml # установка в кластер
kubectl -n kube-system create serviceaccount headlamp-admin # создать сервисный аккаунт
kubectl create clusterrolebinding headlamp-admin --serviceaccount=kube-system:headlamp-admin --clusterrole=cluster-admin # назначить права администратора кластера для сервисного аккаунта
kubectl create token headlamp-admin -n kube-system --duration=43800h # выпустить токен для авторизации сроком действия 5 лет
```
### k9s

[K9s](https://github.com/derailed/k9s) - это TUI интерфейс для взаимодействия с кластерами Kubernetes (управление и чтение логов).

`wget https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.deb && sudo apt install ./k9s_linux_amd64.deb && rm k9s_linux_amd64.deb` установка в системе с архитектурой `amd64` \
`wget https://github.com/derailed/k9s/releases/latest/download/k9s_linux_arm64.deb && sudo apt install ./k9s_linux_arm64.deb && rm k9s_linux_arm64.deb` установка в системе с архитектурой `arm64` \
`winget install k9s || scoop install k9s || choco install k9s || curl.exe -A MS https://webinstall.dev/k9s | powershell` установка в Windows

### kubectl

`kubectl get nodes` отобразить список `node` и их статус работы, роль (`master` или `node`), время запуска и версию

`kubectl get namespaces` вывести список все доступных пространств имен (`namespace`)
`kubectl config view` отобразить текущую конфигурацию (настройка подключения kubectl к Kubernetes, которое взаимодействует с приложением через конечные точки `REST API`) \
`kubectl config set-context --current --namespace=kubernetes-dashboard` сменить context в конфигурации

`kubectl create deployment torapi --image=torapi --replicas=3 --dry-run=client -o yaml` генерация манифеста `deployment.yaml` \
`kubectl create service loadbalancer torapi --tcp=8444:8443 --dry-run=client -o yaml` генерация манифеста `service.yaml` (`<port>:<targetPort>`)

`kubectl get deployments` отобразить статус всех Deployments в указанном namespace (`-n kubernetes-dashboard`), которые в свою очередь управляют Pod-ами (`RADY` - текущее количество желаемых реплик в рабочем состояние, например, 2 из 2 и `UP-TO-DATE` — количество реплик, обновленных до последней версии)

`kubectl get pods` статус всех подов \
`kubectl get pods -o wide` отобразить количество всех подов и на какой ноде он работает (у каждого пода свой ip-адрес) \
`kubectl get pods -o json` отобразить подробный вывод в формате `json` \
`kubectl get pods -o jsonpath='{range .items[*]}{.spec.nodeName}{": "}{.metadata.name}{"\n"}{end}'` фильтрация по `json` как в `jq` \
`kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'` получить список имен всех под через шаблон фильтра

`kubectl get services` отобразить список сервисов (их `TYPE`, `CLUSTER-IP`, `EXTERNAL-IP` и `PORT(S)`), которые принимают внешний трафик \
`kubectl describe services torapi-service` отобразить настройки сервиса для внешнего доступа (ip, тип сервиса и конечные точки) \
`kubectl get endpoints torapi-service` отобразить на какие адреса (ip и порт) подов перенаправляется трафик сервиса

`kubectl describe pods torapi-54775d94b8-t2dhm` отобразить какие контейнеры находятся внутри пода и на каких нодах запущены \
`kubectl logs torapi-54775d94b8-t2dhm` отобразить логи выбранного контейнера в поде (сообщения, которые приложение отправляет в `stdout`) \
`kubectl logs -l app=torapi --follow` выводить лог для всех запущенных репликах подов в реальном времени

`kubectl exec torapi-54775d94b8-t2dhm -c torapi -- ls -lha` выполнить команду в указанноv контейнере внутри пода \
`kubectl exec torapi-54775d94b8-t2dhm -c torapi -- env` отобразить список глобальных переменных в контейнере \
`kubectl exec -it torapi-54775d94b8-t2dhm -c torapi -- curl http://localhost:8443/api/provider/list` проверить доступность приложения внутри контейнера \
`kubectl exec -it torapi-54775d94b8-t2dhm -c torapi -- sh` запустить `sh` или `bash` сессию в контейнере пода

`kubectl get rs` состояние реплик (`ReplicaSet`) для всех deployment (`DESIRED` - желаемое количество экземпляров-реплик и `CURRENT` - текущее количество реплик) \
`kubectl scale deployments/torapi --replicas=3` масштабировать (или уменьшить) deployment до указанного числа реплик подов \
`kubectl describe deployments/torapi` изменения фиксируется в конфигурации deployment - Events: `Scaled up replica set torapi-54775d94b8 from 2 to 3`

`kubectl delete service torapi-service` удалить service \
`kubectl delete deployment torapi` удалить deployment

`kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1` \
`kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 3088` \
`kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=docker.io/jocatalin/kubernetes-bootcamp:v2` выполнение плавающего обновления версии образа работающего контейнера \
`kubectl rollout status deployments/kubernetes-bootcamp` проверить статус обновления \
`kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=gcr.io/google-samples/kubernetes-bootcamp:v10` выполнить обновление на несуществующую версию \
`kubectl rollout undo deployments/kubernetes-bootcamp` откатить deployment к последней работающей версии (к предыдущему известному состоянию в образе v2)

`kubectl get configmap` получить все ConfigMap \
`kubectl describe configmap kube-root-ca.crt` отобразить содержимое ConfigMap (на примере корневого сертифика)

`kubectl create secret generic admin-password --from-literal=username=admin --from-literal=password=pass` создать секрет в формате ключ-значение \
`kubectl create secret generic api-key --from-file=api-key.txt` создать секрет из содержимого файла \
`kubectl get secret` получить список всех секретов \
`kubectl describe secret admin-password` получить информацию о секрете (размер в байтах) \
`kubectl get secret admin-password -o yaml` получить содержимое секретов в кодировке base64 \
`kubectl get secret admin-password -o jsonpath="{.data.password}" | base64 --decode` декодировать содержимое секрета \
`kubectl delete secret admin-password` удалить секрет

`kubectl get jobs -n kube-system` проверить статус выполнения заданий (job)

### Deployment
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: rest-api

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: torapi        # Имя Deployment, который управляет созданием подов
  namespace: rest-api # Новое пространство имен
spec:
  replicas: 2         # Количество реплик (2 пода с одинаковыми настройками)
  selector:
    matchLabels:
      app: torapi     # Определяет, какие поды будут управляться этим Deployment
  template:
    metadata:
      labels:
        app: torapi   # Метка, которая связывает этот шаблон (template) с селектором выше
    spec:
      containers:
      - name: torapi                    # Имя контейнера внутри пода
        image: lifailon/torapi:latest   # Используемый образ контейнера
        ports:
        - containerPort: 8443           # Порт, который будет открыт внутри контейнера
        resources:                      # Ограничения и гарантируемые ресурсы
          requests:
            cpu: "100m"                 # Минимальный запрашиваемый процессор (0.1 ядра = 100 милли-ядер)
            memory: "128Mi"             # Минимальный запрашиваемый объем оперативной памяти (128 МБайт)
          limits:
            cpu: "200m"                 # Максимально доступное процессорное время 
            memory: "256Mi"             # Максимальный объем памяти
        livenessProbe:                  # Проверка работоспособности контейнера
          httpGet:
            path: /api/provider/list    # Конечная точка в контейнере, по которому будет проверяться работоспособность
            port: 8443                  # Порт, на котором доступен этот endpoint внутри контейнера
          initialDelaySeconds: 5        # Ждет 5 секунд после запуска контейнера перед первой проверкой
          periodSeconds: 10             # Интервал проверки (повторять проверку каждые 10 секунд)
          timeoutSeconds: 3             # Максимальное время ожидания ответа в секундах
          failureThreshold: 3           # Количество неудачных попыток перед рестартом
```
`kubectl apply -f deployment.yaml`
```yaml
apiVersion: v1
kind: Service
metadata:
  name: torapi-service
  namespace: rest-api
spec:
  selector:
    app: torapi
  ports:
    - protocol: TCP
      targetPort: 8443    # Порт, который слушают поды (контейнеры)
      port: 8444          # Порт, на котором сервис доступен внутри кластера (ClusterIP)
      # nodePort: 30443   # Порт, открытый на каждой ноде кластера для доступа извне (единственная точка входа в режиме type: nodePort)
  type: LoadBalancer      # Порт ClusterIP (указанный в targetPort) становится доступен из вне на всех нодах
  # type: ClusterIP       # Значение по умолчанию, используется для общения сервисов только внутри кластера
  # type: NodePort        # Единственная точка входа через NodePort
```
`kubectl apply -f service.yaml`

`kubectl get pods` будет создано два пода \
`kubectl logs torapi-54775d94b8-t2dhm` отобразить логи пода, будут идти запросы от ip kube-probe/1.32 для проверки здоровья \
`kubectl exec -it torapi-54775d94b8-t2dhm -- npm --version` вывести версию npm внутри контейнера

### Proxy and forward

Проверить распредиление нагрузки в режиме `LoadBalancer`:
```bash
for i in {1..20}; do
    curl -s http://192.168.3.105:8444/api/provider/list
done
```
`kubectl proxy` запустить прокси сервер для локального взаимодействия с частной сетью кластера Kubernetes через API (без авторизации), где автоматически создаются конечные точки для каждого пода в соответствии с его именем \
`curl http://localhost:8001` отобразить список всех доступных конечных точек (endpoints) \
`curl -s http://localhost:8001/api/v1/namespaces/rest-api/pods | jq -r .items[].metadata.name` вывести список всех имен подов в указанном namespace \
`curl -s http://localhost:8001/api/v1/namespaces/rest-api/services/torapi-service:8444/proxy/api/provider/list` конечная точка, которая напрямую проксирует запрос внутрь пода (к конечной точке приложения в контейнере)

`kubectl port-forward -n rest-api pods/torapi-54775d94b8-t2dhm 8443:8443` запустить проброс порта из пода \
`curl http://localhost:8443/api/provider/list`

`curl http://torapi-service.rest-api.svc.cluster.local:8444/api/provider/list` запрос к поду из контейнера любого друго namespace внутри кластера (Использует Cluster-IP)

### HPA

`HPA` (Horizontal Pod Autoscaling) - горизонтальное масштабирование позволяет автоматически увеличивать или уменьшать количество реплик (подов) в зависимости от текущей нагрузки по показателям метрик, получаемых из `metrics-server`. Если нагрузка на одну поду увеличивается, то реплика должна снять нагрузку с первого пода, тем самым средняя нагрузка на 1 под будет ниже.

`kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml` установить `metrics-server` в кластер

`kubectl top nodes` отобразить метрики ресурсов для всех узлов в кластере \
`kubectl get deployment metrics-server -n kube-system` отобразить статус работы metrics-server \
`kubectl logs -n kube-system deployment/metrics-server` проверить логи metrics-server

`kubectl edit deployment metrics-server -n kube-system` отключить проверку TLS
```yaml
spec:
  containers:
  - args:
    - --kubelet-insecure-tls
```
`kubectl rollout restart deployment metrics-server -n kube-system` перезапустить metrics-server
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: torapi-hpa
  namespace: rest-api
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: torapi  # Имя Deployment, который будем масштабировать
  minReplicas: 1  # Минимальное количество реплик
  maxReplicas: 5  # Максимальное количество реплик
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50  # когда среднее использование CPU превышает 50%, будет увеличено количество реплик, чтобы уменьшить нагрузку на поды
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300  # задержка в 5 минут перед уменьшением реплик
    scaleUp:
      stabilizationWindowSeconds: 60   # задержка в 1 1 минуту перед увеличением реплик
      policies:
      - type: Pods
        value: 1            # Добавлять по 1 поду за шаг
        periodSeconds: 60   # Интервал между магом в секундах
```
`kubectl apply -f torapi-hpa.yaml`

`kubectl top pods -n rest-api` отобразить нагрузку на подах по cpu и memory \
`kubectl get --raw "/apis/metrics.k8s.io/v1beta1/namespaces/rest-api/pods" | jq .` получить метрики напрямую из API

`kubectl get hpa` отобразить статус работы всех HPA и текущие таргеты (cpu: 1%/50%) \
`kubectl get pods` будет активен 1 под из 5 подов (вместо двух, изначально определенных в Deployment)

`kubectl describe hpa -n rest-api torapi-hpa` отобразить статус работы HPA (текущее и тригерное значение для масштабирования)
```
Metrics:                                               ( current / target )
  resource cpu on pods  (as a percentage of request):    3% (3m) / 10%
```

### Ingress

`Ingress` - это балансировщик нагрузки, который управляет HTTP или HTTPS трафиком в кластер и направляет его к нужным логическим сервисам (балансировка между нодами по имени и маршрутизация запросов к разным конечным точкам в пути).

`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml` установить `Ingress Controller` в кластер \
`kubectl get pods -n ingress-nginx` \
`kubectl get svc -n ingress-nginx`
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: torapi-ingress
  namespace: rest-api
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  # ingressClassName: traefik
  rules:
  - host: torapi.local # доменное имя (которое необходимо прописать на DNS сервере)
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: torapi-service
            port:
              number: 8444
```
`kubectl apply -f ingress.yaml`

`kubectl get ingress` отобразить статус работы ingress (используемое proxy приложение, внешние адреса в балансировке и общий порт)

Изменить работу масштабирования `HPA` на основе 50 и выше HTTP-запросов в секунду через метрику `nginx_ingress_controller_requests`:
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: torapi-hpa
  namespace: rest-api
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: torapi
  minReplicas: 1
  maxReplicas: 5
  metrics:
  - type: External
    external:
      metric:
        name: nginx_ingress_controller_requests
      target:
        type: Value
        value: 50
```
`kubectl apply -f hpa.yaml`

`kubectl get hpa` отобразить статус работы HPA

### MetalLB

[MetalLB](https://github.com/metallb/metallb) - балансировщик нагрузки для локальных кластеров, эмулирующий работу облачных провайдеров. Настраивается пул адресов, и в случае падения ноды, переводит IP-адреса сервисов на другую ноду. Для сервисов LoadBalancer (включая Ingress-контроллер) выдается один внешний виртуальный ip-адрес, который прописывается на внешнем DNS сервере.

`kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.15.2/config/manifests/metallb-native.yaml` установка в кластер из манифеста

Настройка пула адресов:
```yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.3.201/32
  # - 192.168.3.201-192.168.3.210
  # autoAssign: false # требует аннотации пула или указания адреса в Service

# apiVersion: v1
# kind: Service
# metadata:
#   name: torapi-service
#   namespace: rest-api
#   annotations:
#     metallb.universe.tf/address-pool: "default-pool"      # Использовать указанный пул
#     metallb.universe.tf/loadBalancerIPs: "192.168.3.201"  # Привязка адреса из пула
```
`kubectl apply -f ip-address-pool.yaml`

Анонсировать адреса из `default-pool` в сети через протокол ARP на уровне L2/Ethernet:
```yaml
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
spec:
  ipAddressPools:
  - default-pool
```
`kubectl apply -f l2-advertisement.yaml`

## GitHub API

`$user = "Lifailon"` \
`$repository = "ReverseProxyNET"` \
`Invoke-RestMethod https://api.github.com/users/$($user)` получаем информацию о пользователе \
`Invoke-RestMethod https://api.github.com/users/$($user)/repos` получаем список последних (актуальные коммиты) 30 репозиториев указанного пользователя \
`Invoke-RestMethod https://api.github.com/users/$($user)/repos?per_page=100` получаем список последних (актуальные коммиты) 100 репозиториев указанного пользователя \
`Invoke-RestMethod https://api.github.com/repos/$($user)/$($repository)/contents` получаем содержимое корневой директории репозитория \
`Invoke-RestMethod https://api.github.com/repos/$($user)/$($repository)/contents/source/rpnet.cs` получаем содержимое файла в формате Base64 \
`$commits = Invoke-RestMethod https://api.github.com/repos/$($user)/$($repository)/commits` получаем список коммитов \
`$commits[0].commit.message` читаем комментарий последнего коммита \
`$commits[0].commit.committer.date` получаем дату последнего коммита \
`Invoke-RestMethod https://api.github.com/repos/$($user)/$($repository)/commits/$($commits[0].sha)` получаем подробную информацию изменений о последнем коммите в репозитории \
`$releases_latest = Invoke-RestMethod "https://api.github.com/repos/$($user)/$($repository)/releases/latest"` получаем информацию о последнем релизе в репозитории \
`$releases_latest.assets.name` список приложенных файлов последнего релиза \
`$releases_latest.assets.browser_download_url` получаем список url для загрузки файлов \
`$($releases_latest.assets | Where-Object name -like "*win*x64*exe*").browser_download_url` фильтруем по ОС и разрядности \
`$(Invoke-RestMethod -Uri "https://api.github.com/repos/Lifailon/epic-games-radar/commits?path=api/giveaway/index.json")[0].commit.author.date` узнать дату последнего обновления файла в репозитории \
`$issues = Invoke-RestMethod https://api.github.com/repos/LibreHardwareMonitor/LibreHardwareMonitor/issues?per_page=500` получаем список открытых проблем в репозитории (получаем максимум 100 последних, по умолчанию забираем последние 30 issues) \
`$issue_number = $($issues | Where-Object title -match "PowerShell").number` получаем номер issue, в заголовке которого есть слово "PowerShell" \
`Invoke-RestMethod https://api.github.com/repos/LibreHardwareMonitor/LibreHardwareMonitor/issues/$($issue_number)/comments` отобразить список комментарием указанного issues \
`Invoke-RestMethod https://api.github.com/repos/LibreHardwareMonitor/LibreHardwareMonitor/languages` получаем список языков программирования, используемых в репозитории \
`Invoke-RestMethod https://api.github.com/repos/LibreHardwareMonitor/LibreHardwareMonitor/pulls` получаем список всех pull requests в репозитории \
`Invoke-RestMethod https://api.github.com/repos/LibreHardwareMonitor/LibreHardwareMonitor/forks` получаем список форков (forks) \
`Invoke-RestMethod https://api.github.com/repos/LibreHardwareMonitor/LibreHardwareMonitor/stargazers?per_page=4000` получаем список пользователей, которые поставили звезды репозиторию \
`Invoke-RestMethod https://api.github.com/repos/LibreHardwareMonitor/LibreHardwareMonitor/subscribers` получаем список подписчиков (watchers) репозитория

## GitHub Actions

### Runner (Agent)

`mkdir actions-runner; cd actions-runner` \
`Invoke-WebRequest -Uri https://github.com/actions/runner/releases/download/v2.316.1/actions-runner-win-x64-2.316.1.zip -OutFile actions-runner-win-x64-2.316.1.zip` загрузить пакет с Runner последней версии \
`if((Get-FileHash -Path actions-runner-win-x64-2.316.1.zip -Algorithm SHA256).Hash.ToUpper() -ne 'e41debe4f0a83f66b28993eaf84dad944c8c82e2c9da81f56a850bc27fedd76b'.ToUpper()){ throw 'Computed checksum did not match' }` проверить валидность пакета с помощью hash-суммы \
`Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$PWD/actions-runner-win-x64-2.316.1.zip", "$PWD")` разархивировать \
`Remove-Item *.zip` удалить архив \
`./config.cmd --url https://github.com/Lifailon/egapi --token XXXXXXXXXXXXXXXXXXXXXXXXXXXXX` авторизовать и сконфигурировать сборщика с помощью скрипта (что бы на последнем пункте создать службу для управления сборщиком, нужно запустить консоль с правами администратора) \
`./run.cmd` запустить процесс (если не используется служба) \
`Get-Service *actions* | Start-Service` запустить службу \
`Get-Process *Runner.Listener*` \
`./config.cmd remove --token XXXXXXXXXXXXXXXXXXXXXXXXXXXXX` удалить конфигурацию

### Build (Pipeline)
```yaml
name: build-game-list

on:
  # Разрешить ручной запуск workflow через интерфейс GitHub
  workflow_dispatch:
  
  # Запускать workflow по расписанию каждый час в 00 минут
  schedule:
  - cron: '00 * * * *'

jobs:
  Job_01:
    # Указываем, что job будет выполняться на последней версии Ubuntu
    runs-on: ubuntu-latest
    
    steps:
    # Шаги, которые будут выполнены в рамках этого job
    - name: Checkout repository
      # Клонирования репозиторий
      uses: actions/checkout@v2
    
    - name: Get content and write to file
      # Выполняем скрипт PowerShell, расположенный в ./scripts/Get-GameList.ps1
      run: pwsh -File ./scripts/Get-GameList.ps1
      # Указываем, что команда должна выполняться в оболочке bash
      shell: bash 

    - name: Commit and push changes
      run: |
        # Задаем имя пользователя и email для коммитов
        git config --global user.name 'GitHub Actions'
        git config --global user.email 'actions@github.com'
        # Добавляем все изменения в индекс
        git add .
        # Делаем коммит с комментарием
        git commit -m "update game list"
        # Отправляем коммит в удаленный репозиторий
        git push
```
### CI
```yaml
name: Docker Build and Push Image

on:
  # Запусать при git push в ветку main
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Клонируем репозиторий
      uses: actions/checkout@v2

    - name: Авторизация в Docker Hub
      uses: docker/login-action@v3
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}

    - name: Сборка образа и отправка в Docker Hub
      run: |
        docker build -t lifailon/torapi:latest .
        docker push lifailon/torapi:latest
```
### Logs

`$(Invoke-RestMethod https://api.github.com/repos/Lifailon/TorAPI/actions/workflows).total_count` получить количество запусков всех рабочих процессов \
`$(Invoke-RestMethod https://api.github.com/repos/Lifailon/TorAPI/actions/workflows).workflows` подробная информации о запускаемых рабочих процессах \
`$actions_last_id = $(Invoke-RestMethod https://api.github.com/repos/Lifailon/TorAPI/actions/workflows).workflows[-1].id` получить идентификатор последнего события \
`$(Invoke-RestMethod https://api.github.com/repos/Lifailon/TorAPI/actions/workflows/$actions_last_id/runs).workflow_runs` подробная информация о последней сборке \
`$run_id = $(Invoke-RestMethod https://api.github.com/repos/Lifailon/TorAPI/actions/workflows/$actions_last_id/runs).workflow_runs.id` получить идентификатор запуска рабочего процесса \
`$(Invoke-RestMethod "https://api.github.com/repos/Lifailon/TorAPI/actions/runs/$run_id/jobs").jobs.steps` подробная информация для всех шагов выполнения (время работы и статус выполнения) \
`$jobs_id = $(Invoke-RestMethod "https://api.github.com/repos/Lifailon/TorAPI/actions/runs/$run_id/jobs").jobs[0].id` получить идентификатор последнего задания указанного рабочего процесса
```PowerShell
$url = "https://api.github.com/repos/Lifailon/TorAPI/actions/jobs/$jobs_id/logs"
$headers = @{
    Authorization = "token ghp_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}
Invoke-RestMethod -Uri $url -Headers $headers # получить логи задания
```
### act

[act](https://github.com/nektos/act) - пользволяет запускать действия GitHub Actions локально.
```bash
version=$(curl -s https://api.github.com/repos/nektos/act/releases/latest | jq -r .tag_name)
curl -L "https://github.com/nektos/act/releases/download/$version/act_$(uname -s)_$(uname -m).tar.gz" -o $HOME/.local/bin/act.tar.gz
tar -xzf $HOME/.local/bin/act.tar.gz -C $HOME/.local/bin
chmod +x $HOME/.local/bin/act
rm $HOME/.local/bin/act.tar.gz
act --version
```
`act --list` список доступных действий, указаных в файлах .github/workflows \
`act -j build` запуск указанного действия по Job ID (имя файла, не путать с названием Workflow) \
`act -n -j build` пробный запуск (--dry-run), без выполнения команд, для отображения всех выполняемых jobs и steps
```json
{
  "inputs": {
    "Distro": "ubuntu-24.04",
    "Update": "false",
    "Linter": "true",
    "Test": "false",
    "Release": "false",
    "Binary": "true"
  }
}
```
`act -e event.json -W .github/workflows/build.yml -P ubuntu-24.04=catthehacker/ubuntu:act-latest` запустить указанный файл workflow с переданным файлом переменных (предварительно определенных параметров) и указанным сборщиком \
`act -e event.json -W .github/workflows/build.yml -P ubuntu-24.04=catthehacker/ubuntu:act-latest --artifact-server-path $PWD/artifacts` примонтировать рабочий каталог в контейнер для сохранения артефактов
```bash
echo "DOCKER_HUB_USERNAME=username" >> .secrets
echo "DOCKER_HUB_PASSWORD=password" >> .secrets
```
`act --secret-file .secrets` \
`act -s DOCKER_HUB_USERNAME=username -s DOCKER_HUB_PASSWORD=password` передать содержимое секретов \
`act push` симуляция push-ивента (имитация коммита и запуск workflow, который реагирует на push) \
`act --reuse` не удалять контейнер из успешно завершенных рабочих процессов для сохранения состояния между запусками (кэширование) \
`act --parallel` запуск всех jobs одновременно или последовательно (--no-parallel, по умолчанию)

## Vercel

`npm i -g vercel` установить глобально в систему Vercel CLI \
`vercel --version` выводит текущую версию установленного Vercel CLI \
`vercel login` выполняет вход в аккаунт Vercel (`> Continue with GitHub`) \
`vercel logout` выполняет выход из аккаунта Vercel \
`vercel init` инициализирует новый проект в текущей директории (создает файл конфигурации vercel.json и другие файлы, необходимые для проекта) \
`vercel dev` запускает локальный сервер для проверки работоспособности (http://localhost:3000) \
`vercel deploy` загружает проект на серверы Vercel и развертывает его \
`vercel link` привязывает текущую директорию к существующему проекту на сервере Vercel (выбрать из списка) \
`vercel unlink` отменяет привязку текущей директории от проекта Vercel \
`vercel env` управляет переменными окружения для проекта \
`vercel env pull` подтягивает переменные окружения с Vercel в локальный .env файл \
`vercel env ls` показывает список всех переменных окружения для проекта \
`vercel env add <key> <environment>` добавляет новую переменную окружения для указанного окружения (production, preview, development) \
`vercel env rm <key> <environment>` удаляет переменную окружения из указанного окружения \
`vercel projects` управляет проектами Vercel \
`vercel projects ls` показывает список всех проектов \
`vercel projects add` добавляет новый проект \
`vercel projects rm <project>` удаляет указанный проект \
`vercel pull` подтягивает последние настройки окружения с Vercel \
`vercel alias` управляет алиасами доменов для проектов \
`vercel alias ls` показывает список всех алиасов для текущего проекта \
`vercel alias set <alias>` устанавливает алиас для указанного проекта \
`vercel alias rm <alias>` удаляет указанный алиас \
`vercel domains` управляет доменами, привязанными к проекту \
`vercel domains ls` показывает список всех доменов \
`vercel domains add <domain>` добавляет новый домен к проекту \
`vercel domains rm <domain>` удаляет указанный домен \
`vercel teams` управляет командами и членами команд на Vercel \
`vercel teams ls` показывает список всех команд \
`vercel teams add <team>` добавляет новую команду \
`vercel teams rm <team>` удаляет указанную команду \
`vercel logs <deployment>` выводит логи для указанного деплоя \
`vercel secrets` управляет секретами, используемыми в проектах \
`vercel secrets add <name> <value>` добавляет новый секрет \
`vercel secrets rm <name>` удаляет указанный секрет \
`vercel secrets ls` показывает список всех секретов \
`vercel switch <team>` переключается между командами и аккаунтами Vercel

### CD
```yaml
name: Deploy to Vercel

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Clone repository
      uses: actions/checkout@v4

    - name: Install Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '20'

    - name: Install dependencies
      run: npm install

    - name: Deploy to Vercel
      uses: amondnet/vercel-action@v25
      with:
        vercel-token: ${{ secrets.VERCEL_TOKEN }}
        vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
        vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
        vercel-args: '--prod'
```
## GitLab
```bash
docker run --detach \
    --hostname 192.168.3.101 \
    --publish 443:443 --publish 80:80 --publish 2222:22 \
    --name gitlab \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ee:latest
```
`docker logs -f gitlab` логи контейнера \
`docker exec -it gitlab cat /etc/gitlab/initial_root_password` получить пароль для root \
`docker exec -it gitlab cat /etc/gitlab/gitlab.rb` конфигурация сервера

Получить токен регистрации Runner: http://192.168.3.101/root/torapi/-/settings/ci_cd#js-runners-settings

`curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64` загрузить исполняемый файл Runner
`chmod +x /usr/local/bin/gitlab-runner`
```bash
docker run -d --name gitlab-runner --restart always \
    -v /srv/gitlab-runner/config:/etc/gitlab-runner \
    gitlab/gitlab-runner:latest
```
`docker exec -it gitlab-runner bash` \
`gitlab-runner list` список сборщиков \
`gitlab-runner verify` проверка \
`gitlab-runner restart` применить настройки \
`gitlab-runner status` статус \
`gitlab-runner unregister --all-runners` удалить все регистрации \
`gitlab-runner install` установить службу \
`gitlab-runner run` запустить с выводом в консоль

`gitlab-runner register`
```
Enter the GitLab instance URL (for example, https://gitlab.com/): http://192.168.3.101/
Enter the registration token: GR1348941enqAxqQgm8AZJD_g7vme
Enter an executor: shell
```
`cat /etc/gitlab-runner/config.toml` конфигурация

Включить импорт проектов из GitHub: http://192.168.3.101/admin/application_settings/general#js-import-export-settings
```yaml
variables:
  PORT: 2024
  TITLE: "The+Rookie"

stages:
  - test

test:
  stage: test
  script:
    - |
        pwsh -Command "
            Write-Host PORT - $env:PORT
            Write-Host TITLE - $env:TITLE
            npm install
            Start-Process -NoNewWindow -FilePath 'npm' -ArgumentList 'start -- --port $env:PORT' -RedirectStandardOutput 'torapi.log'
            Start-Sleep -Seconds 5
            Invoke-RestMethod -Uri http://localhost:$env:PORT/api/search/title/all?query=$env:TITLE | Format-List
            Get-Content torapi.log
            Stop-Process -Name 'node' -Force -ErrorAction SilentlyContinue
        "
```
## Jenkins

`docker run -d --name=jenkins -p 8080:8080 -p 50000:50000 --restart=unless-stopped -v jenkins_home:/var/jenkins_home jenkins/jenkins:latest` \
`ls /var/lib/docker/volumes/jenkins_home/_data/jobs` директория хранящая историю сборок в хостовой системе \
`docker exec -it jenkins /bin/bash` подключиться к контейнеру \
`cat /var/jenkins_home/secrets/initialAdminPassword` получить токен инициализации
```
docker run -d \
  --name jenkins-remote-agent-01 \
  --restart unless-stopped \
  -e JENKINS_URL=http://192.168.3.101:8080 \
  -e JENKINS_AGENT_NAME=remote-agent-01 \
  -e JENKINS_SECRET=3ad54fc9f914957da8205f8b4e88ff8df20d54751545f34f22f0e28c64b1fb29 \
  -v jenkins_agent:/home/jenkins \
  jenkins/inbound-agent:latest

# Или ссылаться на локальный контейнер сервера по имени
# --link jenkins:jenkins
# -e JENKINS_URL=http://jenkins:8080
```
`docker exec -u root -it jenkins-remote-agent-01 /bin/bash` подключиться к slave агенту под root \
`apt-get update && apt-get install -y iputils-ping netcat-openbsd` установить ping и nc на машину сборщика (slave)

`jenkinsVolumePath=$(docker inspect jenkins | jq -r .[].Mounts.[].Source)` получить путь к директории Jenkins в хостовой системе \
`sudo tar -czf $HOME/jenkins-backup.tar.gz -C $jenkinsVolumePath .` резервная копия всех файлов \
`(crontab -l ; echo "0 23 * * * sudo tar -czf /home/lifailon/jenkins-backup.tar.gz -C /var/lib/docker/volumes/jenkins_home/_data .") | crontab -` \
`sudo tar -xzf $HOME/jenkins-backup.tar.gz -C /var/lib/docker/volumes/jenkins_home/_data` восстановление

`wget http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar -P $HOME/` скачать jenkins-cli (http://127.0.0.1:8080/manage/cli) \
`apt install openjdk-17-jre-headless` установить java runtime \
`java -jar jenkins-cli.jar -auth lifailon:password -s http://127.0.0.1:8080 -webSocket help` получить список команд \
`java -jar jenkins-cli.jar -auth lifailon:password -s http://127.0.0.1:8080 groovysh` запустить консоль Groovy \
`java -jar jenkins-cli.jar -auth lifailon:password -s http://127.0.0.1:8080 install-plugin ssh-steps -deploy` устанавливаем плагин SSH Pipeline Steps

### API
```PowerShell
$username = "Lifailon"
$password = "password"
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
$headers = @{Authorization=("Basic {0}" -f $base64AuthInfo)}
Invoke-RestMethod "http://192.168.3.101:8080/rssAll" -Headers $headers # RSS лента всех сборок и их статус в title
Invoke-RestMethod "http://192.168.3.101:8080/rssFailed" -Headers $headers # RSS лента всех неудачных сборок
$(Invoke-RestMethod "http://192.168.3.101:8080/computer/local-agent/api/json" -Headers $headers).offline # проверить статус работы slave агента

$jobs = Invoke-RestMethod "http://192.168.3.101:8080/api/json/job" -Headers $headers
$jobs.jobs.name # список всех проектов
$jobName = "Update SSH authorized_keys"
$job = Invoke-RestMethod "http://192.168.3.101:8080/job/${jobName}/api/json" -Headers $headers
$job.builds # список всех сборок
$buildNumber = $job.lastUnsuccessfulBuild.number # последняя неуспешная сборка
Invoke-RestMethod "http://192.168.3.101:8080/job/${jobName}/${buildNumber}/consoleText" -Headers $headers # вывести лог указанной сборки

$lastCompletedBuild = $job.lastCompletedBuild.number # последняя успешная сборка
$crumb = $(Invoke-RestMethod "http://192.168.3.101:8080/crumbIssuer/api/json" -Headers $headers).crumb # получаем временный токен доступа (crumb)
$headers["Jenkins-Crumb"] = $crumb # добавляем crumb в заголовки
$body = @{".crumb" = $crumb} # добавляем crumb в тело запроса
Invoke-RestMethod "http://192.168.3.101:8080/job/${jobName}/${lastCompletedBuild}/rebuild" -Headers $headers -Method POST -Body $body # перезапустить сборку
```
### Plugins

| Плагин                                                                         | Описание                                                                                                      |
| -                                                                              | -                                                                                                             |
| [Pipeline: Stage View](https://plugins.jenkins.io/pipeline-stage-view)         | Визуализация шагов (stages) в интерфейсе проекта с временем их выполнения.                                    |
| [Rebuilder](https://plugins.jenkins.io/rebuild)                                | Позволяет перезапускать параметризованную сборку с предустановленными параметрами в выбранной сборке.         |
| [Schedule Build](https://plugins.jenkins.io/schedule-build)                    | Позволяет запланировать сборку на указанный момент времени.                                                   |
| [Job Configuration History](https://plugins.jenkins.io/jobConfigHistory)       | Сохраняет копию файла сборки в формате `xml` (который хранится на сервере) и позволяет производить сверку.    |
| [Export Job Parameters](https://plugins.jenkins.io/export-job-parameters)      | Добавляет кнопку `Export Job Parameters` для конвертации все параметров в декларативный синтаксис Pipeline.   |
| [SSH Pipeline Steps](https://plugins.jenkins.io/ssh-steps)                     | Плагин для подключения к удаленным машинам через протокол ssh по ключу или паролю.                            |
| [Active Choices](https://plugins.jenkins.io/uno-choice)                        | Активные параметры, которые позволяют динамически обновлять содержимое параметров.                            |
| [File Parameters](https://plugins.jenkins.io/file-parameters)                  | Поддержка параметров для загрузки файлов (перезагрузить Jenkins для использования нового параметра).          |
| [Ansible](https://plugins.jenkins.io/ansible)                                  | Параметраризует запуск `ansible-playbook` (требуется установка на агенте) через метод `ansiblePlaybook`.      |
| [HTTP Request](https://plugins.jenkins.io/http_request)                        | Простой REST API Client для отправки и обработки `GET` и `POST` запросов через метод `httpRequest`.           |
| [Pipeline Utility Steps](https://plugins.jenkins.io/pipeline-utility-steps)    | Добавляет методы `readJSON` и `writeJSON`.                                                                    |
| [ANSI Color](https://plugins.jenkins.io/ansicolor)                             | Добавляет поддержку стандартных escape-последовательностей ANSI для покраски вывода.                          |
| [Email Extension](https://plugins.jenkins.io/email-ext)                        | Отправка сообщений на почту из Pipeline.                                                                      |
| [Test Results Analyzer](https://plugins.jenkins.io/test-results-analyzer)      | Показывает историю результатов сборки `junit` тестов в табличном древовидном виде.                            |
| [Embeddable Build Status](https://plugins.jenkins.io/embeddable-build-status)  | Предоставляет настраиваемые значки (like `shields.io`), который возвращает статус сборки.                     |
| [Prometheus Metrics](https://plugins.jenkins.io/prometheus)                    | Предоставляет конечную точку `/prometheus` с метриками, которые используются для сбора данных.                |
| [Web Monitoring](https://plugins.jenkins.io/monitoring)                        | Добавляет конечную точку `/monitoring` для отображения графиков мониторинга в веб-интерфейсе.                 |
| [CloudBees Disk Usage](https://plugins.jenkins.io/cloudbees-disk-usage-simple) | Отображает использование диска всеми заданиями во вкладке `Manage-> Disk usage`.                              |

### SSH Steps and Artifacts

Добавляем логин и `Private Key` для авторизации по ssh: `Manage (Settings)` => `Credentials` => `Global` => `Add credentials` => Kind: `SSH Username with private key`

Сценарий проверяет доступность удаленной машины, подключается к ней по ssh, выполняет скрипт [hwstat](https://github.com/Lifailon/hwstat) для сбора метрик и выгружает json отчет в артефакты:
```Groovy
// Глобальный массив для хранения данных подключения по ssh 
def remote = [:]

pipeline {
    agent { label 'local-agent' }
    parameters {
        string(name: 'address', defaultValue: '192.168.3.105', description: 'Адрес удаленного сервера')
        // choice(name: "addresses", choices: ["192.168.3.101","192.168.3.102"], description: "Выберите сервер из выпадающего списка")
        string(name: 'port', defaultValue: '2121', description: 'Порт ssh')
        string(name: 'credentials', defaultValue: 'd5da50fc-5a98-44c4-8c55-d009081a861a', description: 'Идентификатор учетных данных из Jenkins')
        booleanParam(name: "root", defaultValue: false, description: 'Запуск с повышенными привилегиями')
        booleanParam(name: "report", defaultValue: true, description: 'Выгружать отчет в формате json')
    }
    // triggers {
    //     cron('H */6 * * 1-5') // выполнять запуск каждын 6 часов с понедельника по пятницу
    // }
    options {
        timeout(time: 5, unit: 'MINUTES') // период ожидания, после которого нужно прервать Pipeline
        retry(2) // в случае неудачи повторить весь Pipeline указанное количество раз
    }
    environment {
        // Переменная окружения для хранения пути временного файла с содержимым приватного ключа
        SSH_KEY_FILE = "/tmp/ssh_key_${UUID.randomUUID().toString()}"
    }
    stages {
        stage('Проверка доступности хоста (icmp и tcp)') {
            steps {
                script {
                    def check = sh(
                        script: """
                            ping -c 1 ${params.address} > /dev/null || exit 1
                            nc -z ${params.address} ${params.port} || exit 2
                        """,
                        returnStatus: true // исключить завершение Pipeline с ошибкой
                    )
                    if (check == 1) {
                        error("Сервер ${params.address} недоступен (icmp ping)")
                    } else if (check == 2) {
                        error("Порт ${params.port} закрыт (tcp check)")
                    } else {
                        echo "Сервер ${params.address} доступен и порт ${params.port} открыт"
                    }
                }
            }
        }
        stage('Извлечение данных для авторизации по ключу') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: params.credentials, usernameVariable: 'SSH_USER', keyFileVariable: 'SSH_KEY', passphraseVariable: '')]) {
                        // Записываем содержимое приватного ключа во временный файл
                        writeFile(file: env.SSH_KEY_FILE, text: readFile(SSH_KEY))
                        sh "chmod 600 ${env.SSH_KEY_FILE}"
                        remote.name = params.address
                        remote.host = params.address
                        remote.port = params.port.toInteger()
                        remote.user = SSH_USER
                        remote.identityFile = env.SSH_KEY_FILE
                        remote.allowAnyHosts = true
                    }
                }
            }
        }
        stage('Запуск скрипта через через ssh') {
            steps {
                script {
                    def runCommand
                    if (params.root) {
                        runCommand = """
                            curl -sS https://raw.githubusercontent.com/Lifailon/hwstat/rsa/hwstat.sh | sudo bash -s -- "json" > "hwstat-report.json"
                        """
                    } else {
                        runCommand = """
                            curl -sS https://raw.githubusercontent.com/Lifailon/hwstat/rsa/hwstat.sh | bash -s -- "json" > "hwstat-report.json"
                        """
                    }
                    def jsonOutput = sshCommand remote: remote, command: runCommand
                    if (params.report) {
                        // Записать содержимое переменной в файл
                        // writeFile file: 'hwstat-report.json', text: jsonOutput
                        // Загрузить файл из удаленной машины
                        sshGet remote: remote, from: "hwstat-report.json", into: "${env.WORKSPACE}/hwstat-report.json", override: true
                    }
                    sshCommand remote: remote, command: "rm hwstat-report.json"
                }
            }
        }
        stage('Загрузка json отчета в Jenkins') {
            // Проверка условия перед выполнением шага (пропуск если false)
            when {
                expression { params.report }
            }
            steps {
                archiveArtifacts artifacts: 'hwstat-report.json', allowEmptyArchive: true
            }
        }
    }
    post {
        // Выполнять независимо от успеха или ошибки
        always {
            script {
                sh "rm -f ${env.SSH_KEY_FILE}"
            }
        }
        success   { echo "Сборка завершена успешно" }
        failure   { echo "Сборка завершилась с ошибкой" }
        unstable  { echo "Сборка завершилась с предупреждениями" }
        changed   { echo "Текущий статус завершения изменился по сравнению с предыдущим запуском" }
        fixed     { echo "Сборка завершена успешно по сравнению с предыдущим запуском" }
        aborted   { echo "Запуск был прерван" }
    }
}
```
### Upload File Parameter

Передача файла через параметр и чтение его содержимого:
```Groovy
pipeline {
    agent any
    parameters {
        base64File 'UPLOAD_FILE'
    }
    stages {
        stage('Читаем содержимое файла') {
            steps {
                // Переменная хранит содержимое файла в формате base64
                // echo UPLOAD_FILE
                // Декодируем base64
                withFileParameter('UPLOAD_FILE') {
                    sh """
                        echo "$UPLOAD_FILE" # выводим путь к временному файлу с содержимым переданного файла
                        cat "$UPLOAD_FILE"  # читаем содержимое файла
                    """
                }
            }
        }
    }
}
```
### Input Text and File

Останавливает выполнение `Pipeline` и заставляет пользователя передать текстовый параметр и файл:
```Groovy
pipeline {
    agent any
    stages {
        stage('Input text') {
            input {
                message "Что бы продолжить, передайте текст в поле ввода"
                ok "Передать"
                parameters {
                    string(name: 'TEXT', defaultValue: 'test', description: 'Введите текст')
                }
            }
            steps {
                echo "Переданный текст в параметре input: ${TEXT}"
            }
        }
        stage('Input file') {
            steps {
                script {
                    def fileBase64 = input message: "Передайте файл", parameters: [base64File('file')]
                    sh "echo $fileBase64 | base64 -d"
                }
            }
        }
    }
}
```
### HttpURLConnection

Любой код Groovy возможно запустить и проверить через `Script Console` (http://127.0.0.1:8080/manage/script)

Пример `API` запроса к репозиторию PowerShell на GitHub для получения последней версии и всех доступных версий:
```Groovy
import groovy.json.JsonSlurper
def url = new URL("https://api.github.com/repos/PowerShell/PowerShell/tags")
def connection = url.openConnection()
connection.setRequestMethod("GET")
connection.setRequestProperty("Accept", "application/json")
def responseCode = connection.getResponseCode()
if (responseCode == 200) {
    // Получаем данные ответа
    def response = connection.getInputStream().getText()
    // Парсим JSON ответ
    def jsonSlurper = new JsonSlurper()
    def tags = jsonSlurper.parseText(response)
    // Проверяем количество элементов в массиве
    if (tags.size() > 0) {
        // Забираем последний тег из списка
        def latestTag = tags[0].name
        println("Latest version: " + latestTag)
        println()
        // Проходимся по всем тегам
        println("List of all versions:")
        for (tag in tags) {
            println(tag.name)
        }
    } else {
        error("No tags found in the response")
    }
} else {
    error("Failed to call API, response code: ${responseCode}")
}
connection.disconnect()
```
### httpRequest

Пример HTTP запроса и чтения `json` файла с помощью плагинов `HTTP Request` и `Pipeline Utility Steps`:
```groovy
pipeline {
    agent any
    stages {
        stage('HTTP Request and Read JSON') {
            steps {
                script {
                    def url = "https://torapi.vercel.app/api/provider/list"
                    def response = httpRequest(url: url, httpMode: "GET", contentType: "APPLICATION_JSON")
                    echo "${response.status}"
                    echo "${response.headers}"
                    echo "${response.content}"
                    def jsonData = readJSON(text: response.content)
                    echo "Url array: ${jsonData[0].Urls}"
                    echo "One url: ${jsonData[0].Urls[0]}"
                    for (u in jsonData[0].Urls) {
                        echo u
                    }
                    writeJSON(file: "debug.json", json: jsonData)
                    archiveArtifacts "debug.json"
                }
            }
        }
    }
}
```
### Active Choices Parameter

Пример получения списка доступных версий в выбранном репозитории и содержимого файлов для выбранного релиза, а также загрузка указанного файла:
```Groovy
pipeline {
    agent any
        parameters {
        activeChoice(
            name: 'Repos',
            description: 'Select repository.',
            choiceType: 'PT_RADIO',
            filterable: false,
            script: [
                $class: 'GroovyScript',
                script: [
                    sandbox: true,
                    script: '''
                        return [
                            'Lifailon/lazyjournal',
                            'jesseduffield/lazydocker'
                        ]
                    '''
                ]
            ]
        )
        reactiveChoice(
            name: 'Versions',
            description: 'Select version.',
            choiceType: 'PT_SINGLE_SELECT',
            filterable: true,
            filterLength: 1,
            script: [
                $class: 'GroovyScript',
                script: [
                    sandbox: true,
                    script: '''
                        import groovy.json.JsonSlurper
                        def selectedRepo = Repos
                        def apiUrl = "https://api.github.com/repos/${selectedRepo}/tags"
                        def conn = new URL(apiUrl).openConnection()
                        conn.setRequestProperty("User-Agent", "Jenkins")
                        def response = conn.getInputStream().getText()
                        def json = new JsonSlurper().parseText(response)
                        def versionsCount = json.size()
                        def data = []
                        for (int i = 0; i < versionsCount; i++) {
                            data += json.name[i]
                        }
                        return data
                    '''
                ]
            ],
            referencedParameters: 'Repos'
        )
        reactiveChoice(
            name: 'Files',
            description: 'Select file.',
            choiceType: 'PT_SINGLE_SELECT',
            filterable: true,
            filterLength: 1,
            script: [
                $class: 'GroovyScript',
                script: [
                    sandbox: true,
                    script: '''
                        import groovy.json.JsonSlurper
                        def selectedRepo = Repos
                        def selectedVer = Versions
                        def apiUrl = "https://api.github.com/repos/${selectedRepo}/releases/tags/${selectedVer}"
                        def conn = new URL(apiUrl).openConnection()
                        conn.setRequestProperty("User-Agent", "Jenkins")
                        def response = conn.getInputStream().getText()
                        def json = new JsonSlurper().parseText(response)
                        def data = []
                        for (file in json.assets) {
                            data += file.name
                        }
                        return data
                    '''
                ]
            ],
            referencedParameters: 'Repos,Versions'
        )
    }
    stages {
        stage('Selected parameters') {
            steps {
                script {
                    echo "Selected repository: https://github.com/${params.Repos}"
                    echo "Selected version: ${params.Versions}"
                    echo "Selected file: ${params.Files}"
                    def downloadUrl = "https://github.com/${params.Repos}/releases/download/${params.Versions}/${params.Files}"
                    echo "Url for download: ${downloadUrl}"
                    httpRequest(url: downloadUrl, outputFile: params.Files)
                    archiveArtifacts params.Files
                }
            }
        }
    }
}
```
### Vault

Интеграция [HashiCorp Vault](https://github.com/hashicorp/vault) в Jenkins Pipeline через `REST API` для получения содержимого секретов и использовая в последующих стадиях/этапах сборки:
```Groovy
def getVaultSecrets(
    String address,
    String path,
    String token
) {
    def url = new URL("${address}/${path}")
    
    def connection = url.openConnection()
    connection.setRequestMethod("GET")
    connection.setRequestProperty("X-Vault-Token", token)
    connection.setRequestProperty("Accept", "application/json")
    
    def response = new groovy.json.JsonSlurper().parse(connection.inputStream)
    def user = response.data.data.user
    def password = response.data.data.password
    return [
        user: user,
        password: password
    ]
}

def USER_NAME
def USER_PASS

pipeline {
    agent any
    parameters {
        string(name: 'url', defaultValue: 'http://192.168.3.101:8200', description: 'Url адресс хранилища секретов')
        string(name: 'path', defaultValue: 'v1/kv/data/ssh-auth', description: 'Путь для извлечения секретов')
        password(name: 'token', defaultValue: 'hvs.bySybhyYOxSWEVk4FQDdcyyg', description: 'Токен доступа к API HashiCorp Vault')
    }
    stages {
        stage('Get vault secrets') {
            steps {
                script {
                    def secrets = getVaultSecrets(
                        "${params.url}",
                        "${params.path}",
                        "${params.token}"
                    )
                    USER_NAME = secrets.user
                    USER_PASS = secrets.password
                }
            }
        }
        stage('Use secrets') {
            steps {
                script {
                    echo "User: ${USER_NAME}"
                    echo "Password: ${USER_PASS}"
                }
            }
        }
    }
}
```
### Email Extension

Для отправки на почту и настроить SMTP сервер в настройках Jenkins (`System` => `Extended E-mail Notification`)

SMTP server: `smtp.yandex.ru`
SMTP port: `587`
Credentials: `Username with password` (`username@yandex.ru` и `app-password`)
`Use TLS`
Default Content Type: `HTML (text/html)`

Настройка логирования в System Log: `emailDebug` + фильтр `hudson.plugins.emailext` и уровень `ALL`
```Groovy
pipeline {
    agent any
    parameters {
        string(name: 'emailTo', defaultValue: 'test@yandex.ru', description: 'Почтовый адрес назначения')
    }
    stages {
        stage('Вывод всех переменных окружения') {
            steps {
                script {
                    env.getEnvironment().each { key, value ->
                        echo "${key} = ${value}"
                    }
                }
            }
        }
        stage('Отправка на почту') {
            options {
                timeout(time: 1, unit: 'MINUTES')
            }
            steps {
                script {
                    emailext (
                        to:	"${params.emailTo}",
                        subject: "${env.JOB_NAME} - ${BUILD_NUMBER}",
                        mimeType: "text/html",
                        body: """
                            <html>
                                <body>
                                    <div style="padding-left: 30px; padding-bottom: 15px;" color="blue">
                                    <font name="Arial" color="#906090" size="3" font-weight="normal">
                                        <b> ${env.JOB_NAME} - ${env.BUILD_NUMBER} </b>
                                    </font>
                                    <br>
                                    <div style="padding-left: 30px; padding-bottom: 15px;" color="black">
                                    <br>
                                    <font name="Arial" color="black" size="2" font-weight="normal"> 
                                        <pre> Build url: ${env.BUILD_URL} </pre>
                                    </font>	
                                </body>
                            </html>
                        """
                    )
                }
            }
        }
    }
}
```
### Parallel
```Groovy
pipeline {
    agent any
    stages {
        stage('Parallel sleeps') {
            parallel {
                stage('Task 1') {
                    steps {
                        script {
                            def currentTime = new Date().format('yyyy-MM-dd HH:mm:ss')
                            echo "[${currentTime}] Начало задачи 1"
                            sh 'sleep 10'
                            currentTime = new Date().format('yyyy-MM-dd HH:mm:ss')
                            echo "[${currentTime}] Завершение задачи 1"
                        }
                    }
                }
                stage('Task 2') {
                    steps {
                        script {
                            def currentTime = new Date().format('yyyy-MM-dd HH:mm:ss')
                            echo "[${currentTime}] Начало задачи 2"
                            sh 'sleep 5'
                            currentTime = new Date().format('yyyy-MM-dd HH:mm:ss')
                            echo "[${currentTime}] Завершение задачи 2"
                        }
                    }
                }
            }
        }
        stage('Parallel tasks via loop') {
            steps {
                script {
                    // Массив, где ключи содержит имя задачи, а значение содержит блоки кода для выполнения
                    def tasks = [:]
                    def taskNames = ['Task 1', 'Task 2', 'Task 3']
                    taskNames.each { taskName ->
                        tasks[taskName] = {
                            def currentTime = new Date().format('yyyy-MM-dd HH:mm:ss')
                            echo "[${currentTime}] Начало задачи: $taskName"
                            sh "sleep ${taskName == 'Task 1' ? 10 : taskName == 'Task 2' ? 5 : 3}"
                            currentTime = new Date().format('yyyy-MM-dd HH:mm:ss')
                            echo "[${currentTime}] Завершение задачи: $taskName"
                        }
                    }
                    parallel tasks
                }
            }
        }
    }
}
```
## Groovy

Базовый синтаксис языка `Groovy`:
```Groovy
// Переменные
javaString = 'java'
javaString
println javaString
javaString.class    // class java.lang.String
println 100.class   // class java.lang.Integer
j = '${javaString}' // не принимает переменные в одинарных кавычках
groovyString = "${javaString}"
bigGroovyString = """
    ${javaString}
    ${j}
    ${groovyString}
    ${2 + 2}
"""

// java
// ${javaString}
// java
// 4

a = "a"   // a
a + "123" // a123
a * 5     // aaaaa

// Массивы и списки
list =[1,2,3]
list[0]    // 1
list[0..1] // [1, 2]
range = "0123456789"
range[1..5] // 12345
map = [key1: true, key2: false]
map["key1"] // true
server = [:]
server.ip = "192.168.3.1"
server.port = 22
println(server) // [ip:192.168.3.1, port:22]

// Функции
def sum(a,b) {
    println a+b
}
sum(2,2) // 4

// Условия
def diff(x) {
    if (x < 10) {
        println("${x} < 10")
    } else if (x == 10) {
        println("${x} = 10")
    } else {
        println("${x} > 10")
    }
}
diff(11) // 11 > 10

// Циклы
list.each { l ->
    print l
}
// 123

for (i in 0..5) { 
    print i
}
// 012345

for (int i = 0; i < 10; i++) {
    print i
}
// 0123456789

i = 0
while (i < 3) {
    println(i)
    i++
}
// 0
// 1
// 2

// Классы
def str = "start"
println str
class Main {
    def echo (param) {
        println param
    }
}
def main = new Main()
def array = [1, 2, 3]
for (element in array) {
    main.echo(element)
}
// 1
// 2
// 3

// Обработка ошибок
def newList = [:]
newList[0] = 1
newList[1] = 2
for (index in 0..1) {
    try {
        newList[index] += 3
        main.echo(newList[index])
    } catch (Exception e) {
        main.echo("Ошибка: ${e.message}")
    } finally {
        if (newList[index] >= 5) {
            main.echo(newList[index]+1)
        }
    }
}
// 4
// 5
// 6

println str.replace("start", "final")

// Коллекция для синхронизации сохранения данных в потоках
def sharedList = Collections.synchronizedList([])
// Анонимная функция для обработки данных в потоке
def runTask = { name, delay ->
    Thread.start {
        println "${name} запущена в потоке ${Thread.currentThread().name}"
        sleep(delay)
        println "${name} завершена"
        synchronized(sharedList) {
            sharedList << "${name} завершена"
        }
    }
}

def threads = []
// Ждём завершения всех потоков
threads << runTask("Задача 1", 3000)
threads << runTask("Задача 2", 2000)
threads << runTask("Задача 3", 1000)

threads*.join()
println "Результат: $sharedList"

// Функции строк
" text ".trim()                     // удаляет пробелы в начале и конце => "text"
"ping".replace("i", "o")            // заменяет буквы в строке => pong
"a,b,c".split(",")                  // разбивает строку по разделителю => ["a", "b", "c"]
"abc".size()                        // возвращает длину строки или размер списка (кол-во элементов) => 3
"abc".reverse()                     // переворачивает строку => "cba"
"abc".contains("b")                 // проверяет наличие подстроки => true
"abc".startsWith("a")               // проверяет начало строки => true
"abc".endsWith("c")                 // проверяет конец строки => true
"123".isNumber()                    // проверяет, является ли строка числом => true
"abc".matches("a.*")                // проверяет соответствие регулярному выражения => true
"hello".toUpperCase()               // преобразует строку в верхний регистр => "HELLO"
"HELLO".toLowerCase()               // преобразует строку в нижний регистр => "hello"

// Функции массивов
["a","b","c"].join(",")             // объединяет элементы в строку => "a,b,c"
["a","b","c"].contains("b")         // проверяет наличие элемента => true
[1, 2, 3].sum()                     // суммирует элементы => 6
[1, 2, 3].max()                     // находит максимум => 3
[1, 2, 3].min()                     // находит минимум => 1
[1, 2, 3].average()                 // вычисляет среднее => 2
[1, 2, 3].reverse()                 // переворачивает список => [3, 2, 1]
[3, 2, 1].sort()                    // сортирует список => [1, 2, 3]
[1, 2, 2, 3, 3].unique()            // удаляет дубли => [1, 2, 3]
[1, 2, 3].findAll { it > 1 }        // фильтрует элементы => [2, 3]
[1, 2, 3].collect { it * 2 }        // преобразует элементы => [2, 4, 6]
["1","2"].collect {it.toInteger()}  // строки => числа => [1, 2]

def users = [
    [name: "Alex", age: 30],
    [name: "Jack", age: 35]
]  
users.collect { it.name }
// ["Alex", "Jack"]

// Функции карт (map)
["a": 1, "b": 2].get("a")                       // получает значение по ключу => 1
["a": 1, "b": 2].keySet()                       // возвращает все ключи => ["a", "b"]
["a": 1, "b": 2].values()                       // возвращает все значения => [1, 2]
["a": 1, "b": 2].containsKey("a")               // проверяет наличие ключа => true
["a": 1, "b": 2].findAll { k, v -> v > 1 }      // фильтрует записи => ["b": 2]
["a": 1, "b": 2].collect { k, v -> "$k-$v" }    // преобразует => ["a-1", "b-2"]
["a": 1].put("b", 2)                            // добавляет новую пару ключ-значение => ["a": 1, "b": 2]
["a": 1].plus(["b": 2])                         // объединяет мапы => ["a": 1, "b": 2]

// Директории и файлы
new File("dir").mkdir()                         // создает директорию => boolean
new File("dir/subdir").mkdirs()                 // создает все недостающие директории d genb => boolean
new File("dir").list()                          // список имен файлов => String[]
new File("dir").listFiles()                     // возвращает список файлов в директории => File[]
new File("dir").deleteDir()                     // удаляет директорию (рекурсивно) => boolean
new File("dir").isDirectory()                   // проверяет, что это директория => boolean
new File("file.txt").createNewFile()            // создает пустой файл => boolean
new File("file.txt").delete()                   // удаляет файл => boolean
new File("file.txt").exists()                   // проверяет существование файла => boolean
new File("file.txt").isFile()                   // проверяет, что это файл => boolean
new File("file.txt").length()                   // возвращает размер файла в байтах => long
new File("file.txt").lastModified()             // возвращает время последнего изменения => long (timestamp)
new File("file.txt").getName()                  // возвращает имя файла (без пути) => String
new File("file.txt").getPath()                  // возвращает относительный путь => String
new File("file.txt").getAbsolutePath()          // возвращает абсолютный путь => String
new File("file.txt").text                       // читает содержимое файла в строку
new File("file.txt").getText("UTF-8")           // указать кодировку при чтение
new File("file.txt").readBytes()                // читает файл как массив байтов => byte[]
new File("file.txt").readLines()                // читает файл построчно (получаем массив из строк) => List<String>
new File("file.txt").eachLine { it }            // обработать каждую строку
new File("file.txt").write("text")              // перезаписывает файл (если существует) => void
new File("file.txt").setText("text")            // аналог write() => void
new File("file.txt").bytes = [1, 2, 3]          // записывает массив байтов => void
new File("file.txt") << "text"                  // добавляет текст в конец файла => void
```
## Ansible

`apt -y update && apt -y upgrade` \
`apt -y install ansible` v2.10.8 \
`apt -y install ansible-core` v2.12.0 \
`apt -y install sshpass`

`ansible-galaxy collection install ansible.windows` установить коллекцию модулей \
`ansible-galaxy collection install community.windows` \
`ansible-galaxy collection list | grep windows` \
`ansible-config dump | grep DEFAULT_MODULE_PATH` путь хранения модулей

`apt-get -y install python-dev libkrb5-dev krb5-user` пакеты для Kerberos аутентификации \
`apt install python3-pip` \
`pip3 install requests-kerberos` \
`nano /etc/krb5.conf` настроить [realms] и [domain_realm] \
`kinit -C support4@domail.local` \
`klist`

`ansible --version` \
`config file = None` \
`nano /etc/ansible/ansible.cfg` файл конфигурации
```yaml
[defaults]
inventory = /etc/ansible/hosts
# uncomment this to disable SSH key host checking
# Отключить проверку ключа ssh (для подключения используя пароль)
host_key_checking = False
```
### Hosts

`nano /etc/ansible/hosts`
```yaml
[us]
pi-hole-01 ansible_host=192.168.3.101
zabbix-01 ansible_host=192.168.3.102
grafana-01 ansible_host=192.168.3.103
netbox-01 ansible_host=192.168.3.104

[all:vars]
ansible_ssh_port=2121
ansible_user=lifailon
ansible_password=123098
path_user=/home/lifailon
ansible_python_interpreter=/usr/bin/python3

[ws]
huawei-book-01 ansible_host=192.168.3.99
plex-01 ansible_host=192.168.3.100

[ws:vars]
ansible_port=5985
#ansible_port=5986
ansible_user=Lifailon
#ansible_user=support4@DOMAIN.LOCAL
ansible_password=123098
ansible_connection=winrm
ansible_winrm_scheme=http
ansible_winrm_transport=basic
#ansible_winrm_transport=kerberos
ansible_winrm_server_cert_validation=ignore
validate_certs=false

[win_ssh]
huawei-book-01 ansible_host=192.168.3.99
plex-01 ansible_host=192.168.3.100

[win_ssh:vars]
ansible_python_interpreter=C:\Users\Lifailon\AppData\Local\Programs\Python\Python311\` добавить переменную среды интерпритатора Python в Windows
ansible_connection=ssh
#ansible_shell_type=cmd
ansible_shell_type=powershell
```
`ansible-inventory --list` проверить конфигурацию (читает в формате JSON) или YAML (-y) с просмотром все применяемых переменных

### Windows Modules

`ansible us -m ping` \
`ansible win_ssh -m ping` \
`ansible us -m shell -a "uptime && df -h | grep lv"` \
`ansible us -m setup | grep -iP "mem|proc"` информация о железе \
`ansible us -m apt -a "name=mc" -b` повысить привилегии sudo (-b) \
`ansible us -m service -a "name=ssh state=restarted enabled=yes" -b` перезапустить службу \
`echo "echo test" > test.sh` \
`ansible us -m copy -a "src=test.sh dest=/root mode=777" -b` \
`ansible us -a "ls /root" -b` \
`ansible us -a "cat /root/test.sh" -b`

`ansible-doc -l | grep win_` [список всех модулей Windows](https://docs.ansible.com/ansible/latest/collections/ansible/windows/) \
`ansible ws -m win_ping` windows модуль \
`ansible ws -m win_ping -u WinRM-Writer` указать логин \
`ansible ws -m setup` собрать подробную информацию о системе \
`ansible ws -m win_whoami` информация о правах доступах, группах доступа \
`ansible ws -m win_shell -a '$PSVersionTable'` \
`ansible ws -m win_shell -a 'Get-Service | where name -match "ssh|winrm"'` \
`ansible ws -m win_service -a "name=sshd state=stopped"` \
`ansible ws -m win_service -a "name=sshd state=started"`

- win_shell (vars/debug)

`nano /etc/ansible/PowerShell-Vars.yml`
```yaml
- hosts: ws
 ` Указать коллекцию модулей
  collections:
  - ansible.windows
 ` Задать переменные
  vars:
    SearchName: PermitRoot
  tasks:
  - name: Get port ssh
    win_shell: |
      Get-Content "C:\Programdata\ssh\sshd_config" | Select-String "{{SearchName}}"
   ` Передать вывод в переменную
    register: command_output
  - name: Output port ssh
   ` Вывести переменную на экран
    debug:
      var: command_output.stdout_lines
```
`ansible-playbook /etc/ansible/PowerShell-Vars.yml` \
`ansible-playbook /etc/ansible/PowerShell-Vars.yml --extra-vars "SearchName='LogLevel|Syslog'"` передать переменную

- win_powershell

`nano /etc/ansible/powershell-param.yml`
```yaml
- hosts: ws
  tasks:
  - name: Run PowerShell script with parameters
    ansible.windows.win_powershell:
      parameters:
        Path: C:\Temp
        Force: true
      script: |
        [CmdletBinding()]
        param (
          [String]$Path,
          [Switch]$Force
        )
        New-Item -Path $Path -ItemType Directory -Force:$Force
```
`ansible-playbook /etc/ansible/powershell-param.yml`

- win_chocolatey

`nano /etc/ansible/setup-adobe-acrobat.yml`
```yaml
- hosts: ws
  tasks:
  - name: Install Acrobat Reader
    win_chocolatey:
      name: adobereader
      state: present
```
`ansible-playbook /etc/ansible/setup-adobe-acrobat.yml`

`nano /etc/ansible/setup-openssh.yml`
```yaml
- hosts: ws
  tasks:
  - name: install the Win32-OpenSSH service
    win_chocolatey:
      name: openssh
      package_params: /SSHServerFeature
      state: present
```
`ansible-playbook /etc/ansible/setup-openssh.yml`

- win_regedit

`nano /etc/ansible/win-set-shell-ssh-ps7.yml`
```yaml
- hosts: ws
  tasks:
  - name: Set the default shell to PowerShell 7 for Windows OpenSSH
    win_regedit:
      path: HKLM:\SOFTWARE\OpenSSH
      name: DefaultShell
     ` data: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
      data: 'C:\Program Files\PowerShell\7\pwsh.exe'
      type: string
      state: present
```
`ansible-playbook /etc/ansible/win-set-shell-ssh-ps7.yml`

- win_service

`nano /etc/ansible/win-service.yml`
```yaml
- hosts: ws
  tasks:
  - name: Start service
    win_service:
      name: sshd
      state: started
#     state: stopped
#     state: restarted
#     start_mode: auto
```
`ansible-playbook /etc/ansible/win-service.yml`

- win_service_info

`nano /etc/ansible/get-service.yml`
```yaml
- hosts: ws
  tasks:
  - name: Get info for a single service
    win_service_info:
      name: sshd
    register: service_info
  - name: Print returned information
    ansible.builtin.debug:
      var: service_info.services
```
`ansible-playbook /etc/ansible/get-service.yml`

- fetch/slurp

`nano /etc/ansible/copy-from-win-to-local.yml`
```yaml
- hosts: ws
  tasks:
  - name: Retrieve remote file on a Windows host
#   Скопировать файл из Windows-системы
    ansible.builtin.fetch:
#   Прочитать файл (передать в память в формате Base64)
#   ansible.builtin.slurp:
      src: C:\Telegraf\telegraf.conf
      dest: /root/telegraf.conf
      flat: yes
    register: telegraf_conf
  - name: Print returned information
    ansible.builtin.debug:
      msg: "{{ telegraf_conf['content'] | b64decode }}"
```
`ansible-playbook /etc/ansible/copy-from-win-to-local.yml`

- win_copy

`echo "Get-Service | where name -eq vss | Start-Service" > /home/lifailon/Start-Service-VSS.ps1` \
`nano /etc/ansible/copy-file-to-win.yml`
```yaml
- hosts: ws
  tasks:
  - name: Copy file to win hosts
    win_copy:
      src: /home/lifailon/Start-Service-VSS.ps1
      dest: C:\Users\Lifailon\Desktop\Start-Service-VSS.ps1
```
`ansible-playbook /etc/ansible/copy-file-to-win.yml`

`curl -OL https://github.com/PowerShell/PowerShell/releases/download/v7.3.6/PowerShell-7.3.6-win-x64.msi` \
`nano /etc/ansible/copy-file-to-win.yml`
```yaml
- hosts: ws
  tasks:
  - name: Copy file to win hosts
    win_copy:
      src: /home/lifailon/PowerShell-7.3.6-win-x64.msi
      dest: C:\Install\PowerShell-7.3.6.msi
```
`ansible-playbook /etc/ansible/copy-file-to-win.yml`

- win_command

`nano /etc/ansible/run-script-ps1.yml`
```yaml
- hosts: ws
  tasks:
  - name: Run PowerShell Script
    win_command: powershell -ExecutionPolicy ByPass -File C:\Users\Lifailon\Desktop\Start-Service-VSS.ps1
```
`ansible-playbook /etc/ansible/run-script-ps1.yml`

- win_package

`nano /etc/ansible/setup-msi-package.yml`
```yaml
- hosts: ws
  tasks:
  - name: Install MSI Package
    win_package:
#     path: C:\Install\7z-23.01.msi
      path: C:\Install\PowerShell-7.3.6.msi
      arguments:
        - /quiet
        - /passive
        - /norestart
```
`ansible-playbook /etc/ansible/setup-msi-package.yml`

- win_firewall_rule

`nano /etc/ansible/win-fw-open.yml`
```yaml
- hosts: ws
  tasks:
  - name: Open RDP port
    win_firewall_rule:
      name: Open RDP port
      localport: 3389
      action: allow
      direction: in
      protocol: tcp
      state: present
      enabled: yes
```
`ansible-playbook /etc/ansible/win-fw-open.yml`

- win_group

`nano /etc/ansible/win-creat-group.yml`
```yaml
- hosts: ws
  tasks:
  - name: Create a new group
    win_group:
      name: deploy
      description: Deploy Group
      state: present
```
`ansible-playbook /etc/ansible/win-creat-group.yml`

- win_group_membership

`nano /etc/ansible/add-user-to-group.yml`
```yaml
- hosts: ws
  tasks:
  - name: Add a local and domain user to a local group
    win_group_membership:
      name: deploy
      members:
        - WinRM-Writer
      state: present
```
`ansible-playbook /etc/ansible/add-user-to-group.yml`

- win_user

`nano /etc/ansible/creat-win-user.yml`
```yaml
- hosts: ws
  tasks:
  - name: Creat user
    win_user:
      name: test
      password: 123098
      state: present
      groups:
        - deploy
```
`ansible-playbook /etc/ansible/creat-win-user.yml`

`nano /etc/ansible/delete-win-user.yml`
```yaml
- hosts: ws
  tasks:
  - name: Delete user
    ansible.windows.win_user:
      name: test
      state: absent
```
`ansible-playbook /etc/ansible/delete-win-user.yml`

- win_feature

`nano /etc/ansible/install-feature.yml`
```yaml
- hosts: ws
  tasks:
  - name: Install Windows Feature
      win_feature:
        name: SNMP-Service
        state: present
```
`ansible-playbook /etc/ansible/install-feature.yml`

- win_reboot

`nano /etc/ansible/win-reboot.yml`
```yaml
- hosts: ws
  tasks:
  - name: Reboot a slow machine that might have lots of updates to apply
    win_reboot:
      reboot_timeout: 3600
```
`ansible-playbook /etc/ansible/win-reboot.yml`

- win_find

`nano /etc/ansible/win-ls.yml`
```yaml
- hosts: ws
  tasks:
  - name: Find files in multiple paths
    ansible.windows.win_find:
      paths:
      - D:\Install\OpenSource
      patterns: ['*.rar','*.zip','*.msi']
     ` Файл созданный менее 7 дней назад
      age: -7d
     ` Размер файла больше 10MB
      size: 10485760
     ` Рекурсивный поиск (в дочерних директориях)
      recurse: true
    register: command_output
  - name: Output
    debug:
      var: command_output
```
`ansible-playbook /etc/ansible/win-ls.yml`

- win_uri

`nano /etc/ansible/rest-get.yml`
```yaml
- hosts: ws
  tasks:
  - name: REST GET request to endpoint github
    ansible.windows.win_uri:
      url: https://api.github.com/repos/Lifailon/pSyslog/releases/latest
    register: http_output
  - name: Output
    debug:
      var: http_output
```
`ansible-playbook /etc/ansible/rest-get.yml`

- win_updates

`nano /etc/ansible/win-update.yml`
```yaml
- hosts: ws
  tasks:
  - name: Install only particular updates based on the KB numbers
    ansible.windows.win_updates:
      category_names:
      - SecurityUpdates
      - CriticalUpdates
      - UpdateRollups
      - Drivers
     ` Фильтрация
     ` accept_list:
     ` - KB2267602
     ` Поиск обновлений
     ` state: searched
     ` Загрузить обновления
     ` state: downloaded
     ` Установить обновления
      state: installed
      log_path: C:\Ansible-Windows-Upadte-Log.txt
      reboot: false
    register: wu_output
  - name: Output
    debug:
      var: wu_output
```
`ansible-playbook /etc/ansible/win-update.yml`

- win_chocolatey

[Install](https://chocolatey.org/install) \
[API](https://community.chocolatey.org/api/v2/package/chocolatey) \
[Deployment](https://docs.chocolatey.org/en-us/guides/organizations/organizational-deployment-guide)
```yaml
- name: Ensure Chocolatey installed from internal repo
  win_chocolatey:
    name: chocolatey
    state: present
	# source: URL-адрес внутреннего репозитория
    source: https://community.chocolatey.org/api/v2/ChocolateyInstall.ps1
```
### Jinja

Локальное использование:

`pip install jinja2 --break-system-packages`

`inventory.j2` шаблон для генерации
```
[dev]
{% for host in hosts -%}
{{ host }} ansible_host={{ host }}
{% endfor %}
```
`env.json` файл с переменными
```json
{
  "hosts": ["192.168.3.101", "192.168.3.102", "192.168.3.103"]
}
```
`render.py` скрипт для генерации файла inventory
```Python
from jinja2 import Environment, FileSystemLoader
import json
# Загружаем переменные из JSON
with open('env.json') as f:
    data = json.load(f)
# Настройка шаблонизатора
env = Environment(loader=FileSystemLoader('.'))
template = env.get_template('inventory.j2')
output = template.render(data)
# Сохраняем результат в файл
with open('inventory.generated', 'w') as f:
    f.write(output)
```
`python render.py`

Использование в Ansible для обновления файла `hosts`:

`inventory.ini`
```
[dev]
dev1 ansible_host=192.168.3.101
dev2 ansible_host=192.168.3.102
dev3 ansible_host=192.168.3.103
```
`templates/hosts.j2`
```
127.0.0.1 localhost
{% for host in groups['all'] -%}
{{ hostvars[host]['ansible_host'] }} {{ host }}
{% endfor %}
```
`playbook.yml`
```yaml
- name: Update hosts file
  hosts: all
  become: true
  tasks:
    - name: Generate hosts file
      template:
        src: hosts.j2
        dest: /etc/hosts
        owner: root
        group: root
        mode: '0644'
```
`ansible-playbook -i inventory.ini playbook.yml --check --diff` отобразит изменения без их реального применения \
`ansible-playbook -i inventory.ini playbook.yml -K` позволяет передать пароль для root

## Puppet

### Bolt

[Bolt](https://github.com/puppetlabs/bolt) - это инструмент оркестровки, который выполняет заданную команду или группу команд на локальной рабочей станции, а также напрямую подключается к удаленным целям с помощью SSH или WinRM, что не требует установки агентов.

Docs: https://www.puppet.com/docs/bolt/latest/getting_started_with_bolt.html
```bash
wget https://apt.puppet.com/puppet-tools-release-bullseye.deb
sudo dpkg -i puppet-tools-release-bullseye.deb
sudo apt-get update
sudo apt-get install puppet-bolt
```
`nano inventory.yaml`
```yaml
groups:
- name: bsd
  targets:
    - uri: 192.168.3.102:22
      name: openbsd
    - uri: 192.168.3.103:22
      name: freebsd
  config:
    transport: ssh
    ssh:
      user: root
      # password: root
      host-key-check: false
```
`bolt command run uptime --inventory inventory.yaml --targets bsd` выполнить команду uptime на группе хостов bsd, заданной в файле inventory

`echo name: lazyjournal > bolt-project.yaml` создать файл проекта

`mkdir plans && nano test.yaml` создать директорию и файл с планом работ
```yaml
parameters:
  targets:
    type: TargetSpec

steps:
  - name: clone
    command: rm -rf lazyjournal && git clone https://github.com/Lifailon/lazyjournal
    targets: $targets

  - name: test
    command: cd lazyjournal && go test -v -cover --run TestMainInterface
    targets: $targets

  - name: remove
    command: rm -rf lazyjournal
    targets: $targets
```
`bolt plan show` вывести список всех планов

`bolt plan run lazyjournal::test --inventory inventory.yaml --targets bsd -v` запустить план

## Sake

[Sake](https://github.com/alajmo/sake) - это командный раннер для локальных и удаленных хостов. Вы определяете серверы и задачи в файле `sake.yaml`, а затем запускаете задачи на серверах.
```bash
curl -sfL https://raw.githubusercontent.com/alajmo/sake/main/install.sh | sh
sake init # инициализировать sake.yml файл
sake list servers # вывести список машин
sake list tags  # список тегов (группы серверов)
sake list tasks # список задач
sake run ping --all # запустить задачу на все хосты
sake exec --all "uname -a && uptime" # запустить команду на всех хостах
```
Пример конфигурации:
```yaml
servers:
  localhost:
    host: 0.0.0.0
    local: true
  obsd:
    host: root@192.168.3.102:22
    tags: [bsd]
  fbsd:
    host: root@192.168.3.103:22
    tags: [bsd]
    work_dir: /tmp

env:
  DATE: $(date -u +"%Y-%m-%dT%H:%M:%S%Z")

specs:
  info:
    output: table
    ignore_errors: true
    omit_empty_rows: true
    omit_empty_columns: true
    any_fatal_errors: false
    ignore_unreachable: true
    strategy: free

tasks:
  ping:
    desc: Pong
    spec: info
    cmd: echo "pong"

  uname:
    name: OS
    desc: Print OS
    spec: info
    cmd: |
      os=$(uname -s)
      release=$(uname -r)
      echo "$os $release"

  uptime:
    name: Uptime
    desc: Print uptime
    spec: info
    cmd: uptime

  info:
    desc: Get system overview
    spec: info
    tasks:
      - task: ping
      - name: date
        cmd: echo $DATE
      - name: pwd
        cmd: pwd
      - task: uname
      - task: uptime
```
`sake run info --tags bsd` запустить набор из 5 заданий из группы info

## Secret Manager

### Bitwarden

`choco install bitwarden-cli || npm install -g @bitwarden/cli || sudo snap install bw` установить bitwarden cli \
`bw login <email> --apikey` авторизвация в хранилище, используя client_id и client_secret \
`$session = bw unlock --raw` получить токен сессии \
`$items = bw list items --session $session | ConvertFrom-Json` получение всех элементов в хранилище с использованием мастер-пароля \
`echo "master_password" | bw get item GitHub bw get password $items[0].name` получить пароль по названию секрета \
`bw lock` завершить сессию
```PowerShell
# Авторизация в организации
$client_id = "organization.ClientId"
$client_secret = "client_secret"
$deviceIdentifier = [guid]::NewGuid().ToString()
$deviceName = "PowerShell-Client"
$response = Invoke-RestMethod -Uri "https://identity.bitwarden.com/connect/token" -Method POST `
    -Headers @{ "Content-Type" = "application/x-www-form-urlencoded" } `
    -Body @{
        grant_type = "client_credentials"
        scope = "api.organization"
        client_id = $client_id
        client_secret = $client_secret
        deviceIdentifier = $deviceIdentifier
        deviceName = $deviceName
    }
# Получение токена доступа
$accessToken = $response.access_token
# Название элемента в хранилище
$itemName = "GitHub"
# Поиск элемента в хранилище
$itemResponse = Invoke-RestMethod -Uri "https://api.bitwarden.com/v1/objects?search=$itemName" -Method GET `
    -Headers @{ "Authorization" = "Bearer $accessToken" }
$item = $itemResponse.data[0]
# Получение информации об элементе
$detailsResponse = Invoke-RestMethod -Uri "https://api.bitwarden.com/v1/objects/$($item.id)" -Method GET `
    -Headers @{ "Authorization" = "Bearer $accessToken" }
# Получение логина и пароля
$login = $detailsResponse.login.username
$password = $detailsResponse.login.password
```
### Infisical

`npm install -g @infisical/cli` \
`infisical login` авторизоваться в хранилище (cloud или Self-Hosting) \
`infisical init` инициализировать - выбрать организацию и проект \
`infisical secrets` получить список секретов и их SECRET VALUE из добавленных групп Environments (Development, Staging, Production)
```PowerShell
$clientId = "<client_id>" # создать организацию и клиент в Organization Access Control - Identities и предоставить права на Projects (Secret Management)
$clientSecret = "<client_secret>" # на той же вкладке вкладке в Authentication сгенерировать секрет (Create Client Secret)
$body = @{
    clientId     = $clientId
    clientSecret = $clientSecret
}
$response = Invoke-RestMethod -Uri "https://app.infisical.com/api/v1/auth/universal-auth/login" `
    -Method POST `
    -ContentType "application/x-www-form-urlencoded" `
    -Body $body
$TOKEN = $response.accessToken # получить токен доступа
# Получить содержимое секрета
$secretName = "FOO" # название секрета
$workspaceId = "82488c0a-6d3a-4220-9d69-19889f09c8c8" # можно взять из url проекта Secret Management
$environment = "dev" # группа
$headers = @{
    Authorization = "Bearer $TOKEN"
}
$secrets = Invoke-RestMethod -Uri "https://app.infisical.com/api/v3/secrets/raw/${secretName}?workspaceId=${workspaceId}&environment=${environment}" -Method GET -Headers $headers
$secrets.secret.secretKey
$secrets.secret.secretValue
```
### HashiCorp/Vault

`mkdir vault && cd vault && mkdir vault_config`

Создать конфигурацию:
```bash
echo '
# Использовать локальное файловое хранилище
storage "file" {
  path = "/vault/file"
}
# Отключение режим dev (не будет выгружать данные в память)
disable_mlock = false
# Настройка слушателя для REST API
listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1  # Отключить TLS
}
# Включение интерфейс
ui = true
# Включение аутентификации в API по токену
api_addr = "http://localhost:8200"
auth "token" {}
' > vault_config/vault.hcl
```
Запускаем в контейнере:
```bash
docker run -d --name=vault \
  --restart=unless-stopped \
  -e VAULT_ADDR=http://0.0.0.0:8200 \
  -e VAULT_API_ADDR=http://localhost:8200 \
  -p 8200:8200 \
  -v ./vault_config:/vault/config \
  -v ./vault_data:/vault/file \
  --cap-add=IPC_LOCK \
  hashicorp/vault:latest \
  vault server -config=/vault/config/vault.hcl
```
Получить ключи разблокировки и root ключ для первичной инициализации:
```bash
docker exec -it vault vault operator init
```
Ввести любые 3 из 5 ключей для разблокировки после перезапуска контейнера:
```bash
docker exec -it vault vault operator unseal BPJSmuLvKAEr6wtE/8TOMRMM+x0fW3UhOxGFLn9Gmi5N
docker exec -it vault vault operator unseal 44ntLYvSMN5FNLyddLo2IylRsLk7lqYXZOShvhV/2gbG
docker exec -it vault vault operator unseal xP9+YTyW13W6xGz52mMut2MdOnzxtbhDW8dK9zdF4aLY
```
Проверить статус (должно быть `Sealed: false`) и авторизацию по root ключу в хранилище:
```bash
docker exec -it vault vault status
docker exec -it vault vault login hvs.rxlYkJujkX6Fdxq2XAP3cd3a
```
`Secrets Engines` -> `Enable new engine` + `KV` \
API Swagger: http://192.168.3.100:8200/ui/vault/tools/api-explorer
```PowerShell
$TOKEN = "hvs.rxlYkJujkX6Fdxq2XAP3cd3a"
$Headers = @{
    "X-Vault-Token" = $TOKEN
}
# Указать путь до секретов (создается в корне kv)
$path = "main-path"
$url = "http://192.168.3.101:8200/v1/kv/data/$path"
$data = Invoke-RestMethod -Uri $url -Method GET -Headers $Headers
# Получить содержимое ключа по его названию (key_name)
$data.data.data.key_name # secret_value

# Перезаписать все секреты
$Headers = @{
    "X-Vault-Token" = $TOKEN
}
$Body = @{
    data = @{
        key_name_1 = "key_value_1"
        key_name_2 = "key_value_2"
    }
    options = @{}
    version = 0
} | ConvertTo-Json
$urlUpdate = "http://192.168.3.100:8200/v1/kv/data/main-path"
Invoke-RestMethod -Uri $urlUpdate -Method POST -Headers $Headers -Body $Body

# Удалить все секреты
Invoke-RestMethod -Uri "http://192.168.3.100:8200/v1/kv/data/main-path" -Method DELETE -Headers $Headers
```
Vault client:
```bash
# Установить клиент в Linux (debian):
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault
# Включить механизм секретов KV
vault secrets enable -version=1 kv 
# Создать секрет
vault kv put kv/main-path key_name=secret_value
# Список секретов
vault kv list kv/
# Получить содержимое секрета
vault kv get -mount="kv" "main-path"
# Удалить секреты
vault kv delete kv/my-secret
```
### HashiCorp/Consul

[Consul](https://github.com/hashicorp/consul) используется для кластеризации и централизованного хранения данных `Vault`, а также как самостоятельное `Key-Value` хранилище.

Создать конфигурацию:
```bash
echo '
ui = true
log_level = "INFO"
acl {
  enabled = true
  default_policy = "deny"
  enable_token_persistence = true
}
' > consul.hcl
```
Запускаем в контейнере:
```bash
docker run -d \
  --name=consul \
  --restart=unless-stopped \
  -p 8500:8500 \
  -v ./consul_data:/consul/data \
  -v ./consul.hcl:/consul/config/consul.hcl \
  hashicorp/consul:latest \
  agent -server -bootstrap-expect=1 -client=0.0.0.0
```
Создать `root token`, который будет использоваться для управления системой `ACL` и для создания политик доступа и других токенов доступа:
```bash
docker exec -it consul consul acl bootstrap
```
Создать новую политику доступа:
```bash
docker exec -it consul consul acl policy create -name "default" -rules 'node_prefix "" { policy = "write" } service_prefix "" { policy = "write" } key_prefix "" { policy = "write" }' -token "382834da-28b6-c72c-7ffb-11acf9bf20bc"
```
Создать новый токен доступа:
```bash
docker exec -it consul consul acl token create -policy-name "default" -token "382834da-28b6-c72c-7ffb-11acf9bf20bc"
```
`curl http://localhost:8500/v1/health/service/consul?pretty` \
`curl --request PUT --data "ssh-rsa AAAA" http://localhost:8500/v1/kv/ssh/key` записать секрет KV Store Consul \
`curl -s http://localhost:8500/v1/kv/ssh/key | jq -r .[].Value | base64 --decode` извлечь содержимое секрета

## Prometheus

Пример создания экспортера для получения метрик температуры всех дисков из [CrystalDiskInfo](https://crystalmark.info/en/software/crystaldiskinfo) и отправки в [Prometheus](https://github.com/prometheus/prometheus) через [PushGateway](https://github.com/prometheus/pushgateway).

Формат метрик:
```
# HELP название_метрики Описание метрики
# TYPE название_метрики ТИП-ДАННЫХ
название_метрики{лейбл="НАЗВАНИЕ ДИСКА 1", instance="HOSTNAME"} ЗНАЧЕНИЕ
название_метрики{лейбл="НАЗВАНИЕ ДИСКА 2", instance="HOSTNAME"} ЗНАЧЕНИЕ
```
Типы данных:

- `counter` - возрастающее значение (например, количество запросов, ошибок, завершенных задач)
- `gauge` - переменное значение (может увеличиваться или уменьшаться, например, нагрузка CPU, объем свободной памяти, температура)
- `histogram` - разделенные данные на корзины (buckets, с помощью лэйбла `le`) и подсчет наблюдения в них (автоматически создает три метрики: <name>_bucket, <name>_sum, <name>_count)
- `summary` - аналогичен гистограмме, но вычисляет квантили

Строки метрик содержат имя, лейблы (в фигурных скобках) и значение.

1. Запускаем `pushgateway` в контейнере:

`docker run -d --name pushgateway --restart unless-stopped -p 19091:9091 prom/pushgateway`

2. Запускаем скрипт в консоли:
```PowerShell
$instance = [System.Net.Dns]::GetHostName()
$pushgatewayUrl = "http://192.168.3.100:19091/metrics/job/disk_temperature"
# Изменить адрес шлюза на имя контейнера при запуске через compose
# $pushgatewayUrl = "http://pushgateway:9091/metrics/job/disk_temperature"
$path = "C:/Program Files/CrystalDiskInfo/Smart"
# Изменить путь при запуске в контейнере Docker через WSL
# $path = "/mnt/c/Program Files/CrystalDiskInfo/Smart"
# Необходимо строго использовать синтаксис PowerShell (избегая псевдонимы ls)
$diskArray = $(Get-ChildItem $path).Name
while ($true) {
    $metrics = "# TYPE disk_temperature gauge`n"
    foreach ($diskName in $diskArray) {
        $lastTemp = $(@("Date,Value")+$(Get-Content "$path/$diskName/Temperature.csv") | ConvertFrom-Csv)[-1].Value
        $diskLabel = $diskName -replace "[^a-zA-Z0-9]", "_"
        $metrics += "disk_temperature{disk=`"$diskLabel`",instance=`"$instance`"} $lastTemp`n"
    }
    $metrics
    Invoke-RestMethod -Uri $pushgatewayUrl -Method POST -Body $metrics
    Start-Sleep 10
}
```
3. Проверяем наличие метрик на конечной точке шлюза:
```PowerShell
$(Invoke-RestMethod http://192.168.3.100:9091/metrics).Split("`n") | Select-String "disk_temperature"
```
4. Добавляем конфигурацию в `prometheus.yml`:
```yaml
scrape_configs:
  - job_name: cdi-exporter
    scrape_interval: 10s
    scrape_timeout: 2s
    metrics_path: /metrics
    static_configs:
      - targets:
        - '192.168.3.100:19091'
```
`docker-compose kill -s SIGHUP prometheus` применяем изменения

5. Собираем контейнер в среде `WSL` с помощью `dockerfile` монтированием системного диска Windows:
```dockerfile
FROM mcr.microsoft.com/powershell:latest
WORKDIR /cdi-exporter
COPY cdi-exporter.ps1 ./cdi-exporter.ps1
CMD ["pwsh", "-File", "cdi-exporter.ps1"]
```
`docker build -t cdi-exporter .` \
`docker run -d -v /mnt/c:/mnt/c --name cdi-exporter cdi-exporter`

6. Собираем стек из шлюза и скрипта в `docker-compose.yml`:
```yaml
services:
  cdi-exporter:
    build:
      context: .
      dockerfile: dockerfile
    container_name: cdi-exporter
    volumes:
      - /mnt/c:/mnt/c
    restart: unless-stopped

  pushgateway:
    image: prom/pushgateway
    container_name: pushgateway
    ports:
      - "19091:9091"
    restart: unless-stopped
```
`docker-compose up -d`

7. Настраиваем `Dashboard` в `Grafana`:

Переменные для фильтрации запроса: \
hostName: `label_values(exported_instance)` \
diskName: `label_values(disk)` \
Метрика температуры: `disk_temperature{exported_instance="$hostName", disk=~"$diskName"}`

### PromQL Functions

| Функция                       | Тип данных        | Описание                                                              | Пример                                                            |
| -                             | -                 | -                                                                     | -                                                                 |
| `rate()`                      | `counter`         | Средняя скорость роста метрики за интервал (increase / seconds)       | `rate(http_requests_total[$__rate_interval])`                     |
| `irate()`                     | `counter`         | Мгновенная скорость роста (использует последние 2 точки)              | `irate(http_requests_total[1m])`                                  |
| `increase()`                  | `counter`         | Абсолютный прирост метрики за интервал (end time - start time)        | `increase(http_requests_total[5m])`                               |
| `resets()`                    | `counter`         | Количество сбросов counter-метрики за интервал.                       | `resets(process_cpu_seconds_total[1h])`                           |
| `delta()`                     | `gauge`           | Разница между первым и последним значением метрики за интервал        | `delta(node_memory_free[[5m]])`                                   |
| `idelta()`                    | `gauge`           | Разница между последними двумя точками                                | `delta(node_memory_free[1m])`                                     |
| `avg_over_time()`             | `gauge`           | Среднее значение за интервал	                                        | `avg_over_time(temperature[5m])`                                  |
| `max_over_time()`             | `gauge`           | Максимальное значение за интервал                                     | `max_over_time(temperature[5m])`                                  |
| `predict_linear()`            | `gauge`           | Предсказывает значение метрики через N секунд (для прогнозирования)   | `predict_linear(disk_free[1h], 3600)`                             |
| `count()`                     | `counter`/`gauge` | Количество элементов метрики                                          | `count(http_requests_total) by (status_code)`                     |
| `sum()`                       | `counter`/`gauge` | Суммирует значения метрик по указанным labels                         | `sum(rate(cpu_usage[5m])) by (pod)`                               |
| `avg()`                       | `counter`/`gauge` | Среднее значение метрики по указанным labels                          | `avg(node_memory_usage_bytes) by (instance)`                      |
| `min() / max()`               | `counter`/`gauge` | Возвращает минимальное/максимальное значение                          | `max(container_cpu_usage) by (namespace)`                         |
| `round()`                     | `counter`/`gauge` | Округляет значения до указанного числа дробных знаков                 | `round(container_memory_usage / 1e9, 2)`                          |
| `floor() / ceil()`            | `counter`/`gauge` | Округляет вниз/вверх до целого числа                                  | `floor(disk_usage_percent)`                                       |
| `absent()`                    | `counter`/`gauge` | Возвращает 1, если метрика отсутствует (для алертинга)                | `absent(up{job="node-exporter"})`                                 |
| `clamp_min() / clamp_max()`   | `counter`/`gauge` | Ограничивает значения минимумом/максимумом (уменьшает если больше)    | `clamp_max(disk_usage_percent, 100)`                              |
| `label_replace()`             | `counter`/`gauge` | Изменяет или добавляет labels в метрике                               | `label_replace(metric, "new_label", "$1", "old_label", "(.*)")`   |
| `sort() / sort_desc()`        | `counter`/`gauge` | Сортирует метрики по возрастанию/убыванию                             | `sort(node_filesystem_free_bytes)`                                |

# Graylog

[Graylog Docker Image](https://hub.docker.com/r/itzg/graylog)

- Устанавливаем MongoDB:
```bash
docker run --name mongo -d mongo:3
```
- Используем прокси для установки Elassticsearch:
```bash
docker run --name elasticsearch \
    -e "http.host=0.0.0.0" -e "xpack.security.enabled=false" \
    -d dockerhub.timeweb.cloud/library/elasticsearch:5.5.1
```
- Указываем статический IP адрес для подключения к API
```bash
docker run --name Graylog \
    --link mongo \
    --link elasticsearch \
    -p 9000:9000 -p 12201:12201 -p 514:514 -p 5044:5044 \
    -e GRAYLOG_WEB_ENDPOINT_URI="http://192.168.3.101:9000/api" \
    -d graylog/graylog:2.3.2-1
```
- Настройка Syslog на клиенте Linux:

`nano /etc/rsyslog.d/graylog.conf`
```bash
*.* @@192.168.3.101:514;RSYSLOG_SyslogProtocol23Format
```
`systemctl restart rsyslog`

- Создать входящий поток (`inputs`) для Syslog на порту 514 по протоколу TCP:

http://192.168.3.101:9000/system/inputs

- Пример фильтра для логов:

`facility:"system daemon" AND application_name:bash AND message:\[ AND message:\]`

- Настройка Winlogbeat на клиенте Windows

Установка агента:
```PowerShell
irm https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-8.15.0-windows-x86_64.zip -OutFile $home\Documents\winlogbeat-8.15.0.zip
Expand-Archive $home\Documents\winlogbeat-8.15.0.zip
cd $home\Documents\winlogbeat-8.15.0-windows-x86_64
```
Добавить отправку в Logstash:

`code winlogbeat.yml`
```bash
output.logstash:
  hosts: ["192.168.3.101:5044"]
```
И закомментировать отправку данных в Elasticsearch (output.elasticsearch)

`.\winlogbeat.exe -c winlogbeat.yml` запустить агент с правами администратора в консоли
```bash
.\install-service-winlogbeat.ps1 # установить службу
Get-Service winlogbeat | Start-Service
```
- Настроить Inputs для приема Beats на порту 5044