<p align="center">
    <a href="https://lifailon.github.io/devops/"><img title="DevOps Tools"src="Images/devops-tools.png"></a>
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
  - [Namespaces/Cgroups](#namespacescgroups)
  - [Namespace Enter](#namespace-enter)
  - [OCI](#oci)
  - [Dockerfile](#dockerfile)
  - [Scratch](#scratch)
  - [Buildx](#buildx)
  - [Docker Registry](#docker-registry)
    - [Docker Hub](#docker-hub)
    - [Push/Pull](#pushpull)
    - [Nexus](#nexus)
    - [Mirrors](#mirrors)
    - [Proxy](#proxy)
  - [Docker API](#docker-api)
    - [UNIX Socket](#unix-socket)
    - [TCP Socket](#tcp-socket)
    - [Metrics](#metrics)
    - [Docker.DotNet](#dockerdotnet)
  - [Docker cli](#docker-cli)
    - [update](#update)
    - [volume](#volume)
    - [network](#network)
    - [inspect](#inspect)
    - [system](#system)
    - [diff](#diff)
    - [copy](#copy)
    - [context](#context)
    - [alias](#alias)
- [Docker Compose](#docker-compose)
  - [Dozzle](#dozzle)
  - [Socket Proxy](#socket-proxy)
  - [Logging](#logging)
    - [journald](#journald)
    - [syslog](#syslog)
    - [gelf](#gelf)
    - [fluentd](#fluentd)
    - [rsyslog](#rsyslog)
  - [Volumes](#volumes)
    - [tmpfs](#tmpfs)
    - [nfs](#nfs)
    - [smb](#smb)
  - [Network](#network-1)
    - [bridge/external](#bridgeexternal)
    - [host](#host)
    - [macvlan](#macvlan)
    - [ipvlan](#ipvlan)
- [Swarm](#swarm)
- [Kubernetes](#kubernetes)
  - [Kompose](#kompose)
  - [Kubeadm](#kubeadm)
  - [Metrics Server](#metrics-server)
  - [Flannel](#flannel)
  - [Local Path Provisioner](#local-path-provisioner)
  - [Headlamp](#headlamp)
  - [Kubectl Config](#kubectl-config)
  - [K9s](#k9s)
  - [Krew](#krew)
  - [Kubelet Configuration](#kubelet-configuration)
  - [Node](#node)
  - [Labels](#labels)
  - [Namespaces](#namespaces)
  - [Resource Quotas](#resource-quotas)
  - [Limit Range](#limit-range)
  - [Deployment](#deployment)
  - [Pods](#pods)
  - [ReplicaSet Rollout](#replicaset-rollout)
  - [Service](#service)
  - [DNS](#dns)
  - [Proxy](#proxy-1)
  - [Probes](#probes)
  - [Container Hooks](#container-hooks)
  - [Strategy Update](#strategy-update)
  - [Tolerations](#tolerations)
  - [Affinity](#affinity)
    - [Node Affinity](#node-affinity)
    - [Pod Anti Affinity](#pod-anti-affinity)
  - [Pod Topology Spread](#pod-topology-spread)
  - [Pod Disruption Budget](#pod-disruption-budget)
  - [Pod Priority Class](#pod-priority-class)
  - [StatefulSet](#statefulset)
  - [Headless Service](#headless-service)
  - [DaemonSet](#daemonset)
  - [Job](#job)
  - [Cron Job](#cron-job)
  - [Init Containers](#init-containers)
  - [Image Pull Secrets](#image-pull-secrets)
  - [ConfigMap](#configmap)
  - [Secrets](#secrets)
  - [RBAC](#rbac)
  - [Events](#events)
  - [Event Exporter](#event-exporter)
  - [Shell Operator](#shell-operator)
  - [Persistent Volume](#persistent-volume)
  - [Persistent Volume Claim](#persistent-volume-claim)
  - [Storage Class](#storage-class)
  - [HPA](#hpa)
  - [VPA](#vpa)
  - [JSONPath](#jsonpath)
- [CRD](#crd)
  - [Traefik](#traefik)
    - [Ingress Controller](#ingress-controller)
    - [Ingress Route](#ingress-route)
    - [Middleware](#middleware)
  - [Istio](#istio)
    - [Istioctl](#istioctl)
    - [Kiali](#kiali)
    - [Gateway](#gateway)
    - [Virtual Service](#virtual-service)
    - [Service Entry](#service-entry)
    - [Destination Rule](#destination-rule)
    - [Envoy Filter](#envoy-filter)
  - [MetalLB](#metallb)
  - [Longhorn](#longhorn)
  - [ArgoCD](#argocd)
  - [MinIO](#minio)
  - [S3fs](#s3fs)
  - [Velero](#velero)
  - [Velero UI](#velero-ui)
- [Kustomize](#kustomize)
  - [Resources](#resources)
  - [Overlays Patch](#overlays-patch)
  - [ConfigMap Generator](#configmap-generator)
  - [Helm Charts](#helm-charts)
- [Helm](#helm)
  - [Charts](#charts)
  - [Переменные](#переменные)
  - [Файлы](#файлы)
  - [Функции](#функции)
  - [Условия](#условия)
  - [Циклы](#циклы)
  - [Define](#define)
  - [Helper](#helper)
- [Helmfile](#helmfile)
- [GitHub API](#github-api)
- [GitHub Actions](#github-actions)
  - [Docker Build and Push](#docker-build-and-push)
  - [Dockerfile Linters Check](#dockerfile-linters-check)
  - [Telegram Notification](#telegram-notification)
  - [AI Issue Analysis](#ai-issue-analysis)
  - [AI README Translate](#ai-readme-translate)
  - [Go Build and Testing](#go-build-and-testing)
  - [Ubuntu PPA Repository](#ubuntu-ppa-repository)
  - [Ubuntu Build and Push](#ubuntu-build-and-push)
  - [Composite Action](#composite-action)
  - [Repository Dispatch](#repository-dispatch)
  - [Actions API](#actions-api)
  - [Actions locally](#actions-locally)
- [Groovy](#groovy)
- [Gradle](#gradle)
- [Jenkins](#jenkins)
  - [API](#api)
  - [Plugins](#plugins)
  - [Credentials](#credentials)
  - [configFile](#configfile)
  - [SSH Agent](#ssh-agent)
  - [SSH Steps and Artifacts](#ssh-steps-and-artifacts)
  - [Upload File Parameter](#upload-file-parameter)
  - [Input Text and File](#input-text-and-file)
  - [HttpURLConnection](#httpurlconnection)
  - [httpRequest](#httprequest)
  - [Active Choices Parameter](#active-choices-parameter)
  - [Vault](#vault)
  - [withVault](#withvault)
  - [Email Extension](#email-extension)
  - [Parallel](#parallel)
  - [SimpleTemplateEngine](#simpletemplateengine)
  - [YamlSlurper](#yamlslurper)
- [IaC](#iac)
  - [Ansible](#ansible)
    - [Windows Modules](#windows-modules)
    - [Jinja](#jinja)
  - [Puppet/Bolt](#puppetbolt)
  - [Sake](#sake)
- [Secret Manager](#secret-manager)
  - [Bitwarden](#bitwarden)
  - [Infisical](#infisical)
  - [HashiCorp Vault](#hashicorp-vault)
  - [HashiCorp Consul](#hashicorp-consul)
- [Prometheus](#prometheus)
- [PromQL](#promql)
- [Cloud](#cloud)
  - [AWS/LocalStack](#awslocalstack)
    - [S3](#s3)
    - [Fluent Bit](#fluent-bit)
    - [CloudWatch](#cloudwatch)
  - [Azure](#azure)
  - [Vercel](#vercel)
- [Proxy](#proxy-2)
  - [Traefik](#traefik-1)
  - [HAProxy](#haproxy)
  - [Keepalive](#keepalive)
- [GlusterFS](#glusterfs)

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

[Docker](https://github.com/docker) - это платформа для контейнеризации, которая упаковывает приложение и все его зависимости (библиотеки, настройки) в изолированный контейнер. Контейнеры делят ядро ОС хоста, тогда как ВМ используют гипервизор для эмуляции оборудования и запускают полноценную гостевую ОС. Контейнеры изолированы на уровне процессов, быстро разворачиваются и позволяют экономить ресурсы по сравнению с ВМ.

```bash
apt update && apt upgrade -y && apt install -y docker.io
systemctl status docker
docker -v

# Добавить пльзователя в группу docker
sudo usermod -aG docker lifailon
newgrp docker
```

Компоненты Docker:

- `Docker Daemon` (`docker.service`/`dockerd`) - процесс, который работает в фоне и управляет образами, сетями и томами через `socket`. Если сервис остановлен, управление контейнерами невозможно. Сам `dockerd` не запускает контейнеры напрямую, а делегирует процесс `containerd`. 
- `containerd` - процесс, который отвечает за запуск контейнеров - скачивает образы из реестра, управляет хранилищем (все данные хранятся в `/var/lib/docker/`) и следит за состоянием работающих контейнеров, это позволяет перезагружать или обновлять `Docker Daemon`, не останавливая при этом запущенные контейнеры. Если `dockerd` упадет из-за ошибки или нехватки памяти, контейнеры не выключатся за счет работы дочерних процессов `shim-runc`.
- `runc`  - это процесс, который подготавливает изоляцию. 
- `docker-cli` - утилита командной строки, через которую передаются команды управления через REST API локально на Unix-сокет (`/var/run/docker.sock`) или удаленно по TCP.

Для запуска нового контейнера, сначала запускается промежуточный процесс `containerd-shim-runc-v2`, он живет все время, пока работает контейнер и является родителем для процесса внутри контейнера (он забирает код возврата, если приложение упадет и держит каналы `stdin`/`stdout` открытыми для доступа к логам). Процесс `containerd-shim` создает дочерний процесс `runc` (создает новый процесс с помощью `fork()` и `exec()`), который напрямую взаимодействует с ядром Linux через системные вызовы (разрывает связь с родительскими пространствами имен с помощью `unshare()`, записывает ограничения в файл `/sys/fs/cgroup/`, меняет корневую файловую систему на путь из `/var/lib/docker/overlay2/<IMAGE_ID>/merged` с помощью `pivot_root()` и `umount` для старого кореня хоста). После настройки изоляции, `runc` заменяет себя процессом приложения в контейнере (командой `ENTRYPOINT` или `CMD` в `Dockerfile`).

`ps axf | grep -A 3 containerd-shim` - отобразить дерево процессов контейнеров

### Namespaces/Cgroups

Технологии ядра Linux для настройки изоляции:

- `Namespaces` (пространства имен) - изоляции видимости системных ресурсов.
- `Cgroups` (Control Groups) - ограничения потребления ресурсов процессом (лимиты на CPU, RAM, скорость диска). Без них один контейнер мог бы потреблять всю память хоста.

Пространства имен:

- `PID Namespace` - изолирует дерево процессов. Процесс в контейнере может иметь `PID 1`, не конфликтуя с `PID 1` (`init`) основной системы.
- `Network Namespace` - создает собственные сетевые интерфейсы (IP-адреса и таблицы маршрутизации).
- `Mount Namespace` - изолирует точки монтирования файловой системы.
- `UTS Namespace` - позволяет задавать отдельное имя хоста (`hostname`) и домен.
- `IPC Namespace` - ограничивает межпроцессное взаимодействие (shared memory, очереди сообщений).
- `User Namespace` - сопоставляет идентификаторы пользователей (`UID`/`GID`) внутри контейнера с другими ID на хосте (например, `root` в контейнере может быть обычным пользователем на хосте).

`unshare` (разъединитель) - запускает процесс в новых изолированных пространствах имен (namespaces), отделяя его от родительских ресурсов.

`netns` (`Network Namespace`) - создает и настраивает сетевое пространство имен, которое позволяет иметь в одной операционной системе несколько полностью независимых сетевых стеков. В отличии от `unshare --net` дает возможность настроить сеть до ее изоляции (связать с хостом через `veth`).

Скрипт для создания изолированной и ограниченной по ресурсам операционной системы Alpine Linux:

```bash
# Идентификатор изоляции
UUID=$(cat /proc/sys/kernel/random/uuid | tr -dc 'a-f0-9' | fold -w 12 | head -n 1)

# Подготавливаем хранилище btrfs
VOLUMES="/tmp/volumes"
mkdir -p $VOLUMES
IMG="/tmp/volumes/$UUID.img"
truncate -s 512M $IMG
mkfs.btrfs $IMG
VOLUME="/tmp/volumes/$UUID"
mkdir -p $VOLUME
sudo mount -o loop $IMG $VOLUME
sudo chown $USER:$USER $VOLUME

# Загружаем базовый образ Alpine в btrfs volume
ALPINE="$VOLUME/base_image_alpine"
btrfs subvolume create $ALPINE
curl -L https://dl-cdn.alpinelinux.org/alpine/v3.23/releases/$(uname -m)/alpine-minirootfs-3.23.3-$(uname -m).tar.gz | tar -xz -C $ALPINE
ls $ALPINE

# Подготавливаем файловую систему
ROOTFS="$VOLUME/container_rootfs"
btrfs subvolume snapshot "$ALPINE" "$ROOTFS"

# Настраиваем DNS
echo 'nameserver 8.8.8.8' > "$ROOTFS"/etc/resolv.conf

# Функция для очистки
cleanup() {
    # Возвращаем текущий процесс в общую группу
    echo $$ | sudo tee /sys/fs/cgroup/cgroup.procs > /dev/null
    # Удаляем cgroup (после выхода из нее)
    sudo rmdir /sys/fs/cgroup/memory/$UUID
    # Удаляем сетевое пространство из /run/netns/ns$UUID
    sudo ip netns delete "ns$UUID"
    # Размонтируем ресурсы
    sudo umount "$VOLUME"
}

# Перехватывает выход из скрипта (EXIT) или прерывание (Ctrl+C)
trap cleanup EXIT

# Создаем виртуальный интерфейс на хосте в режиме моста (L2 коммутатор) для всех контейнеров
sudo ip link add br0 type bridge
sudo ip addr add 172.172.0.1/24 dev br0
sudo ip link set br0 up
# Настраиваем NAT для маршрутизации пакетов в Интернет чере хост
sudo sysctl -w net.ipv4.ip_forward=1 > /dev/null
sudo iptables -t nat -A POSTROUTING -s 172.172.0.0/24 ! -o br0 -j MASQUERADE
# Создаем интерфейс в режиме veth (виртуальный сетевой кабель для двусторонней связи)
sudo ip link add vh$UUID type veth peer name vc$UUID
# Подключаем один конец к бриджу (позволяет общаться между контейнерами в подсети и выходить в Интернет через хост)
sudo ip link set vh$UUID master br0
sudo ip link set vh$UUID up
# Создаем сетевое пространство (Network Namespace)
sudo ip netns add ns$UUID
# Подключаем второй конец к изолированному стеку (для связи с хостом в режиме Point-to-Point и bridge)
sudo ip link set vc$UUID netns ns$UUID
# Настройка сети внутри внутри изолированного стека
# Поднимаем интерфейс loopback, чтобы программы могли обращаться к localhost
sudo ip netns exec ns$UUID ip link set lo up
# Назначаем адрес и поднимает интерфейс
sudo ip netns exec ns$UUID ip addr add 172.172.0.2/24 dev vc$UUID
sudo ip netns exec ns$UUID ip link set vc$UUID up
# Настраиваем маршрут по умолчанию (любой пакет не предназначенный для подсети 172.172.0.0/24 отправится на хост)
sudo ip netns exec ns$UUID ip route add default via 172.172.0.1

# sudo apt install cgroup-tools
# sudo cgcreate -g memory:/$UUID
# sudo cgset -r memory.limit_in_bytes=$((512 * 1024 * 1024)) $UUID
# Включаем лимиты перед netns
# sudo cgexec -g memory:$UUID

# Включаем управление памятью с помощью групп
echo "+memory" | sudo tee /sys/fs/cgroup/memory/cgroup.subtree_control
# Создаем новую контрольную группу
sudo mkdir -p /sys/fs/cgroup/memory/$UUID
# Устанавливаем лимит на память в 512 МБайт
echo $((512 * 1024 * 1024)) | sudo tee /sys/fs/cgroup/memory/$UUID/memory.max
# Записываем PID текущей оболочки в cgroup
echo $$ | sudo tee /sys/fs/cgroup/memory/$UUID/cgroup.procs

# 1. Заходим в настроенную изолированную сеть (или nsenter --net=/var/run/netns/ns$UUID)
# 2. Создаем изоляцию для процессов, файловой системы, UTS и IPC
# 3. Мменяет корневой каталог с помощью chroot
# 4. Очищаем и заново определяем переменные окружения
# 5. Монтируем новую файловую систему процессов и заменяем текущий процесс на новый
sudo ip netns exec ns$UUID \
  unshare --pid --fork --mount --uts --ipc \
    chroot $ROOTFS \
      /usr/bin/env -i HOME=/root TERM="xterm-256color" PATH=/bin:/usr/bin:/sbin:/usr/sbin \
        /bin/sh -c "
          mount -t proc proc /proc;
          exec /bin/sh
        "
```

### Namespace Enter

`nsenter` (`Namespace Enter`) - это инструмент командной строки, который позволяет запускать процессы в контексте пространств имен других процессов.

```bash
# Целевой контейнер
containerName=dozzle

# Получить PID 1 контейнера внутри хостовой системе
PID=$(pgrep $containerName)
# PID=$(docker inspect -f {{.State.Pid}} $containerName)
# PID=$(docker top $containerName -o pid | sed 1d)

# Отобразить содержимое файловой системы контейнера
sudo ls -la /proc/$PID/root/
sudo cat /proc/$PID/root/data/users.yml
# Отобразить переменные окружения
sudo cat /proc/$PID/environ | tr '\0' '\n'
# Файловые дескрипторы, занятые процессом (обычно 1w и 2w используются через FIFO/pipe)
sudo lsof -p $PID
# Доступ к стандартным дескрипторам вывода процесса (stdout и stderr)
sudo tail -n +1 -f /proc/$PID/fd/1 /proc/$PID/fd/2
# Системные вызовы для всех дочерних процессов с фильтрацией на запись
sudo strace -f -p $PID -e write -s 1024 2>&1 | grep "write(1,\|write(2,"

# Получить прямой доступ к файловой системе контейнера
# При использование образа scratch не будут доступны системные команды из каталога /bin
sudo nsenter -t $($PID) -m

# Подключиться к пространству имен процесса контейнера (доступ к сетевому стеку и процессам)
sudo nsenter -t $PID -n -p
ss -tunlp
ip a
tcpdump -i eth0
# Примонтировать виртуальную файловую систему процессов (procfs) контейнера
mount -t proc proc /proc
ps aux

# Альтернатива nsenter -t $PID -n -p
docker run --rm -it \
  --privileged \
  --net=container:$containerName \
  --pid=container:$containerName \
  -v /proc:/host/proc:ro \
  alpine sh
```

### OCI

`OCI` (Open Container Initiative) - это стандарт для упаковки, сбоки, загрузки в реестр и запуска контейнеров (например, через `docker`, `podman` или `containerd`).

Образы контейнеров состоят из слоев. Каждая из команд `FROM`, `RUN`, `COPY` и `ADD` в `Dockerfile` создает новый неизменяемый слой (`Read-Only`). Если в одном слое скачать архив, а в следующем его удалить, этот размер все равно останется в памяти нижнего слоя и будут занимать место в финальном образе. При запуске контейнера (экземпляра образа), Docker добавляет сверху один записываемый слой, который стирается после удаления контейнера. Если используется 10 образов на базе `alpine`, базовый образ хранится на диске в одном экземпляре.

Назначение слоев:

- Кэширование - при повторной сборке образа, Docker не выполняет заново те команды, которые не менялись, а просто берет готовые слои из кэша. Это делает сборку очень быстрой.
- Экономия места - если используется 10 образов на базе `alpine`, базовый образ хранится на диске в одном экземпляре, и все они используют одни и те же неизменяемые слои, храня отдельно только свои уникальные изменения в верхнем слое.
- Переиспользование - разные образы могут делить между собой общие слои, что ускоряет их скачивание и экономит дисковое пространство.
- Скорость - при загрузки образа из registry по сети, каждый слой загружается параллельно как отдельные архив в формате `.tar.gz`.

Сохранить внесенные изменения в новый временный слой запущенного контейнера и сохранить в новый образ:

```bash
# docker commit <container_name> <image_name>:<new_tag>
docker commit docker-socket-proxy lifailon/docker-socket-proxy:v2
```

Вывести историю слоев (используемая команда и размер слоя):

```bash
docker history lifailon/docker-socket-proxy:arm64
```

Команды `FROM` отображается как загрузка архива, например `ADD alpine-minirootfs-3.23.3-aarch64.tar.gz`.

Список директорий со слоями образа в системе:

```bash
docker inspect lifailon/docker-socket-proxy:arm64 --format='{{.GraphDriver.Data.LowerDir}}' | sed "s/:/\n/g"
```

[Dive](https://github.com/wagoodman/dive) - интерактивный терминальный инструмент для анализа содержимого слоев с целью поиска способов уменьшения размера финального образа Docker.

```bash
LATEST_VERSION=$(curl -s https://api.github.com/repos/wagoodman/dive/releases/latest | jq -r .tag_name)
curl -SLf "https://github.com/wagoodman/dive/releases/download/${LATEST_VERSION}/dive_${LATEST_VERSION#v}_linux_$(dpkg --print-architecture).tar.gz" -o /tmp/dive.tar.gz
mkdir -p $HOME/.local/bin
tar -xzf /tmp/dive.tar.gz -C $HOME/.local/bin dive
rm -rf /tmp/dive.tar.gz

dive lifailon/docker-socket-proxy:arm64
```

Изменение файла и переупаковка образа:

```bash
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
```

### Dockerfile

- `FROM` - базовый образ, на основе которого будет создаваться новый (текущий) образ (например, `FROM alpine:latest` или `FROM node:alpine AS build` для указания метки при использование нескольких образов).
- `LABEL` - добавляет метаданные к образу в формате ключ-значение (например, `LABEL traefik.enable=true` или `LABEL stand=test`, может использоваться другими сервисами для своей работы или фильтрации, например, `docker ps --filter "stand=test"`).
- `ARG` - определяет переменные, которые будут доступны только на этапе сборки образа и недоступны в контейнере (например, объявление с помощью `ARG TARGETARCH` и изменение `docker build --build-arg TARGETARCH=arm64`).
- `ENV` - устанавливает переменные окружения, которые будут доступны внутри контейнера со значениями по умолчанию (например, `ENV PORT=80`, можно переопределить через `-e PORT=8080`, который имеет повышенный приоритет).
- `WORKDIR` - устанавливает рабочий каталог внутри контейнера для последующих команд (например, `WORKDIR /app`).
- `SHELL` - задает командную оболочку, которая будет использоваться для выполнения команд `RUN`, `CMD` и `ENTRYPOINT` (например, `SHELL ["/bin/bash", "-c"]`, по умолчанию `SHELL ["/bin/sh", "-c"]`).
- `RUN` - выполняет команды в контейнере во время сборки образа (например, `RUN apk add --progress --no-cache util-linux bash curl` или `RUN useradd -m node`).
- `USER` - устанавливает пользователя, от имени которого будут выполняться следующие команды (например, `USER node`, по умолчанию `USER root`).
- `COPY` - копирует файлы (например, `COPY . .` для копирования всего содержимого из текущей директории в контейнер или `COPY --from=build` для указания  метки при копирование файлов из другого образа).
- `ADD` - загружает файлы из `URL` (например, `ADD alpine-minirootfs-3.23.3-aarch64.tar.gz /img/`) с распаковкой архивов в формате `tar.gz` (актуально для базовых образов).
- `CMD` - определяет параметры команды, которые будут выполняться при запуске контейнера (может быть переопределена при запуске контейнера).
- `ENTRYPOINT` - определяет основную команду, которая будет выполняться при запуске контейнера (можно переопределить с помощью флага `--entrypoint`).
- `VOLUME` - создает точку монтирования для хранения данных в хостовой системе, вместо слоев контейнера (например, `VOLUME /var/log/app`).
- `EXPOSE` - документирует порты без их проброса (например, `EXPOSE 8080`).
- `HEALTHCHECK` - определяет команду для проверки состояния работающего контейнера (например, `HEALTHCHECK CMD curl -f http://localhost:8080 || exit 1`).
- `STOPSIGNAL` - определяет сигнал, который будет отправлен контейнеру для его остановки (например, `STOPSIGNAL SIGQUIT`).
- `ONBUILD` - задает команды, которые будут автоматически выполнены при сборке дочерних образов.

Пример сборки контейнера для выполнения команды ping:

```Dockerfile
FROM alpine:latest

ENTRYPOINT ["ping"]

CMD ["localhost"]
```

`docker build -t ping-image .`

При запуске команды: `docker run ping-image`, запустится контейнер, который запустит команду: `ping localhost`.

При запуске команды: `docker run ping-image google.com`, аргумент `google.com` целиком переопределяет команду в `CMD` и контейнер запустит команду: `ping google.com`.

Можно изменить основную команду: `docker run -v /var/log/syslog:/syslog --entrypoint tail ping-image -f /syslog`

Пример загрузки и распаковки архива:

```Dockerfile
FROM alpine:latest

RUN apk add --progress --no-cache curl unzip && \
    curl -sSL https://github.com/Lifailon/lazyjournal/archive/refs/heads/main.zip -o /tmp/main.zip && \
    unzip /tmp/main.zip -d /app/ && \
    rm /tmp/main.zip && \
    apk del curl unzip

WORKDIR /app/lazyjournal-main
RUN ls -lh
```

### Scratch

`Scratch` - это пустой образ, который не содержит операционной системы, системных библиотек (как `glibc` в `Ubuntu` или `musl` в `Alpine`) оболочек (`sh` или `bash`) и файлов, что исключает возможные уязвимости в безопасности и требует использовать для запуска статические бинарные файлы (например, написанные на `Go`, `Rust`, `C++`).

Сборка `Go` приложения c нуля с помощью `scratch`:

```Dockerfile
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -o app-0.0.1 main.go

FROM scratch
# Копируем файл из другого образа
# COPY --from=busybox:musl /bin/busybox /busybox
# Копируем приложение из промежуточного слоя
COPY --from=builder /app/app-0.0.1 /app
# Копируем корневые сертификаты для доступа по HTTPS из приложения
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/app"]
```

Загружаем [busybox](https://github.com/mirror/busybox) и копируем в `scratch` контейнер:

```bash
docker create --name busybox busybox:musl
docker cp busybox:/bin/busybox ./busybox
docker cp ./busybox dozzle:/busybox
docker rm busybox && rm ./busybox
docker exec -it dozzle /busybox sh -c '/busybox mkdir -p /bin && /busybox --install -s /bin && export PATH=$PATH:/bin && sh'
```

### Buildx

`sudo apt install docker-buildx -y` установить систему для мультиплатформенной сборки \
`docker buildx create --use --name multiarch-builder --driver docker-container` создать и запустить сборщик в контейнере \
`docker buildx ls` \
`docker buildx rm multiarch-builder`

`go list -u -m all && go get -u ./...` обновить пакеты приложения на Go

Добавить аргументы в `Dockerfile` и передать их в переменные для сборки:

```Dockerfile
ARG TARGETOS TARGETARCH
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build
```

`docker buildx build --platform linux/amd64,linux/arm64 .` собрать

`docker buildx build --platform linux/amd64,linux/arm64 -t lifailon/logporter --push .` собрать и опубликовать

`npm outdated && npm update --save` обновить пакеты `node.jd` приложения

Передаем аргументы в параметры платформы для образа:

```Dockerfile
ARG TARGETOS TARGETARCH
FROM --platform=${TARGETOS}/${TARGETARCH} node:alpine AS build
```

### Docker Registry

#### Docker Hub

`curl https://registry-1.docker.io/v2/` проверить доступ к Docker Hub \
`curl -s -X POST -H "Content-Type: application/json" -d '{"username": "lifailon", "password": "password"}' https://hub.docker.com/v2/users/login | jq -r .token > dockerToken.txt` получить временный токен доступа для авторизации \
`docker login` вход в реестр репозитория `hub.docker.com` \
`cat dockerToken.txt | sudo docker login --username lifailon --password-stdin` передать токен авторизации (https://hub.docker.com/settings/security) из файла через stdin \
`cat /root/.docker/config.json | jq -r .auths[].auth` место хранения токена авторизации в системе

#### Push/Pull

`git clone https://github.com/Lifailon/TorAPI` \
`cd TorAPI` \
`docker build -t lifailon/torapi:latest .` собрать образ для публикации на Docker Hub \
`docker push lifailon/torapi:latest` загрузить образ на Docker Hub

`docker pull lifailon/torapi:latest` загрузить образ из Docker Hub \
`docker run -d --name TorAPI -p 8443:8443 lifailon/torapi:latest` загрузить образ и создать контейнер

#### Nexus

Настройка HTTP-соединения с Nexus сервером (если не использует HTTPS):

```bash
echo -e '{\n  "insecure-registries": ["http://192.168.3.105:8882"]\n}' | sudo tee "/etc/docker/daemon.json"
sudo systemctl restart docker
```

`docker login 192.168.3.105:8882` авторизируемся в репозитории Docker Registry на сервере Nexus \
`docker tag lifailon/docker-web-manager:latest 192.168.3.105:8882/docker-web-manager:latest` создаем тег с прявязкой сервера \
`docker push 192.168.3.105:8882/docker-web-manager:latest` загружаем образ на сервер Nexus

`curl -sX GET http://192.168.3.105:8882/v2/docker-web-manager/tags/list | jq` отобразить список доступных тегов \
`docker pull 192.168.3.105:8882/docker-web-manager:latest` загрузить образ из Nexus

#### Mirrors

Зеркала необходимы, если прямой доступ к основному хранилищу Docker Hub ограничен или невозможен. Docker будет перебирать их по очереди при загрузке образа, пока не найдет доступный.

```bash
cat <<EOF > /etc/docker/daemon.json
{
  "registry-mirrors": [
    "https://dockerhub.timeweb.cloud",
    "https://huecker.io",
    "https://mirror.gcr.io",
    "https://daocloud.io"
  ]
}
EOF

systemctl restart docker
docker info | grep Mirror
```

#### Proxy

```bash
mkdir -p /etc/systemd/system/docker.service.d
```

Создаем дополнительную конфигурацию для службы Docker в файле `/etc/systemd/system/docker.service.d/http-proxy.conf`:

```ini
[Service]
Environment="HTTP_PROXY=http://docker:password@192.168.3.100:9090"
Environment="HTTPS_PROXY=http://docker:password@192.168.3.100:9090"
```

`systemctl daemon-reload` \
`systemctl restart docker`

### Docker API

#### UNIX Socket

`curl --silent -XGET --unix-socket /run/docker.sock http://localhost/version | jq .` использовать локальный сокет (/run/docker.sock) для взаимодействия с Docker daemon через его API \
`curl --silent -XGET --unix-socket /run/docker.sock http://localhost/info | jq .` количество образов, запущенных и остановленных контейнеров и остальные метрики ОС \
`curl --silent -XGET --unix-socket /run/docker.sock http://localhost/events` логи Docker daemon \
`curl --silent -XGET --unix-socket /run/docker.sock -H "Content-Type: application/json" http://localhost/containers/json | jq .` список работающих контейнеров и их параметры конфигурации \
`curl --silent -XGET --unix-socket /run/docker.sock http://localhost/containers/uptime-kuma/json | jq .` подробные сведения (конфигурация) контейнера \
`curl --silent -XPOST --unix-socket /run/docker.sock -d "{"Image":"nginx:latest"}" http://localhost/containers/create?name=nginx` создать контейнер с указанным образом в теле запроса (должен уже присутствовать образ) \
`curl --silent -XPOST --unix-socket /run/docker.sock http://localhost/containers/17fab06a820debf452fe685d1522a9dd1611daa3a5087ff006c2dabbe25e52a1/start` запустить контейнер по Id \
`curl --silent -XPOST --unix-socket /run/docker.sock http://localhost/containers/17fab06a820debf452fe685d1522a9dd1611daa3a5087ff006c2dabbe25e52a1/stop` остановить контейнер \
`curl --silent -XDELETE --unix-socket /run/docker.sock http://localhost/containers/17fab06a820debf452fe685d1522a9dd1611daa3a5087ff006c2dabbe25e52a1` удалить контейнер

#### TCP Socket

```bash
echo '{
    "hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]
}' > "/etc/docker/daemon.json"

service=$(cat /lib/systemd/system/docker.service | sed "s/ -H fd:\/\///")
printf "%s\n" "$service" > /lib/systemd/system/docker.service

systemctl daemon-reload
systemctl restart docker
```

`curl -sS -X GET http://192.168.3.102:2375/version | jq .`

#### Metrics

Включаем встроенный экспортер на конечной точке `/metrics` в файле `/etc/docker/daemon.json` для `Prometheus`:

```yaml
{
  "metrics-addr": "0.0.0.0:9323"
}
```

`curl http://192.168.3.102:9323/metrics`

#### Docker.DotNet

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

### Docker cli

`docker search lazydocker` поиск образа в реестре \
`docker pull lazyteam/lazydocker` скачать образ из реестра [Docker Hub](https://hub.docker.com/r/lazyteam/lazydocker) \
`docker images`/`docker image ls` отобразить все локальные (уже загруженные) образы docker (`image ls`) \
`docker images --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}"` отфильтровать вывод  \
`docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock lazyteam/lazydocker` запустить контейнер из образа c последующим удалением (`--rm`) в интерактивном режиме (открыть `STDIN`) и пробросом `tty` \
`docker run -d --name lazydocker -it -v /var/run/docker.sock:/var/run/docker.sock lazyteam/lazydocker` запустить контейнер в фоне (`-d`/`--deamon`) \
`docker logs prometheus` вывести логи контейнера (содержимое `STDOUT` и `STDERR`) \
`docker attach lazydocker` подключиться к терминалу работающего контейнера \
`docker exec -it lazydocker sh -c bash` подключиться терминалу контейнера с помощью `sh`/`bash` \
`docker run -it --rm --entrypoint sh lazyteam/lazydocker` запустить контейнер и подключиться к нему (даже если контейнер уходит в ошибку при запуске) \
`docker stats` посмотреть статистику потребляемых ресурсов запущенными контейнерами (`top`) \
`docker top lazydocker`/`docker exec lazycompose top -n 1` отобразить список всех работающих процессов внутри контейнера \
`docker ps` отобразить все запущенные контейнеры \
`docker ps -a` отобразить все запущенные и остановленные контейнеры \
`docker ps -as` добавляет размер (`--size`) \
`docker stop lazydocker` остановить существующий (созданный ранее) контейнер (отправляет процессу с `PID 1` сигнал `SIGTERM` и через 10 секунд `SIGKILL`) \
`docker kill -s SIGHUP prometheus` отправить указанный сигнал контейнеру (например, перечитать конфигурацию, по умолчанию `SIGKILL`) \
`docker kill $(docker ps -q)` принудительно остановить все контейнеры \
`docker restart lazydocker` перезапустить контейнер \
`docker start lazydocker` запустить контейнер \
`docker pause lazydocker` поставить контейнер на паузу \
`docker unpause lazydocker` возобновить работу контейнера \
`docker rename lazydocker lazydocker-tui` переименоввать контейнер \
`docker rm lazydocker-tui` удалить контейнер \
`docker rmi lazyteam/lazydocker` удалить образ \
`docker image prune -a` удалить все образы, которые не используются хотя бы одним контейнером \
`docker images -q | xargs docker rmi` удалить все образы, которые не заняты контейнерами

#### update

`docker update --restart unless-stopped uptime-kuma` изменить режим перезапуска контейнера после его остановки \
`docker update --restart on-failure:3 uptime-kuma` контейнер будет перезапущен только в случае его завершения с ошибкой (когда код завершения отличается от 0), используя 3 попытки \
`docker update --cpu-shares 512 --memory 500M uptime-kuma` задать ограничения по CPU (доступ к указанной доле процессорного времени в диапазоне от 2 до 262,144 или `--cpus` - количество процессоров) и памяти

#### volume

`docker volume ls` вывести список томов и место хранения (механизмы хранения постояннымх данных контейнера на хостовой машине, которые сохраняются между перезапусками и при пересоздание контейнеров) \
`docker volume inspect uptime-kuma` подробная информация о конфигурации тома (отображает локальный путь хранения данных в системе, `Mountpoint`: `/var/lib/docker/volumes/uptime-kuma/_data`) \
`docker volume create test` создать том \
`docker volume rm test` удалить том

#### network

`docker network ls` вывести список сетей \
`docker network inspect bridge` подробная информация о сети `bridge` \
`docker inspect uptime-kuma | jq .[].NetworkSettings.Networks` узнать наименование сетевого адаптера указанного контейнера \
`docker run -d --name uptime-kuma --network host nginx louislam/uptime-kuma:1` запуск контейнера с использованием сети `host`, которая позволяет контейнеру использовать сеть хостовой машины (like NAT) \
`docker network create network_test` создать новую сеть \
`docker network connect network_test uptime-kuma` подключить работающий контейнер к указанной сети (используется для связи контейнеров) \
`docker network disconnect network_test uptime-kuma` отключить от сети \
`docker network rm network_test` удалить сеть

#### inspect

`docker inspect prometheus` подробная информация о контейнере (например, конфигурация `NetworkSettings`) \
`docker inspect prometheus --format='{{.LogPath}}'` отобразить, где хранятся логи для конкретного контейнера в локальной системе \
`docker port prometheus` отобразить проброшенные порты контейнера \
`docker inspect $(docker ps -q) --format='{{.NetworkSettings.Ports}}'` отобразить TCP порты всех запущенных контейнеров \
`cat /var/lib/docker/containers/$id/config.v2.json | jq .` прочитать конфигурационный файл контейнера

#### system

`docker system df` отобразить сводную информацию занятого пространства образами, контейнерами и хранилищами \
`docker system events` выводить события от демона `dockerd` в реальном времени \
`docker system prune –volumes` заменяет все четыре команды очистки и дополнительно очищает кеш сборки

#### diff

`docker diff <container_id_or_name>` отображает изменения, внесенные в файловую систему контейнера по сравнению с исходным образом

`A` - добавленные файлы \
`C` - измененные файлы \
`D` - удаленные файлы

#### copy

Копируем базу данных `sqlite3`, обновляем пароль и разблокируем пользователя Grafana:

```bash
docker exec -it grafana ls /var/lib/grafana/grafana.db
sudo apt-get install sqlite3
docker cp grafana:/var/lib/grafana/grafana.db grafana.db
sqlite3 grafana.db "UPDATE user SET password = '59acf18b94d7eb0694c61e60ce44c110c7a683ac6a8f09580d626f90f4a242000746579358d77dd9e570e83fa24faa88a8a6', salt = 'F3FAxVm33R' WHERE login = 'admin';"
sqlite3 grafana.db "UPDATE user SET is_disabled = 0 WHERE login = 'admin';"
docker cp grafana.db grafana:/var/lib/grafana/grafana.db
```

#### context

`docker context create rpi-106 --docker "host=tcp://192.168.3.106:2375"` добавить подключение к удаленному хосту через протокол `TCP` \
`docker context create rpi-106 --docker "host=ssh://lifailon@192.168.3.106:2121"` добавить подключение к удаленному хосту через протокол `SSH` \
`docker context ls` список всех доступных контекстов (`*` отображается текущий) \
`docker context inspect rpi-106` конфигурация указанного контекста \
`docker context use rpi-106` переключиться на выбранный контекст (возможно на прямую взаимосдействовать с удаленным Docker Engine через cli, за исключением взаимодействия через Socket) \
`docker context rm rpi-106` удалить контекст

#### alias

```bash
# Параллельный запуск всех остановленных контейнеров со статус выхода exited
alias docker-all-start='docker ps -aq --filter "status=exited" | xargs -P 4 -I {} docker start {}'
# Остановка всех работающих контейнеров
alias docker-all-stop='docker ps -aq | xargs -P 4 -I {} docker stop {}'
# Перезапуск всех контейнеров
alias docker-all-restart='docker ps -aq | xargs -P 4 -I {} docker restart {}'
```

## Docker Compose

```bash
mkdir -p $HOME/.local/bin
version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
curl -sSL "https://github.com/docker/compose/releases/download/$version/docker-compose-$(uname -s)-$(uname -m)" -o $HOME/.local/bin/docker-compose
chmod +x $HOME/.local/bin/docker-compose
mkdir -p $HOME/.docker/cli-plugins
cp $HOME/.local/bin/docker-compose $HOME/.docker/cli-plugins/docker-compose
docker compose version
```

### Dozzle

[Dozzle](https://github.com/amir20/dozzle) - веб-интерфейс для просмотра и фильтрации журналов Docker (без хранения), с поддержкой базового управления, подключения удаленных хостов и кластеров Kubernetes.

`mkdir -p $HOME/docker/dozzle/dozzle_data && cd $HOME/dozzle`

Сгенерировать пароль в формате `sha-256`:

`echo -n DozzleAdmin | shasum -a 256`

Передать в конфигурацию `./dozzle_data/users.yml`:

```yaml
users:
  admin:
    name: "admin"
    password: "a800c3ee4dac5102ed13ba673589077cf0a87a7ddaff59882bb3c08f275a516e"
```

или сгенерировать пользователя в формате `yaml` конфигурации:

```bash
docker run -it --rm amir20/dozzle generate --name admin --email admin@admin.com --password admin admin1
```

Запускаем контейнер:

```yaml
services:
  dozzle:
    image: amir20/dozzle:latest
    container_name: dozzle
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./dozzle_data:/data
    environment:
      # Отключить сбор и отправку аналитики
      - DOZZLE_NO_ANALYTICS=true
      # Включить действия (start/stop/restart)
      - DOZZLE_ENABLE_ACTIONS=true
      # Добавить возможность подключения к работающим контейнерам
      - DOZZLE_ENABLE_SHELL=true
      # Включить базовую авторизацию из файла /data/users.yml
      - DOZZLE_AUTH_PROVIDER=simple
      # Подключиться к удаленному хосту через Docker Socket API
      # - DOZZLE_REMOTE_HOST=tcp://192.168.3.101:2375|us-101
      # Подключиться к удаленному хосту через Dozzle Agent
      # - DOZZLE_REMOTE_AGENT=192.168.3.105:7007,192.168.3.106:7007
    ports:
      - 9090:8080

  # Контейнер для мониторинга файла syslog на хостовой системе
  dozzle-syslog:
    image: alpine
    container_name: dozzle-syslog
    restart: always
    volumes:
      - /var/log/syslog:/var/log/custom.log
    command:
      - tail
      - -f
      - /var/log/custom.log
```

`docker-compose up -d`

Контейнер для агента (альтернатива Docker TCP API):

```yaml
services:
  dozzle-agent:
    image: amir20/dozzle:latest
    container_name: dozzle-agent
    restart: always
    command: agent
    # environment:
    #   - DOZZLE_HOSTNAME=dozzle-agent-01
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
    ports:
      - 7007:7007
```

### Socket Proxy

Проксирование локального сокета Docker на базе HAProxy (не требуется внесение изменений в системные файлы, такие как `daemon.json` и `docker.service`) с контролем прав доступа к конечным точкам через переменные среды.

```yaml
services:
  docker-socket-proxy:
    # image: lifailon/docker-socket-proxy:arm64
    image: lifailon/docker-socket-proxy:amd64
    container_name: docker-socket-proxy
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - 2375:2375 # Docker API
      - 2376:2376 # HAProxy статистика
    environment:
      - SOCKET_PATH=/var/run/docker.sock  # Путь к Docker сокету внутри контейнера
      - LOG_LEVEL=info      # Уровень логирования HAProxy-прокси (debug|info|warn|error)
      # Включено по умолчанию
      - INFO=1              # /info - общая информация о Docker демоне, версия, плагины, лимиты
      - PING=1              # /_ping - проверку доступности Docker API
      - VERSION=1           # /version - получение версии API и информации о сервере
      # Отключено по умолчанию
      - POST=1              # HTTP POST-запросы (например, для создания контейнеров)
      - GRPC=1              # /grpc - gRPC интерфейс Docker (экспериментальный)
      - EXEC=1              # /exec - запуск команд внутри контейнеров
      - ALLOW_RESTARTS=1    # /containers/.../(restart|kill) - перезапуск или остановку контейнера
      - ALLOW_START=1       # /containers/.../start - запуск остановленных контейнеров
      - ALLOW_STOP=1        # /containers/.../stop - остановку запущенных контейнеров
      - AUTH=1              # /auth - отвечает за логин к registry через Docker API
      - CONTAINERS=1        # /containers - список контейнеров, их создание, удаление, inspect и т.п.
      - IMAGES=1            # /images - просмотр, загрузка и удаление Docker-образов
      - NETWORKS=1          # /networks - просмотр, создание и удаление сетей Docker
      - BUILD=1             # /build - сборка образов через API
      - COMMIT=1            # /commit - создание образа из контейнера (docker commit)
      - DISTRIBUTION=1      # /distribution - доступ к registry API (например, метаданные образов)
      - EVENTS=1            # /events - поток событий Docker (создание, запуск, удаление контейнеров)
      - PLUGINS=1           # /plugins - управление Docker плагинами
      - VOLUMES=1           # /volumes - управление Docker томами (создание, удаление, просмотр)
      - SESSION=1           # /session - сессии терминалов и интерактивные API
      # Swarm
      - SWARM=0             # /swarm - настройки и статус Swarm кластера
      - NODES=0             # /nodes - информация о нодах в Swarm
      - CONFIGS=0           # /configs - используется в Swarm для конфигураций
      - SECRETS=0           # /secrets - секреты Docker Swarm
      - SERVICES=0          # /services - управление сервисами Docker Swarm
      - SYSTEM=0            # /system - общая системная информация Docker (ресурсы, usage)
      - TASKS=0             # /tasks - задачи Swarm (контейнеры внутри сервисов)
      # HAProxy stats
      - STATS_URI=/
      - STATS_USER=admin
      - STATS_PASS=admin
```

### Logging

Определить размер для одного лог-файла и огриничить количество лог-файлов:

```bash
docker run \
  --log-driver json-file \
  --log-opt max-size=10m \
  --log-opt max-file=3 \
  container_name
```

Настройка логирования в compose, используя стандартный драйвер Docker в формате `json`:

```yaml
logging:
  driver: json-file
  options:
    max-size: 10m
    max-file: 3
```

#### journald

Доступа к логам через `journalctl` используя `systemd`/`journald`

```yaml
logging:
  driver: journald
  options:
    tag: "{{.Name}}"
```

#### syslog

Изменить режим логирование всех контейнеров по умолчанию через файл `/etc/docker/daemon.json` для отправки логов на сервер [rsyslog-collector](https://github.com/rsyslog/rsyslog) или graylog в режиме inputs syslog:

```yaml
{
  "log-driver": "syslog",
  "log-opts": {
    "syslog-address": "tcp://syslog.docker.local:2514",
    "tag": "{{.Name}}"
  }
}
```

Отправка логов на сервер сервера [Sloggo](https://github.com/phare/sloggo) с использованием формата `rfc5424`:

```yaml
logging:
  driver: syslog
    options:
      syslog-address: udp://localhost:1514
      # Формат логов для Sloggo
      syslog-format: rfc5424
```

#### gelf

Отправка логов на сервер [Graylog](https://github.com/Graylog2/graylog2-server), [Logstash](https://github.com/elastic/logstash) или другие `GELF` совместимые системы:

```yaml
logging:
  driver: gelf
  options:
    gelf-address: udp://1.2.3.4:12201
    tag: "{{.Name}}"
```

#### fluentd

Отправка данных на агент [fluen-bit](https://github.com/fluent/fluent-bit) через драйвер [fluentd](https://github.com/fluent/fluentd):

```yaml
logging:
  driver: fluentd
  options:
    fluentd-address: "fluentd-server:24224"
    tag: "docker.{{.Name}}"
```

#### rsyslog

Пример запуска централизованного сервера `rsyslog` и агента для переадресации логов из контейнеров без настройки логирования:

```yaml
services:
  # Сервер для приема логов
  # rsyslog-collector:
  #   image: rsyslog/rsyslog-collector:latest
  #   container_name: rsyslog-collector
  #   restart: unless-stopped
  #   volumes:
  #     - ./log_data:/var/log
  #     - /etc/hostname:/etc/hostname:ro
  #   environment:
  #     - ENABLE_UDP=on
  #     - ENABLE_TCP=on
  #     - ENABLE_RELP=off
  #     - WRITE_ALL_FILE=on   # write all messages to /var/log/all.log
  #     - WRITE_JSON_FILE=off # write JSON formatted messages to /var/log/all-json.log
  #     - RSYSLOG_HOSTNAME=/etc/hostname
  #     - RSYSLOG_ROLE=collector
  #   ports:
  #     - 10514:514/udp
  #     - 10514:514/tcp
  # Сервер rsyslog для приема лого и веб-интефрейс на базе PimpMyLog для просмотра логов
  rsyslog-gui:
    image: aguyonnet/rsyslog-gui
    container_name: rsyslog-gui
    restart: unless-stopped
    volumes:
      - ./rsyslog_data:/var/log/net
    ports:
      - 10080:80
      - 10514:514/udp
      - 10514:514/tcp
    environment:
      - SYSLOG_USERNAME=admin
      - SYSLOG_PASSWORD=admin
  # Агент для сбора логов и сокета Docker
  rsyslog-dockerlogs:
    image: rsyslog/rsyslog-dockerlogs:latest
    container_name: rsyslog-dockerlogs
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /etc/hostname:/etc/hostname:ro
    environment:
      - REMOTE_SERVER_NAME=rsyslog-collector
      - REMOTE_SERVER_PORT=514
      - RSYSLOG_HOSTNAME=/etc/hostname
      - RSYSLOG_ROLE=docker
```

### Volumes

#### tmpfs

Временная файловая система для хранения данных в оперативной памяти (исчезают после остановки контейнера):

```yaml
volumes:
  ram_disk:
    driver_opts:
      type: tmpfs
      device: tmpfs
      o: "size=512m,uid=1000"
```

#### nfs

Монтирование `NFS` (без необходимости предварительного монтирования на хосте):

```yaml
volumes:
  nfs_volume:
    driver_opts:
      type: nfs
      o: "addr=192.168.3.101,nolock,soft,nfsvers=4"
      device: ":/backup"
```

#### smb

Монтирование удаленного Windows хранилища через протокол `SMB`:

```yaml
services:
  nginx:
    image: nginx
    container_name: nginx
    volumes:
      - smb_volume:/data

volumes:
  smb_volume:
    driver_opts:
      type: cifs
      o: username=guest,password=,uid=1000,gid=1000
      device: //192.168.3.100/docker-data/nginx
```

Ручное монтирование `SMB`:

`sudo apt install cifs-utils smbclient -y` установка зависимостей \
`smbclient //192.168.3.100/backup -U guest%` проверить гостевой доступ к удаленной шаре \
`sudo mkdir /mnt/smb_backup && sudo chown -R 1000:1000 /mnt/smb_backup` создать директорию для монтирования \
`mount -t cifs //192.168.3.100/backup /mnt/smb_backup -o user=guest` примонтировать (до перезагрузки) \
`echo "//192.168.3.100/backup /mnt/smb_backup cifs username=guest,password=,uid=1000,gid=1000,rw,vers=3.0 0 0" | sudo tee -a /etc/fstab` добавить настройки при загрузки системы \
`mount -a && systemctl daemon-reload && df -h` примонтировать (прочитать и применить все записи из fstab)

```yaml
volumes:
  - /mnt/smb_backup:/data
```

### Network

Контейнеры в одном стеке взаимодействуют между собой через виртуальный мост (`bridge`) по `container_name` без проброса портов, а также с контейнерами в других стеках через проброс сети в помощью `external: true`.

#### bridge/external

```yaml
services:
  nginx:
    image: nginx
    container_name: nginx
    ports:
      - 80:8080 # container:host
    dns:
      - 8.8.8.8
    networks:
      - nginx_net
      - dns-stack_default

networks:
  nginx_net:
    driver: bridge
  dns-stack_default:
    external: true
```

#### host

В сетевом режиме `host` используется сеть хоста напрямую (порты через секцию `ports` не пробрасываются).

```yaml
services:
  nginx:
    image: nginx
    container_name: nginx
    network_mode: host
```

#### macvlan

`macvlan` - это сетевой драйвер, который работает на уровне `L2`, где контейнеры получают свои `MAC` и `IP` адреса во внешней сети хоста (линкуется по названию интерфейса).

`sudo ip link set eth0 promisc on` включить режим `promisc` на интерфейсе хоста, что бы иметь возможность принимать все пакеты, проходящие через хост, независимо от MAC-адреса.

`Set-VMNetworkAdapter -VMName hv-us-101 -MacAddressSpoofing On` включить режим `promisc` на виртуальной машине `Hyper-V`

```yaml
services:
  nginx:
    image: nginx
    container_name: nginx
    networks:
      macvlan_net:
        ipv4_address: 192.168.3.110

networks:
  macvlan_net:
    driver: macvlan
    driver_opts:
      parent: eth0
    ipam:
      config:
        - subnet: 192.168.3.0/24
          gateway: 192.168.3.1
```

#### ipvlan

`ipvlan` не создает отдельные MAC-адреса, поэтому может работать на `wlan` (Wi-Fi) интерфейсах хоста.

```yaml
services:
  nginx:
    image: nginx
    container_name: nginx
    networks:
      ipvlan_net:
        ipv4_address: 192.168.3.110

networks:
  ipvlan_net:
    driver: ipvlan
    driver_opts:
      parent: wlan0
      mode: l2
    ipam:
      config:
        - subnet: 192.168.3.0/24
          gateway: 192.168.3.1
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

`docker pull lifailon/torapi:latest`

`docker-stack.yml`

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
      # HTTP-запрос для проверки кода возврата (0 = успех, 1 = ошибка)
      test: ["CMD", "curl", "-f", "http://127.0.0.1:8443/api/provider/list"]
      # Проверка TCP-порта
      # test: ["CMD", "nc", "-z", "127.0.0.1 8443"]
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
    # - type: nfs                       # Удаленный NFS-сервер для общих данных в кластере
    # - type: tmpfs                     # RAM Временные файлы (/tmp)
    # - type: bind                      # Файлы на хосте (только если файлы есть на всех нодах)
    - type: volume                      # Управляется Docker (данные БД, кеш)
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

## Kubernetes

[Kubernetes](https://github.com/kubernetes/kubernetes) (`k8s`) - это открытая платформа для оркестрации контейнеров, которая поддерживает автоматическое развертывание (склирование желаемого количества реплик на разных нодах), самовосстановлением (перезапуск контейнеров на рабочих нодах), балансировку, управление трафиком, а также горизонтальное и вертикальным масштабированием (`HPA`/`VPA`). Кластер всегда стремится к тому состоянию, которое описано в конфигурации.

Компоненты кластера:

- `etcd` - распределенная база данных типа ключ-значение (key-value), в которой хранится состояние всего кластера (конфигурации, секреты, состояния подов). Работает на алгоритме `Raft` для консенсуса. Использует порты `2379` для общения с API-сервером Kubernetes и `2380` для синхронизация копий `etcd` между собой.
- `kube-apiserver` -  единственный компонент, который имеет право напрямую читать и записывать данные в `etcd` и работает на Master-нодах в кластере. Например, при использование команды `kubectl get pods`, запрос идет на порт `6443` Master-ноды.
- `kubelet` - агент, запущенный на каждой Worker-ноде. Он получает команды (`PodSpecs`) от API-сервера и следит за запуском и здоровьем контейнеров. Порт `10250` используется API-сервером для связи с агентом, например, при использование команды `kubectl logs` или `kubectl exec`.
- `Container Runtime` - программное обеспечение (например, `containerd` или `CRI-O`), которое непосредственно запускает контейнеры. `Kubelet` общается с ним через протокол `CRI` (Container Runtime Interface).
- `kube-scheduler` - диспетчер задач, который следит за появлением новых подов, у которых не назначен узел. Он выбирает подходящую Worker-ноду, основываясь на ресурсах (`CPU`/`RAM`), политиках и ограничениях (`affinity`/`taints`).
- `kube-controller-manager` - состав контроллеров, которые следят за состоянием кластера для приведения его к желаемому виду (например, `Node Controller` следит за доступностью узлов, а `Replication Controller` поддерживает нужное количество копий пода).
- `kube-proxy` - сетевой агент на каждой ноде. Он реализует правила сети Kubernetes через `IPtables` или `IPVS`, позволяя подам общаться друг с другом и обеспечивая работу сервисов. Объект `Service`, который объединяет группу подов в логическую единицу получает один общий виртуальный IP-адрес. Когда на этот адрес приходит запрос, кластер через `kube-proxy` сам балансирует трафик, перенаправляя его на один из живых подов этой группы, независимо от того, на каких нодах они физически находятся.

Краткий сценарий работы:

- Администратор кластера отправляет `YAML` файл через `kubectl` на API-Server.
- `kube-apiserver` сохраняет план в `etcd`.
- `kube-scheduler` видит новый под без узла, выбирает лучшую Worker-ноду и пишет ее имя в `etcd`.
- `kubelet` видит в `etcd`, что на его ноду назначен новый под и передает команду в `runtime` (например, `containerd`) запустить контейнеры.
- `kube-proxy` настраивает правила сети, чтобы этот под стал доступен.

### Kompose

[Kompose](https://github.com/kubernetes/kompose) - инструмент, который конвертируемт спецификацию `docker-compose` в манифесты Kubernetes.

```bash
mkdir -p $HOME/.local/bin
arch=$(uname -m)
case $arch in
    x86_64|amd64) arch="amd64" ;;
    aarch64) arch="arm64" ;;
esac
version=$(curl -s https://api.github.com/repos/kubernetes/kompose/releases/latest | jq -r .tag_name)
curl -sSL https://github.com/kubernetes/kompose/releases/download/$version/kompose-linux-$arch -o $HOME/.local/bin/kompose
chmod +x $HOME/.local/bin/kompose
```

`kompose --file docker-compose.yaml convert` конвертация

`docker-compose bridge convert` встроенный конвертер в `docker compose` на базе [шаблонов Helm](https://github.com/docker/compose-bridge-transformer).

### Kubeadm

[Kubeadm](https://github.com/kubernetes/kubeadm) - это инструмент командной строки для сборки и настройки кластера Kubernetes.

Настройка кластера:

```bash
# Включаем использования Overlay FS и проброс трафика через bridge
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

# Настройка системных параметров для работы сети
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sudo sysctl --system

# Устанавливаем контейнерную среду выполнения containerd
sudo apt-get update
sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd

# Устанавливаем зависимые пакеты
# curl -sSLf https://pkgs.k8s.io/core:/stable:/v1.35/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
# echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.35/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -sSLf https://packages.cloud.yandex.ru/core:/stable:/v1.35/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://packages.cloud.yandex.ru/core:/stable:/v1.35/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
sudo systemctl status kubelet

# Инициализируем кластер (стандартная подсеть для Flannel/Calico)
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
# Список активных токенов и время их жизни
kubeadm token list
# Генерация нового токена для подключения Worker Node
# kubeadm token create
# Команда для присоединение Worker нод
kubeadm join 192.168.3.101:6443 --token 2csxxk.pcl8p5n5lj8mu8rd \
  --discovery-token-ca-cert-hash sha256:72353cb9c1cec097908f766f028cec6f12ec95f62f3447990b45279f7cf88fe2

# Настраиваем конфигурацию, чтобы работать с кластером через kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sed 's/127.0.0.1/192.168.3.101/g' -i $HOME/.kube/config
kubectl get nodes
# Удалить taint метку на всех Master нодах
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
```

### Metrics Server

[Metrics Server](https://github.com/kubernetes-sigs/metrics-server) собирает метрики ресурсов из `Kubelet` агентов на нодах и предоставляет их в Kubernetes `apiserver` через Metrics API для использования в `HPA` и `VPA`.

```bash
# Установить metrics-server в кластер
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
# Статус запуска
kubectl get deployment metrics-server -n kube-system
# Проверить логи metrics-server
kubectl logs -n kube-system deployment/metrics-server
# Отключить проверку TLS сертификатов, т.к. требует поле SAN (Subject Alternative Name)
kubectl patch deployment metrics-server -n kube-system --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls"}]'
# Отобразить метрики ресурсов для всех узлов в кластере
kubectl top nodes
```

### Flannel

[Flannel](https://github.com/flannel-io/flannel) - это сетевой плагин (`CNI`) для создания `overlay` сети для связи между подами на разных нодах кластера.

```yaml
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
# Выводим список всех ресурсов в новом пространстве имен kube-flannel
kubectl get all -n kube-flannel
# Список DaemonSet и подов
kubectl get ds -n kube-flannel kube-flannel-ds
kubectl get pods -n kube-flannel -l app=flannel
```

### Local Path Provisioner

[Local Path Provisioner](https://github.com/rancher/local-path-provisioner) - это инструмент от Rancher, позволяющий использовать локальные диски нодов для постоянного хранения данных (`Persistent Volumes`). Автоматически создает директории на ноде при создании запросов на хранение (`PVC`).

```bash
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
kubectl get all -n local-path-storage
# Список всех доступных StorageClass
kubectl get sc
# Сделать хранилищем по умолчанию (бьз необходимости прописывать storageClassName: local-path в PVC)
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

### Headlamp

[Headlamp](https://github.com/kubernetes-sigs/headlamp) - это современная альтернатива [Kubernetes Dashboard](https://github.com/kubernetes-retired/dashboard) c расширенным функционалом, созданная сообществом `SIGs` (Kubernetes Special Interest Groups).

```bash
# Установить в кластер
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/headlamp/main/kubernetes-headlamp.yaml
# Создать сервисный аккаунт
kubectl create serviceaccount headlamp-admin -n kube-system
# Назначить роль администратора кластера для сервисного аккаунта
kubectl create clusterrolebinding headlamp-admin --serviceaccount=kube-system:headlamp-admin --clusterrole=cluster-admin

# Сгенерировать временный JWT-токен, который не хранится в базе данных Kubernetes как объект
# kubectl create token headlamp-admin -n kube-system --duration=43800h

# Создать токен для авторизации
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: headlamp-admin-token
  namespace: kube-system
  annotations:
    kubernetes.io/service-account.name: headlamp-admin
type: kubernetes.io/service-account-token
EOF
# Получить токен авторизации из секрета
kubectl get secret headlamp-admin-token -n kube-system -o jsonpath='{.data.token}' | base64 --decode

# Пробросить порт через ноду
kubectl patch svc headlamp -n kube-system -p '{"spec": {"type": "NodePort"}}'
kubectl get svc headlamp -n kube-system
```

### Kubectl Config

[Kubectl](https://github.com/kubernetes/kubectl) - это инструмент командной строки для управления кластерами Kubernetes.

```bash
# Загрузить kubectl
curl -L "https://dl.k8s.io/release/$(curl -sSL https://dl.k8s.io/release/stable.txt)/bin/linux/$(dpkg --print-architecture)/kubectl" -o /usr/bin/kubectl
# Включить автодополнение для kubectl в bash
echo "source <(kubectl completion bash)" >> ~/.bashrc
```

Пример конфигурации для подключения к кластеру:

```yaml
apiVersion: v1
kind: Config
current-context: ${contextName}
preferences: {}

# Адрес кластера
clusters:
  - name: ${contextName}-url
    cluster:
      server: https://192.168.3.101:6443

# Токен доступа
users:
  - name: ${contextName}-usr
    user:
      token: ${token}

# Название контекста (связь адреса с токеном)
contexts:
  - name: ${contextName}
    context:
      cluster: ${contextName}-url
      # Название пространтсва имен по умолчанию при переключение кластера
      namespace: ${namespace}
      user: ${contextName}-usr
```

Базовые команды для управления конфигурациями и получения информации:

```bash
# Использовать несколько файлов kubeconfig одновременно (в выводе объеденяет конфигурацию)
KUBECONFIG=~/.kube/config:~/.kube/config_new

# Отобразить текущую конфигурацию (настройка подключения kubectl к кластеру)
kubectl config view
# Отобразить список всех доступных контекстов, кластеров и пользователей
kubectl config get-contexts
kubectl config get-clusters
kubectl config get-users
# Отобразить текущий контекст
kubectl config current-context
# Переключить контекст (установить контекст default как контекст по умолчанию)
kubectl config use-context default
# Изменить контекст по умолчанию в файле kubeconfig (параметр current-context)
kubectl config set-context default

# Отобразить адреса главного узла и сервисов
kubectl cluster-info
# Вывести состояние текущего кластера
kubectl cluster-info dump
# выгрузить состояние текущего кластера в директорию
kubectl cluster-info dump --output-directory=./cluster-state

# Вывести все ресурсы кластера
kubectl get all
# Сортировка по дате создания/изменения
kubectl get all --sort-by=.metadata.creationTimestamp

# Отобразить все поддерживаемые типы ресурсов
kubectl api-resources
# Отобразить список всех ресурсов и действий, которые текущему пользователю разрешено совершать с этими ресурсами (права роли RBAC)
kubectl auth can-i --list
```

Уровни детального вывода для отладки в командах `kubectl`:

- `--v=3`	- расширенная информация об изменениях
- `--v=6`	- показать запрашиваемые ресурсы (например, загрузка файла `kubeconfig` и url для GET-запроса при вызове `kubectl get pods`)
- `--v=9`	- показать содержимого HTTP-запроса в полном виде (включая заголовки)

### K9s

[K9s](https://github.com/derailed/k9s) - это терминальный интерфейс (`TUI`) для взаимодействия с кластерами Kubernetes (базовое управление и просмотр логов) с поддержкой [плагинов](https://k9scli.io/topics/plugins).

```bash
wget https://github.com/derailed/k9s/releases/latest/download/k9s_linux_$(dpkg --print-architecture).deb
sudo apt install ./k9s_linux_*.deb
rm k9s_linux_*.deb

EDITOR=nano k9s -A
```

Настраиваем плагин [kubectl-node-shell](https://github.com/kvaps/kubectl-node-shell) в файле `~/.config/k9s/plugins.yaml` для подключения к терминалу ноды:

```yaml
plugins:
  kubectl-node-shell:
    shortCut: s
    description: Open a root shell on a node using the node-shell plugin
    scopes:
      - nodes
    command: kubectl
    args:
      - node-shell
      - $NAME
      - --context
      - $CONTEXT
    background: false
    confirm: false
  kubectl-node-shell-root:
    shortCut: a
    description: Запуск временного пода для root-доступа к термину ноды
    dangerous: true
    scopes:
      - nodes
    command: kubectl
    background: false
    confirm: true
    args:
      - debug
      - node/$NAME
      - -it
      - --image=alpine
      # Привелигированный доступ к хостовой системе (hostNetwork: true и hostPID: true)
      # Монтирует файловую систему ноды по пути /host
      - --profile=sysadmin
```

Встроенные переменные:

- `$RESOURCE_GROUP` - группа API текущего ресурса из `apiVersion` (например, `apps`)
- `$RESOURCE_VERSION` - версия API выбранного ресурса (например, `v1`)
- `$RESOURCE_NAME` - тип выбранного ресурса (например, `deployments`)
- `$NAMESPACE` - имя пространства имен выбранного ресурса
- `$NAME` - имя выбранного ресурса из `metadata.name`
- `$POD` - имя пода (доступно при нахождении в режиме просмотра контейнеров)
- `$CONTAINER` - имя выбранного контейнера
- `$FILTER` - текущая строка фильтрации (введенная через `/`)
- `$KUBECONFIG` - путь к файлу конфигурации `KubeConfig`
- `$CLUSTER` - имя выбранного (используемого) кластера
- `$CONTEXT` - имя выбранного (используемого) контекста
- `$USER` - имя выбранного (используемого) пользователя
- `$GROUPS` - активные группы выбранного (используемого) пользователя
- `$COL-<COLUMN_NAME>` - значение из выбранной колонки таблицы (например, `$COL-STATUS` или `$COL-IP`).

### Krew

[Krew](https://github.com/kubernetes-sigs/krew) - менеджер плагинов для kubectl.

```bash
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
) &&
echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> ~/.bashrc &&
source ~/.bashrc
```

| Плагин                                                              | Описание                                                                                                  |
| -                                                                   | -                                                                                                         |
| [kubectx & kubens](https://github.com/ahmetb/kubectx)               | Быстрое переключение между контекстами (кластерамси) и пространствами имен (требует установку `fzf`).     |
| [ktop](https://github.com/vladimirvivien/ktop)                      | Мониторинг нагрузки всех node и pods в реальном времени.                                                  |
| [ketall/get-all](https://github.com/corneliusweig/ketall)           | Отображает все ресурсы Kubernetes.                                                                        |
| [kubectl-tree](https://github.com/ahmetb/kubectl-tree)              | Отображает зависимости ресурсов в древовидном формате.                                                    |
| [kubectl-node-shell](https://github.com/kvaps/kubectl-node-shell)   | Bash скрипт для подключения к оболочке операционной системы хоста (node, монтирует pode на базе Alpine).  |
| [kubetail](https://github.com/johanhaleby/kubetail)                 | Bash скрипт, позволяющий объединять логи из нескольких подов в один поток.                                |
| [kubetail & Dashboard](https://github.com/kubetail-org/kubetail)    | Панель управления для просмотра логов в терминале или браузер.                                            |
| [stern](https://github.com/stern/stern)                             | Одновременный просмотр логов из нескольких подов в одном потоке.                                          |
| [outdated](https://github.com/replicatedhq/outdated)                | Отображает устаревшие образы, которые доступны к обновлению.                                              |

```bash
kubectl krew install ctx ns ktop get-all tree kubectl-node-shell kubetail stern outdated

kubectl ctx
kubectl ns

kubectl ktop

kubectl get all -A
kubectl get-all
kubectl get-all --since 24h

kubectl tree deployment traefik -n default

kubectl get node
kubectl node-shell rpi-105

kubectl kubetail logs traefik-977b5d47-mzhwx httpbin-7c454b5b68-q2mfb
kubectl kubetail serve

kubectl stern . -n default --tail 5
kubectl stern . --all-namespaces --tail 5 --since 10m --no-follow 100

kubectl outdated
```

### Kubelet Configuration

[Kubelet Configuration](https://kubernetes.io/docs/reference/config-api/kubelet-config.v1beta1) - глобальная конфигурация `Kubelet` агентов.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: kubelet-config-1.28
  namespace: kube-system
data:
  kubelet: |
    apiVersion: kubelet.config.k8s.io/v1beta1
    kind: KubeletConfiguration
    # Резервирование ресурсов для системы
    systemReserved:
      cpu: "500m"
      memory: "1Gi"
    kubeReserved:
      cpu: "500m"
      memory: "1Gi"
    # Порог вытеснения (Eviction) при нехватке ресурсов
    # Когда на диске останется меньше 5%, Kubelet начнет удалять поды
    evictionHard:
      memory.available: "500Mi"
      nodefs.available: "5%"
      imagefs.available: "5%"
    
    # Настройки безопасности и доступа
    authentication:
      anonymous:
        enabled: false # Запрещаем анонимные запросы к API kubelet
      webhook:
        enabled: true  # Разрешаем проверку прав через основной API-server
    
    # Максимальное кол-во подов на одной ноде
    maxPods: 50
    
    # Хранение логов
    containerLogMaxSize: "10Mi"
    containerLogMaxFiles: 5
    
    # Настройка Garbage Collection (очистка старых образов)
    imageGCHighThresholdPercent: 85   # Начинать чистку, если диск забит на 85%
    imageGCLowThresholdPercent: 80    # Чистить, пока не станет 80%
    
    # DNS настройки для подов
    clusterDNS:
    - "10.96.0.10"
    clusterDomain: "k8s.local"
    
    # Режим работы с Cgroups
    cgroupDriver: systemd
```

### Node

```bash
# Отображает список всех узлов и их текущий статус (`Ready`, `SchedulingDisabled` и т.д.) \
kubectl get nodes
# отображает подробную информацию об узле (ресурсы, события и запущенные поды)
kubectl describe node node-01
# Отображает нагрузку на ноды (CPU и память) от Metrics Server
kubectl top node

# Подготовка нод к техническому обслуживанию
# Отключает возможность создания новых нод на поде (не удаляет поды, которые уже запущены)
kubectl cordon node-01
# Безопасно вытесняет все запущенные на нем поды
kubectl drain node-01
# Возвращяет в рабочее состояние после drain и uncordon
kubectl uncordon node-01
```

### Labels

Связи в Kubernetes работают с помощью селекторов (`selectors`) и меток (`labels`) по принципу фильтров. Например, в шаблоне `Deployment` по пути `spec.template.metadata.labels` указана метки `app: torapi`, а `Deployment` управляет только теми подами, чьи метки совпадают с его селектором в `spec.selector.matchLabels`.

```bash
# Отобразить все доступные лейблы на нодах
kubectl get nodes --show-labels
# Создать новый лейбл на ноде
kubectl label nodes node-01 diskType=hdd
# Изменить значение лейбла
kubectl label nodes node-01 diskType=ssd --overwrite
# Удалить лейбл
kubectl label nodes node-01 diskType-
```

### Namespaces

[Namespaces](https://kubernetes.io/ru/docs/concepts/overview/working-with-objects/namespaces) -  это виртуальные кластера в одном физическом кластере. Имена ресурсов в `metadata.name` являются идентификатором объекта в кластере и должны быть уникальными в пределах одного пространства имен (именно это имя используется в командах `kubectl` при обращение к ресурсам кластера).

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: rest-api
```

`kubectl apply -f namespace.yaml` или `kubectl create namespace rest-api`

`kubectl get ns` вывести список всех пространств имен в кластере

`kubectl describe ns rest-api` вывести статус, `labels`, наличие активных квот (`ResourceQuota`) и ограничений (`LimitRange`)

### Resource Quotas

[ResourceQuotas](https://kubernetes.io/docs/concepts/policy/resource-quotas) - используются в пространствах имен для разделения ресурсов (`CPU`, `memory` и количество создаваемых объектов) одного физического кластера между несколькими проектами.

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: rest-api-quotas
  namespace: rest-api
spec:
  hard:
    requests.cpu: "1"
    requests.memory: "1Gi"
    limits.cpu: "2"
    limits.memory: "2Gi"
    pods: "3"
    replicationcontrollers: "20"
    services: "10"
    services.loadbalancers: "2"
    configmaps: "10"
    secrets: "10"
    persistentvolumeclaims: "5"
```

`kubectl create -f ./quotas.yaml --namespace=rest-api` применить квоты к указанному пространству имен

`kubectl get quota --namespace=rest-api` вывести список всех квот в пространстве имен

`kubectl describe quota rest-api-quotas --namespace=rest-api` вывести ограничения выбранной квоты

### Limit Range

[LimitRange](https://kubernetes.io/docs/concepts/policy/limit-range) - это политика, ограничивающая выделение ресурсов (`limits` и `requests`), которые можно указать для каждого применимого типа объекта, например, `Container`, `Pod` (суммарное ресурсы всех контейнеров внутри одного пода) или `PersistentVolumeClaim` в пространстве имен.

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: rest-api-limits
  namespace: rest-api
spec:
  limits:
  - type: Container
    # Реквесты по умолчанию (если не будет определено в containers.resources.limits)
    defaultRequest:
      cpu: 200m
      memory: "1Gi"
    # Лимиты по умолчанию
    default: 
      cpu: 500m
      memory: "2Gi"
    # Предельный минимальный и максимальный диапазон
    min:
      cpu: 100m
    max:
      cpu: "1"
  - type: PersistentVolumeClaim
    min:
      storage: "1Gi"
    max:
      storage: "10Gi"
```

`kubectl apply -f ./limits.yaml --namespace=rest-api` применить лимиты к указанному пространству имен

`kubectl get limits --namespace=rest-api` вывести список всех лимитов в пространстве имен

`kubectl describe limitrange rest-api-limits --namespace=rest-api` вывести значения ограничений и значений по умолчанию

### Deployment

[Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment) предназначен для описания шаблона одного уникального пода без сохранения `stateless` (состояния - локальных данных) и использует не уникальные имена для подов в формате `[metadata.name]-[replicaSet_id]-[pod_id]`.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: torapi              # Имя Deployment, который управляет созданием подов
  namespace: rest-api       # Новое пространство имен
spec:
  replicas: 2               # Количество реплик (2 пода с одинаковыми настройками)
  revisionHistoryLimit: 5   # Количество ReplicaSet в истории хранения для отката
  selector:
    matchLabels:
      app: torapi           # Определяет, какие поды будут управляться этим Deployment
  template:
    metadata:
      labels:
        app: torapi         # Метка, которая связывает этот шаблон (template) с селектором выше
    spec:
      containers:
      - name: torapi                    # Имя контейнера внутри пода
        image: lifailon/torapi:latest   # Используемый образ контейнера
        imagePullPolicy: Always         # Всегда скачивать образ из реестра
        # imagePullPolicy: IfNotPresent # Использовать локальный (уже скачанный) образ контейнера
        ports:
        - containerPort: 8443           # Порт, который будет открыт внутри контейнера
        resources:                      # Ограничения и гарантируемые ресурсы
          requests:
            cpu: "100m"                 # Минимальный запрашиваемый процессор (0.1 ядра = 100 милли-ядер)
            memory: "128Mi"             # Минимальный запрашиваемый объем оперативной памяти (128 МБайт)
          limits:
            cpu: "200m"                 # Максимально доступное процессорное время 
            memory: "256Mi"             # Максимальный объем памяти
```

Сравнить текущее состояние кластера с состоянием в файле (в котором находился бы кластер в случае применения манифеста):

`kubectl diff -f ./deployment.yaml`

Применить манифест к кластеру:

`kubectl apply -f deployment.yaml`

```bash
# Создать ресурс Deployment без описания манифеста
kubectl create deployment torapi --image=lifailon/torapi:latest --replicas=2
# Удалить деплоймент вместе с его `ReplicaSet` и всеми подами
kubectl delete deployment torapi
# Открыть манифест, который уже установленный в кластер на редактирование в терминале, 
# с сохранением изменений, которые будут применяны в кластере
KUBE_EDITOR=nano kubectl edit deployment torapi

# Вывести список всех деплойментов, количество их реплик и состояние
kubectl get deployments
# Вывести список всех подов, которые создал деплоймент по лейблу (через его селектор)
kubectl get pods -l app=torapi
# Подробная информация (события, стратегия обновления, селекторы и ошибки)
kubectl describe deployment torapi

# Вывести только события для деплоймента
kubectl get events --field-selector involvedObject.name=torapi
# Вывести события всех деплойментов
kubectl get events --field-selector involvedObject.kind=Deployment
```

### Pods

```bash
# Отобразить статус всех подов
kubectl get pods
# Выводит дополнительную информации (для подов это внутренний ip-адрес и название ноды, на которой он работает)
kubectl get pods -o wide
# Отобразить только имена в формате pod/<podName>
kubectl get pods -o name
# Отобразить нужные поля таблицы вывода в пользовательском формате
kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName
# Отобразить все заданные лейблы в подах
kubectl get pods --show-labels
# Отобразить все запущенные поды с фильтрацией по лейблу
kubectl get pods -l app=torapi
# Отобразить все запущенные поды с фильтрацией по статусу
kubectl get pods --field-selector=status.phase=Running
# Отобразить нагрузку на подах из Metrics Server
kubectl top pods
# Отобразить метрики вместе с используемыми в подах контейнерами
kubectl top pods --containers

# Состояние всех реплик для всех подов и время их работы
# DESIRED - желаемое количество реплик
# CURRENT - текущее количество реплик
# READY - успешно прошли проверки готовности (probes)
kubectl get rs
# Увеличить (масштабировать) или уменьшить количество подов в Deployment до указанного числа реплик
kubectl scale deployments/torapi --replicas=3
# Обновить текущую конфигурацию
kubectl patch deployment/torapi --type=json -p '[{"op":"replace","path":"/spec/replicas","value":3}]'
# Изменения фиксируется в логах ReplicaSet (Scaled up replica set torapi-54775d94b8 from 2 to 3)
kubectl events rs/torapi
# Отобразить подробную конфигурацию развертвывания (шаблон и логи)
kubectl describe deployments.apps/torapi

# Отобразить логи выбранного пода (сообщения, которые приложение отправляет в stdout)
kubectl logs torapi-54775d94b8-t2dhm
# Выводить лог для всех запущенных репликах подов (фильтрация по лейблу) в реальном времени (--follow) с отображением временной метки (--timestamps)
kubectl logs -l app=torapi -f --timestamps
# Вывести лог за последние 30 минут
kubectl logs -l app=torapi --since=30m
# Отобразить лог предыдущего пода, если контейнер был перезапущен при падение
kubectl logs -l app=torapi --previous
# Вывести логи выбранного контейнера
kubectl logs -l app=torapi -c torapi
# Вывести логи для всех контейнеров внутри подах
kubectl logs -l app=torapi --all-containers
# Отобразить логи во всех найденных подах и их репликах по селекторам
kubectl logs -n telegram --selector="app in (openrouter-bot,ssh-bot)" --prefix --all-pods --all-containers

# Выполнить команду в указанноv контейнере внутри указанного пода (отобразить список переменных окружения)
kubectl exec torapi-54775d94b8-t2dhm -c torapi -- env
# Проверить доступность приложения внутри контейнера
kubectl exec -it torapi-54775d94b8-t2dhm -c torapi -- curl http://localhost:8443/api/provider/list
# Запустить sh или bash сессию в контейнере пода
kubectl exec -it torapi-54775d94b8-t2dhm -c torapi -- sh
# Подключиться к запущенному процессу пода (PID 1)
kubectl attach pods/torapi-54775d94b8-t2dhm
```

### ReplicaSet Rollout

`Deployment` автоматически управляет дочерними [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset), который в свою очередь управляет желаемым количеством реплик этого пода.

`Deployment` самостоятельно создает новый `ReplicaSet` только в том случае, когда меняется шаблон конфигурации будущего пода в `spec.template`.

`kubectl rollout restart deployment/torapi` перезапуск всех подов, например, для применения обновленной конфигурации или секретов без изменения образа (деплоймент по очереди пересоздаст поды в новом `ReplicaSet`, не прерывая работу сервиса)

Новый `ReplicaSet` создается только в том случае, если изменилась конфигурация самих подов. Значение в `revisionHistoryLimit`, это количество версий в журнале `ReplicaSet` в котором хранятся старые версии `Deployment`, что позволяет сделать быстрый `rollback` с помощью команды `undo`.

```bash
# Выполнить обновление образа работающего контейнера (будет создан новый ReplicaSet)
# Формат: containerName=imageName:newTag
kubectl set image deployment/openrouter-bot openrouter-bot=lifailon/openrouter-bot:0.5.0
# Выводить результат процесса обновления в реальном времени
kubectl rollout status deployment/openrouter-bot

# Отобразить список доступных версий в истории
kubectl rollout history deployment/openrouter-bot
# Вывести содержимое манифеста по номеру ревизии
kubectl rollout history deployment/openrouter-bot --revision=3
# Произвести откат на предыдущую или указанную ревизию
kubectl rollout undo deployment/openrouter-bot
kubectl rollout undo deployment/openrouter-bot --to-revision=3
# Выводить результат процесса отката в реальном времени
kubectl rollout status deployment/openrouter-bot
```

### Service

[Service](https://kubernetes.io/docs/concepts/services-networking/service) - предоставляет доступ к приложению, работающему в кластере, через единую внешнюю точку доступа, даже если рабочая нагрузка распределена между несколькими контейнерами в подах.

`Endpoint Controller` постоянно опрашивает `apiserver` для получения списка всех подов в кластере и фильтрует нужные ему поды по лейблам сервиса в `spec.selector` (`app: torapi`), а также проверяет, что прошли проверки здоровья (статус `Ready` в `livenessProbe` и `readinessProbe`). Найденные IP-адреса подов он записывает в специальный скрытый ресурс `Endpoints` и именно туда он перенаправляет трафик.

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
      targetPort: 8443    # Порт, который слушают контейнеры в подах
      port: 8444          # Порт, на котором сервис доступен внутри кластера
  type: LoadBalancer
```

`kubectl apply -f service.yaml`

Типы сервисов:

- `ClusterIP` - используется для общения сервисов внутри кластера (значение по умолчанию, чтобы другой под мог пойти к нему по адресу `http://torapi-service:8444`)
- `NodePort` - пробрасывает сервис на указанный в `ports.nodePort` (в диапазоне `30000`-`32767`) порт каждой ноды в кластере (используется временно, если нет внешнего балансировщика).
- `LoadBalancer` - открывает порт, указанный в `ports.port`, на внешнем IP-адресе в облаке.
- `ExternalName` - сопоставляют сервис с DNS-именем указанным в `spec.externalName` вместо селектора (например, при поиске хоста `torapi-service.rest-api.svc.cluster.local` служба DNS в кластере возвращает `CNAME` запись типа `torapi.k8s.local`).

Команды для создания сервиса вручную:

```yaml
# Создать сервис, автоматически привязав его к Deployment с помощью Label Selector
kubectl expose deployment torapi --target-port=8443 --port=8444 --name=torapi-service
# Изменить тип сервиса
kubectl patch svc torapi-service -p '{"spec": {"type": "LoadBalancer"}}'
# Создать внутренний сервис в формате <port>:<targetPort> без привязки к Deployment
kubectl create service clusterip torapi-service --tcp=8443:80
# Создать сервис типа NodePort (открывает порт на всех узлах кластера)
kubectl create service nodeport torapi-service --tcp=8443:80
# Изменить NodePort
kubectl patch svc torapi-service --type='json' -p='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value": 30443}]'
# Удалить сервис
kubectl delete svc torapi-service
```

Проверить распредиление нагрузки в режиме `LoadBalancer` (с использованием [ServiceLB](https://docs.k3s.io/networking/networking-services) в кластере `k3s`) между репликами подов:

```bash
for i in {1..20}; do
    curl -s http://192.168.3.105:8444/api/provider/list
done
```

Команды для управления сервисами:

```bash
# Список всех сервисов в текущем неймспейсе
kubectl get svc
# Показать расширенную информацию (включая External IP и селекторы)
kubectl get svc -o wide
# Детальное описание сервиса (IP, порты, эндпоинты, селекторы)
kubectl describe svc torapi-service
# Список конечных точек (на какие IP подов сервис перенаправляет трафик)
kubectl get endpoints torapi-service
```


### DNS

В каждом кластере Kubernetes есть внутренний сервис DNS (чаще [CoreDNS](https://github.com/coredns/coredns)) в пространстве имен `kube-system`. У него есть фиксированный `ClusterIP` (например, `10.96.0.10`), который постоянен на протяжении всей жизни кластера.

На этапе создания пода, планировщик (`kube-scheduler`) назначает под на конкретную ноду, на котором агент `Kubelet` смотрит в свои настройки по флагу `--cluster-dns`, где прописан IP-адрес DNS-сервиса (`10.96.0.10`). В момент создания контейнера, `Kubelet` генерирует файл `/etc/resolv.conf` внутри файловой системы контейнера с содержимым:

```ini
nameserver 10.96.0.10
search namespace_name.svc.cluster.local svc.cluster.local cluster.local
options ndots:5
```

Название в `metadata.name` объекта `Service` становится доменным именем для всех подов внутри кластера, чтобы любой другой под в этом же пространстве имен мог обращаться к нему по имени.

Формат имени для обращения в другое пространство имен: `<metadata.name>.<namespace_name>.svc.cluster.local`

Пример:

`curl http://torapi-service.rest-api.svc.cluster.local:8444/api/provider/list`

### Proxy

```bash
# Запустить прокси сервер для локального взаимодействия с частной сетью кластера через API
kubectl proxy
# Вывести список всех доступных конечных точек
curl http://localhost:8001
# Dывести список всех имен подов в указанном namespace
curl -s http://localhost:8001/api/v1/namespaces/rest-api/pods | jq -r .items[].metadata.name
# Напрямую отправить запрос на конечную точку приложения в контейнере
curl -s http://localhost:8001/api/v1/namespaces/rest-api/services/torapi-service:8444/proxy/api/provider/list

# Запустить временный проброс порта из пода
kubectl port-forward -n rest-api pods/torapi-54775d94b8-t2dhm 8443:8443
curl http://localhost:8443/api/provider/list
```

### Probes

[Probes](https://kubernetes.io/ru/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes) - это проверки, которые использует `kubelet` для перезапуска контейнера.

Режимы проверки доступности приложения:

- `livenessProbe` - проверяет, живо ли приложение внутри контейнера (`httpGet` ждет код ответа 200 до 399). Если проба провалена, Kubernetes убивает контейнер и запускает новый (перезагрузка).
- `readinessProbe` - проверяет, готово ли приложение принимать входящий трафик. Если проба провалена (например, приложение еще загружает кэш или подключается к БД), Kubernetes временно исключает этот под из балансировки в `Service`, и на него не идет трафик.
- `startupProbe` - используется для проверки инициализации (например, выполнения скриптов) перед запуском приложения. Сначала отрабатывает `Startup`, а потом уже `Liveness` и `Readiness` параллельно, позволяя не убить приложение во время его инициализации.

```yaml
livenessProbe:
  # tcpSocket:
  #   port: 6379
  # grpc:
  #   port: 9000
  # exec:
  #   command: ["/bin/sh", "-c", "curl -sf http://localhost:8443/api/provider/list"]
  httpGet:
    path: /api/provider/list  # Конечная точка в контейнере, по которому будет проверяться работоспособность
    port: 8443                # Порт, на котором доступен этот endpoint внутри контейнера
  initialDelaySeconds: 5      # Ждет 5 секунд после запуска контейнера перед первой проверкой
  initialDelaySeconds: 5      # Время ожидания до начала проверок (5 секунд)
  periodSeconds: 10           # Интервал проверок (каждые 10 секунд)
  timeoutSeconds: 2           # Максимальное время ожидания ответа в секундах
  failureThreshold: 3         # Количество неудачных попыток перед рестартом контейнера
```

### Container Hooks

[Container Lifecycle Hooks](https://kubernetes.io/ru/docs/concepts/containers/container-lifecycle-hooks) - позволяют выполнять заданные действия в определенный момент времени жизненного цикла контейнера.

- `PostStart` - выполняется сразу после создания контейнера, например, для инициализации БД или регистрации сервиса в сторонних системах. Хук не гарантирует, что выполнится до того, как сработает `ENTRYPOINT` контейнера. Если хук завершится с ошибкой, контейнер будет перезапущен.
- `PreStop` - выполняется непосредственно перед тем, как контейнеру будет отправлен сигнал завершения `SIGTERM`, например, при масштабировании вниз или обновлении для сохранения данных на диск, завершения активных HTTP-запросов или закрытия сетевых соединений. Если хук зависнет, Kubernetes подождет время, указанное в `terminationGracePeriodSeconds` (по умолчанию 30 секунд) и только потом принудительно убьет процесс. 

```yaml
spec:
  terminationGracePeriodSeconds: 60 
  containers:
  - name: nginx
    image: nginx:1.28-alpine
    lifecycle:
      postStart:
        # Отправка GET-запроса на указанный endpoint приложения
        httpGet:
          path: /init
          port: 80
          scheme: HTTP
      preStop:
        # Запуск указанной команды внутри контейнера
        exec:
          command: ["/usr/sbin/nginx", "-s", "quit"]
```

### Strategy Update

Стратегии обновления приложения:

- `Recreate` (пересоздание)- агрессивная стратегия с простоем. Kubernetes сначала убивает все старые поды, и только когда они полностью удалены, начинает запускать новые (гарантирует, что две разные версии приложения не будут работать одновременно).
- `RollingUpdate` (плавное обновление) - стратегия, при которой Kubernetes постепенно заменяет старые поды на новые. Он запускает новую версию, ждет, пока она станет готова (пройдет `readinessProbe`), и только потом убивает старую. Регулируется параметрами `maxSurge` (сколько лишних подов создать) и `maxUnavailable` (сколько старых можно убить разом).

```yaml
spec:
  replicas: 2
  revisionHistoryLimit: 5
  strategy:
    # type: Recreate 
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 50%           # 50% от 2 = 1 дополнительный под за раз (будет 3 в моменте, без учета maxUnavailable)
      maxUnavailable: 50%     # 50% от 2 = 1 под можно убить сразу (останется 1 старый рабочий)
```

- `Blue-Green` - внешняя стратегия, когда запускается копию новой версии рядом со старой (ужно иметь два отдельных манифеста `Deployment` с разными `label`), после проверки, производится переключение траффика в `Service` или `Ingress` на новые поды.

Ограничивает трафик селектором для подов в Deployment с меткой `color: blue`:

```yaml
kind: Service
metadata:
  name: app-service
spec:
  selector:
    app: app
    color: blue
```

После запуска копии нового приложения в поде с меткой `color: green` и проверки работы (например, через временный порт или логи), переключаем цвет в сервисе:

```bash
kubectl patch service app-service -p '{"spec":{"selector":{"color":"green"}}}'
```

- `Canary` (канареечный деплой) - стратегия на стороне `Istio` через `VirtualService` и `DestinationRule`, при которой ограничивается количество трафика (например, 10%) на новую версию, чтобы проверить ее на реальных пользователях, прежде чем обновлять все остальное.

```yaml
kind: DestinationRule
metadata:
  name: app-dr
spec:
  host: app-service
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
```

Разделяем трафик на сервис по `subset` с помощью весов:

```yaml
kind: VirtualService
metadata:
  name: app-vs-canary
spec:
  hosts:
  - app-service
  http:
  - route:
    - destination:
        host: app-service
        subset: v1
      weight: 90 # 90% трафика на старую версию
    - destination:
        host: app-service
        subset: v2
      weight: 10 # 10% трафика на новую версию (канарейку)
```

### Tolerations

[Taints и Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration) - правила отвержения подов самой нодой.

Отобразить заданные `taint` на всех нодах:

`kubectl get nodes -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints[*].effect`

Доступные эффекты для `taint`:

- `NoSchedule` - планировщик (`kube-scheduler`) не будет рассматривать ноду для запуска новых подов, если у них нет подходящего `Toleration`.
- `PreferNoSchedule` - мягкое условие `NoSchedule`, если во всем кластере другие ноды не подходят по ресурсам, поды будут запущены на этой ноде.
- `NoExecute` - жесткое правило `NoSchedule`, которое при установки метки `taint` заставляет сразу удалить поды без `Toleration` и попытается перезапустить их на других нодах.

Создание метки `taint` на поде в формате `<Key>:<Value>:<Effect>`:

`kubectl taint nodes node-02 nodeType=backup:NoSchedule`

На ноде с указанной меткой без правила `Toleration` никогда не будут запускаться новые поды.

Добавление `Toleration` в манифест пода:

```yaml
spec:
  tolerations:
    - key: "key"
      operator: "Equal"
      value: "backup"
      effect: "NoSchedule"
    # Разрешить запуск на master нодах
    - key: "node-role.kubernetes.io/control-plane"
      operator: "Exists"
      effect: "NoSchedule"
```

Добавить `tolerations` в деплоймент:

```bash
kubectl patch deployment torapi --type='json' -p='[
  {"op": "add", "path": "/spec/template/spec/tolerations", "value": [
    {"key": "node-role.kubernetes.io/control-plane", "operator": "Exists", "effect": "NoSchedule"}
  ]}
]'
```

### Affinity

[Affinity и Anti Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) - это правила для привязки пода к нодам, которые настраиваются через шаблон подов в `Deployment`.

Доступные параметры для определения типа правил:

- `requiredDuringSchedulingIgnoredDuringExecution` - обязательное условие. Если подходящей ноды нет, то под не запустится (будет в статусе `Pending`)
- `preferredDuringSchedulingIgnoredDuringExecution` - желательное условие, которое работает по принципу бальной системы, суммируя вес (`weight`) всех меток на нодах.

Доступные операторы в `matchExpressions` для проверки условий (фильтрация лейблов):

- `In` - значение лейбла (указанное в values) на ноде должно быть одним из списка
- `NotIn` - значение лейбла не должно входить в список (для исключения нод)
- `Exists` - проверяет только наличие ключа (список values не указывается)
- `DoesNotExist` - проверяет отсутствие ключа
- `Gt` - значение лейбла должно быть больше (только для числовых значений)
- `Lt` - значение лейбла должно быть меньше

#### Node Affinity

`nodeAffinity` - определяют правила притяжения подов к нодам.

```yaml
spec:
  affinity:
    nodeAffinity:
      # Обязательное условие (Hard)
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
            - key: diskType
              operator: In
              values: 
                - "ssd"
            - key: diskType
              operator: NotIn
              values: 
                - "hdd"
            - key: cpuCount
              operator: Gt
              values: 
                - "7"
      # Желательное условие (Soft) с весами
      preferredDuringSchedulingIgnoredDuringExecution:
      - preference:
          matchExpressions:
            - key: kubernetes.io/arch
              operator: In
              values:
                - arm64
        weight: 50
```

#### Pod Anti Affinity

`podAntiAffinity` - определяют правила отвержения (обратное условию `nodeAffinity`), например, чтобы две копии одного приложения не запускались на одной ноде.

```yaml
spec:
  affinity:
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
        - labelSelector:
            matchExpressions:
              - key: app
                operator: In
                values:
                  - torapi
          topologyKey: "kubernetes.io/hostname"
        weight: 100
```

### Pod Topology Spread

[Pod Topology Spread Constraints](https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints) (`TSC`) - это механизм, который позволяет гибко и равномерно распределять поды по разным нодам в кластере или любым другим логическим группам (например, не размещать на одном хосте или зонам доступности).

В отличие от `podAntiAffinity`, который работает по принципу либо разрешить, либо запретить, `topologySpreadConstraints` фокусируется на балансе. Планировщик (`kube-scheduler`) при размещении нового пода считает количество уже запущенных подов в каждой логической группе по лейблу и выбирает ту, где размещение пода не нарушит значение `maxSkew`.

Как и `affinity`, настройка определяется на уровне спецификации шаблона пода:

```yaml
spec:
  topologySpreadConstraints:
    # Максимально допустимая разница в количестве подов
    - maxSkew: 1
      # Метка на ноде, по которому определяются границы
      topologyKey: kubernetes.io/hostname
      # Что делать, если идеальное распределение невозможно
      # Soft (все равно запланировать под, стараясь соблюсти баланс)
      whenUnsatisfiable: ScheduleAnyway
      # Hard (оставить под в статусе Pending, пока не появится подходящая пода)
      # whenUnsatisfiable: DoNotSchedule
      labelSelector:
        matchLabels:
          app: torapi
```

### Pod Disruption Budget

[Pod Disruption Budget](https://kubernetes.io/docs/tasks/run-application/configure-pdb) (`PDB`) - гарантирует, что если будут выводиться ноды на обслуживание (с помощью команды `kubectl drain`), поды на ноде не будут удалены, пока количество подов, указанных в `minAvailable` не будет запущены на всех доступных нодах.

Если в кластере 2 ноды и всего 2 реплики по 1 на каждой ноде, процесс `drain` зависнет, поэтому нужно сначала вывести ноду в состояние `kubectl cordon`, увеличить количество реплик до трех `kubectl scale deployment torapi --replicas=3` на оставшихся доступных нодах и уже после этого запустить `kubectl drain`.

```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: rest-api-pdb
  namespace: rest-api
spec:
  # Минимум доступных подов (число или процент)
  minAvailable: 2
  # Привяка к подам (должно совпадать с label в Deployment)
  selector:
    matchLabels:
      app: torapi
      # pdbGroup: high-priority
```

`kubectl apply -f ./pdb.yaml --namespace=rest-api`

`kubectl get pdb --namespace=rest-api` список всех `PDB` и их текущий статус

`kubectl describe pdb rest-api-pdb --namespace=rest-api` - отобразить, какие поды попадают под селектор

### Pod Priority Class

[Pod PriorityClass](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption) (`PC`) - это глобальный объект (не привязанный к `namespace`), который сообщает планировщику Kubernetes, какие поды важнее для запуска. Если в кластере закончатся ресурсы, будут удалены менее важные поды (с самым низким приоритетом), чтобы запустить более приоритетные.

```yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority-apps
# Чем выше число, тем выше приоритет
value: 1000000
# Если true, этот приоритет будет у всех подов без указанного класса
globalDefault: false
# Разрешает вытеснять поды с меньшим приоритетом
preemptionPolicy: PreemptLowerPriority
```

Чтобы под получил приоритет, нужно добавить параметр `spec.template.spec.priorityClassName` в `Deployment`:

```yaml
# Спецификация Deployment
spec:
  # Шаблон пода, которым управляет Deployment
  template:
    # Спецификация пода
    spec:
      priorityClassName: high-priority-apps
```

`kubectl apply -f ./priority.yaml`

`kubectl get priorityclass` или `kubectl get pc` вывести список всех доступных классов приоритета в кластере

`kubectl describe priorityclass high-priority-apps` посмотреть описание и числовое значение выбранного класса

`kubectl get pods -A -o custom-columns=NAME:.metadata.name,PRIORITY:.spec.priorityClassName` отобразить назначенные классы приоритета для всех подов в кластере

### StatefulSet

[StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset) (`STS`) используется для приложений, которым необходимо сохранять свое состояние и уникальность.

Основные приемущества `StatefulSet`:

- Поддерживает уникальное и статическое имя в формате `[metadata.name]-[replica_number]` и имеет строгий порядок запуска (от 0 и по возрастанию). Если под `pg-0` упал и поднялся на другой ноде, он все равно получит имя `pg-0`, поэтому другие сервисы всегда знают, по какому адресу его искать.
- `Headless Service` - это специальный тип сервиса, у которого отсутствует виртуальный IP-адрес (`spec.clusterIP: None`), который требуется для работы `StatefulSet` и позволяет обращаться напрямую к конкретной реплике пода по `DNS` имени, например, `pg-0.pg-svc` будет вести строго на под с именем `pg-0`.
- `Volume Claim Templates` - для каждой новой реплики пода автоматически создает отдельный запрос на диск (`PVC`), и если под переедет на новую ноду, его диск с данными переедет вместе с ним.

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  # Имя объекта в кластере (от него будут строиться имена подов в формате pg-0)
  name: pg
spec:
  # Имя Headless Service, с помощью которого поды получат стабильные DNS-имена в формате pg-0.pg-svc
  serviceName: "pg-svc" 
  replicas: 1
  # Разрешить параллельный запуск с сохранением имени (не дожидаясь очередности запуска)
  # podManagementPolicy: Parallel
  # Привязка подов (должно строго совпадать с labels в секции template)
  selector:
    matchLabels:
      app: pg
  template:
    metadata:
      # Метки, по которым selector ищет свои поды
      labels:
        app: pg
    spec:
      containers:
      - name: pg
        image: postgres:15
        ports:
        - containerPort: 5432
          # Имя позволяет сервису обращаться к порту по имени, а не по номеру
          name: db-port
        env:
        - name: PGPORT 
          value: "5432"
        - name: POSTGRES_PASSWORD
          value: "SecretPassword"
        # Определить путь, куда внутри контейнера подключить постоянное хранилище
        volumeMounts:
        # Должен совпадать с именем, указанным в volumeClaimTemplates.metadata.name
        - name: pg_data
          mountPath: /var/lib/postgresql/data

  volumeClaimTemplates:
  - metadata:
      # Имя шаблона, на которое ссылается volumeMounts
      name: pg_data
    spec:
      # Режим ReadWriteOnce, где диск может быть подключен только к одному поду одновременно
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 50Gi
```

Вывести список всех `StatefulSet` (набор команд идентичен `Deployment`):

`kubectl get sts`

### Headless Service

Главное отличие `Headless Service` от обычного `Service` заключается в отсутствие виртуального IP-адреса (`ClusterIP: none`).

Конфигурация `Headless Service` для прямой связи с подом по имени:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: pg-svc
spec:
  clusterIP: None
  selector:
    app: pg
  ports:
      # Внешний порт сервиса
    - port: 5432
      # Ссылаемся на порта в контейнере по его имени
      targetPort: db-port
```

### DaemonSet

[DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) (`DS`) используется для запуска приложений для взаимодействия с ресурсами `node`. Он гарантирует, что запустит количество подов, равное количесту воркер нод (отсутствует параметр `replicas`), в случае добавления новых рабочих серверов в кластер, `DaemonSet` автоматически обнаружит их и поднимит на них свои поды.

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd-logs
  labels:
    app: fluentd
spec:
  selector:
    matchLabels:
      app: fluentd
  template:
    metadata:
      labels:
        app: fluentd
    spec:
      containers:
      - name: fluentd
        image: fluentd:latest
        # Пробрасываем директорию с логами внутрь контейнера
        volumeMounts:
        - name: varlog
          mountPath: /var/log
      volumes:
      - name: varlog
        # Путь на физическом узле (ноде)
        hostPath:
          path: /var/log
```

Вывести список всех `DaemonSet` (набор команд идентичен `Deployment`):

`kubectl get ds`

### Job

[Job](https://kubernetes.io/docs/concepts/workloads/controllers/job) используются для единовременного выполнения скриптов без дальнейше работы приложения, (пример, при миграции баз данных, когда добавляет новое поле в существующей таблице с помощью SQL-скрипта или кода на языке фреймворка). Задача создает один или несколько подов, и будет продолжать попытки выполнения кода до тех пор, пока указанное количество из них не завершится успешно. По мере успешного завершения подов, задача отслеживает эти завершения и когда достигается указанное количество успешных завершений, все задачи завершаеются (удаление задачи приведет к очистке созданных ею подов).

Если при обновление приложения, нужно добавить новую колонку в таблицу БД, это нельзя делать внутри обычного `Deployment`, т.к. если будет запущено 5 подов, они все одновременно попытаются применить одну и ту же миграцию и сломают базу.

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: db-migrate
spec:
  # Cколько раз требуется успешно выполнить задачу
  completions: 1
  # Сколько подов могут работать над этой задачей одновременно
  parallelism: 1
  # Сколько раз пытаться перезапустить под, если скрипт упал с ошибкой (Fail -> Retry)
  backoffLimit: 3
  # Лимит на выполнение в секундах до завершения поды (включая время на скачивание образа и все попытки перезапуска в backoffLimit)
  activeDeadlineSeconds: 600
  # Удалить Job и созданные им поды через 1 минуту после успешного завершения
  ttlSecondsAfterFinished: 60
  template:
    spec:
      containers:
      - name: migrate-container
        # Используем тот же образ, что и для основного приложения
        image: app:0.2.0
        # Переопределяем команду запуска
        command: ["/bin/sh", "-c"]
        args: ["python /app/manage.py migrate --noinput"]
        # Передача переменных окружения
        env:
          - name: DB_HOST
            value: "pg-0.pg-svc"
          # Передача переменной окружения DB_PASSWORD из Secret в приложение
          - name: DB_PASSWORD
            valueFrom:
              secretKeyRef:
                # Имя объекта Secret
                name: pg-creds
                # Название ключа внутри Secret
                key: PASSWORD
        # Загрузить все ключи из Secret как переменные окружения
        # envFrom:
        #   - secretRef:
        #       name: pg-creds
      # Если скрипт упал с ошибкой, будет перезапущен тот же Pod
      restartPolicy: OnFailure
      # Если скрипт упал, будет перезапущена новая пода до достижения backoffLimit
      # restartPolicy: Never
```

`kubectl apply -f db-migrate-job.yaml`

Нельзя запустить одну и ту же `Job` второй раз с тем же именем. Чтобы повторить миграцию, нужно либо удалить старую с помощью `kubectl delete job db-migrate` и создать ее заново, либо использовать `replace`:

`kubectl get job db-migrate -o yaml | kubectl replace --force -f -`

```bash
# Отобразить список всех задач
kubectl get jobs
# получить подробную информацию о работе, включая Events
kubectl describe job db-migrate
# Список подов, созданных этой задачей
kubectl get pods --selector=job-name=db-migrate
# Отобразить логи задачи
kubectl logs job/db-migrate
```

### Cron Job

Чтобы превратить `Job` в [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs), нужно добавить расписание, а все содержимое задачи из блока `spec` перенести в `spec.jobTemplate.spec`:

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: db-migrate-daily
spec:
  # Расписание в формате Unix-cron (минута час день месяц день-недели)
  schedule: "0 0 * * *"
  # Что делать, если предыдущая задача еще не завершилась
  # Разрешает параллельный запуск (по умолчанию)
  # concurrencyPolicy: Allow
  # Строго запрещает параллельный запуск
  concurrencyPolicy: Forbid
  # Завершает текущую работающую задачу и запускает новую вместо нее
  # concurrencyPolicy: Replace
  # Сколько успешных/проваленных запусков хранить в истории
  successfulJobsHistoryLimit: 3
  failedJobsHistoryLimit: 1
  jobTemplate:
    spec:
```

Запустить задачу, не дожидаясь ее времени запуска:

`kubectl create job --from=cronjob/db-migrate-daily db-migrate-manual-run`

### Init Containers

[Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers) - это контейнеры, которые запускаются перед запуском рабочих контейнеров, например, для проверки доступности файла с секретами, который должен быть доступен на основном контейнере.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app
  template:
    metadata:
      labels:
        app: app
      annotations:
        vault.hashicorp.com/agent-limits-cpu: 200m
        vault.hashicorp.com/agent-limits-mem: 128Mi
        vault.hashicorp.com/agent-requests-cpu: 100m
        vault.hashicorp.com/agent-requests-mem: 64Mi
        vault.hashicorp.com/agent-inject: 'true'
        vault.hashicorp.com/agent-init-first: 'false'
        vault.hashicorp.com/agent-pre-populate: 'false'
        vault.hashicorp.com/log-level: debug
        vault.hashicorp.com/namespace: main
        vault.hashicorp.com/role: vault-role
        vault.hashicorp.com/agent-inject-secret-envs: main/A/app/KV/app-env
    spec:
      initContainers:
      - name: wait-vault-secrets
        image: busybox:1.36
        volumeMounts:
        - name: vault-secrets
          mountPath: /vault/secrets
        command: ["sh", "-c"]
        args:
          - |
            counter=0
            while [ ! -s /vault/secrets/envs ]; do
              sleep 1
              counter=$(( counter + 1 ))
              echo "Waiting secrets $counter sec"
            done
            echo "Vault is ready"
      containers:
      - name: app
        image: app:latest
        command: ["sh", "-c", "export $(cat /vault/secrets/envs | sed 's/\:\ /=/g' | xargs) && ./app"]
        volumeMounts:
        - name: vault-secrets
          mountPath: /vault/secrets
      volumes:
        - name: vault-secrets
          configMap:
            name: secman-export-env
            items:
              - key: envs
                path: envs
```

### Image Pull Secrets

[Pull Image Private Registry](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry) используется для загрузки образ из частного реестра образов контейнеров.

Создаем секрет:

```bash
# kubectl create secret docker-registry "image-pull-nexus" \
#     --docker-server="$nexusUrl" \
#     --docker-username="$nexusUser" \
#     --docker-password="$nexusPass" \
#     --dry-run=client -o yaml | kubectl apply -f -

# Создаем секрет вручную с доступом в несколько репозиториев
AUTH_BASE64=$(echo -n "$nexusUser:$nexusPass" | base64 -w 0)
kubectl create secret generic "$secretName" \
    --type=kubernetes.io/dockerconfigjson \
    --from-literal=.dockerconfigjson="{
        \"auths\":{
            \"$nexusUrl_01\":{\"auth\":\"$AUTH_BASE64\"},
            \"$nexusUrl_02\":{\"auth\":\"$AUTH_BASE64\"}
        }
    }" \
    --dry-run=client -o yaml | kubectl apply -f -

# Обновляем imagePullSecrets для SA
kubectl patch serviceaccount nexus -p "{
    \"imagePullSecrets\": [{
        \"name\": \"$secretName\"
    }]
}"
```

Подключаем к контейнеру токен доступа:

```yaml
spec:
  # Назначем SA для всех контейнеров с привязанным imagePullSecrets
  serviceAccountName: nexus
  containers:
    - name: vm-agent
      image: nexusUrl/image:version
      imagePullPolicy: IfNotPresent
      # Вручную прописываем imagePullSecrets для контейнера (вместо SA)
      imagePullSecrets:
        - name: image-pull-nexus
```

### ConfigMap

[ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap) - это объект для хранения неконфиденциальных данных.

Существует 3 варианта объявления значений в конфигурации:

- Переменные окружения в формате: `key: value`
- Cодержимое многострочных файлов
- Бинарные данные для картиновк или сертификатов в формате `Base64`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
data:
  PORT: 80
  config: |
    server {
        listen 80;
        server_name localhost;
    }
binaryData:
  favicon.ico: iVBORw0KGgoAAAANSUhEUgAA...
```

Работа с конфигурациями:

```bash
# Создать ConfigMap с данными из файла
kubectl create cm event-exporter-config --from-file=config.yaml
# Изменить конфигурацию
kubectl edit cm event-exporter-config
# Получить список всех ConfigMap, количество данных и дату их создания
kubectl get cm
# Отобразить содержимое ConfigMap (на примере корневого сертифика)
kubectl get cm kube-root-ca.crt -o yaml
# Вывести метаданные (лейблы и аннотации манифеста)
kubectl describe cm kube-root-ca.crt
# Выведет только содержимое ключа ca.crt
kubectl get cm kube-root-ca.crt -o jsonpath='{.data.ca\.crt}'
```

### Secrets

[Secrets](https://kubernetes.io/docs/concepts/configuration/secret) - это объект для хранения конфиденциальных данных, таких как пароли, токены или ключи.

Секреты принято хранить в формате `Base64`:

```bash
echo -n "123456789:TOKEN" | base64
echo -n "-7777777777" | base64
```

Формат передачи данных аналогичен `ConfigMap`:

```yaml
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: telegram-secrets
  namespace: monitoring
data:
  TELEGRAM-API-KEY: MTIzNDU2Nzg5OlRPS0VO
  TELEGRAM-CHAT-ID: LTc3Nzc3Nzc3Nzc=
```

`kubectl apply -f telegram-secrets.yaml`

```bash
# Создать секрет в формате ключ-значение
kubectl create secret generic admin-password --from-literal=username=admin --from-literal=password=pass
# Создать секрет из содержимого файла
kubectl create secret generic api-key --from-file=api-key.txt
# Получить список всех секретов
kubectl get secret
# Получить информацию о секрете (размер в байтах)
kubectl describe secret admin-password
# Получить содержимое секретов в кодировке base64
kubectl get secret admin-password -o yaml
# Декодировать содержимое секрета
kubectl get secret admin-password -o jsonpath="{.data.password}" | base64 --decode
# Удалить секрет
kubectl delete secret admin-password
```

### RBAC

[ServiceAccount](https://kubernetes.io/docs/concepts/security/service-accounts) - это УЗ, с помощью которой поды приложений могут использовать для идентификации себя от ее имени на внешних ресурсах, так и внутри самого кластера.

Пример создания `ServiceAccount` (который подключается в спецификации пода через `spec.serviceAccountName`) для доступа к событиям кластера.

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: event-exporter-sa
  namespace: monitoring
```

Создаем кастомные права доступа на уровне кластера:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: event-exporter-role
rules:
- apiGroups: ["*"]
  # Даем доступ ко всем типам ресурсов (поды, ноды, сервисы и т.д.)
  resources: ["*"]
  # Доступ только на чтение и наблюдение в реальном времени
  verbs: ["get", "watch", "list"]
```

Привязка прав доступа `ClusterRole` к `ServiceAccount`:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: event-exporter
# Какие права
roleRef:
  kind: ClusterRole
  apiGroup: rbac.authorization.k8s.io
  name: event-exporter-role
# Для кого
subjects:
  - kind: ServiceAccount
    namespace: monitoring
    name: event-exporter-sa
```

Пример создания `SA` с полными правами доступа:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: devops-sa
  namespace: monitoring
```

Привязываем кластерные права `admin` к `SA`:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: admin-rb
  namespace: monitoring
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: admin
subjects:
- kind: ServiceAccount
  name: devops-sa
  namespace: monitoring
```

Создаем секрет с токеном доступа для `SA`, который можно использовать в `kubeconfig` для подключения к кластеру:

```yaml
apiVersion: v1
kind: Secret
type: kubernetes.io/service-account-token
metadata:
  name: devops-token
  namespace: monitoring
  annotations:
    kubernetes.io/service-account.name: devops-sa
```

`kubectl get secret cross-devops -n monitoring -o jsonpath='{.data.token}' | base64 --decode` извлечь содержимое токена

### Events

[Events](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_events) - это записи в API, описывающие изменения состояния объектов (нодов, подов, деплойментов, сервисов и т.д.) и ошибки, которые помогают понять, почему приложение не запускается (например, нехватка ресурсов). Все события автоматически удаляются из базы данных `etcd` через 1 час.

```bash
# Вывести события для всех объектов в текущем пространстве имен
kubectl get events
# Сортировка событий по времени
kubectl get events --sort-by='.lastTimestamp'
# Фильтрация событий по типу события
kubectl get events --field-selector type=Warning
# Фильтрация событий по типу объекта (для всех подов)
kubectl get events --field-selector involvedObject.kind=Pod
```

### Event Exporter

События в кластере принято собирать с помощью экспортера и отправлять во внешние системы для хранения и анализа.

Пример конфигурации [kubernetes-event-exporter](https://github.com/resmoio/kubernetes-event-exporter) для настройки чтения всех событий в кластере Kubernetes и вывода в `stdout` запущенного пода (лог контейнера) или путем отправки уведомлений в Telegram через Web Hook.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: event-exporter-config
  namespace: monitoring
data:
  config.yaml: |
    route:
      routes:
        - match:
            - receiver: "dump"
        - match:
            - receiver: "telegram"
              # Фильтрация по типу события, ресурса или namespace 
              type: "Warning"
              # kind: "Deployment"
              # namespace: "dev"
    receivers:
      - name: dump
        # Перенаправлять в лог контейнера
        stdout: {}
      - name: telegram
        webhook:
          endpoint: "https://api.telegram.org/bot{{ env "TELEGRAM_API_KEY" }}/sendMessage"
          headers:
            Content-Type: "application/json"
          layout:
            chat_id: "{{ env "TELEGRAM_CHAT_ID" }}"
            parse_mode: "HTML"
            text: |
              <b>⚠ [K8s Warning Event]</b>
              <b>Object:</b> {{ .InvolvedObject.Kind }}/{{ .InvolvedObject.Name }}
              <b>Namespace:</b> {{ .InvolvedObject.Namespace }}
              <b>Reason:</b> {{ .Reason }}
              <b>Message:</b> {{ .Message }}
```

Подключение содержимого конфигурации из `ConfigMap` и переменных окружения из `Secret` в `Deployment` для контейнера внутри пода:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: event-exporter
  namespace: monitoring
spec:
  replicas: 1
  selector:
    matchLabels:
      app: event-exporter
  template:
    metadata:
      labels:
        app: event-exporter
      # annotations:
      #   prometheus.io/scrape: 'true'
      #   prometheus.io/port: '2112'
      #   prometheus.io/path: '/metrics'
    spec:
      serviceAccountName: event-exporter-sa
      containers:
        - name: event-exporter
          image: ghcr.io/resmoio/kubernetes-event-exporter:latest
          imagePullPolicy: IfNotPresent
          env:
            - name: TELEGRAM_API_KEY
              valueFrom:
                secretKeyRef:
                  name: telegram-secret
                  key: TELEGRAM-API-KEY
            - name: TELEGRAM_CHAT_ID
              valueFrom:
                secretKeyRef:
                  name: telegram-secret
                  key: TELEGRAM-CHAT-ID
          args:
            - -conf=/data/config.yaml
          volumeMounts:
            - mountPath: /data
              name: config
      volumes:
        - name: config
          configMap:
            name: event-exporter-config
```

### Shell Operator

[Shell Operator](https://github.com/flant/shell-operator) - это инструмент для запуска bash-скриптов, которые оперируют событиями в кластере Kubernetes.

Пример скрипта для отправки системных событий в Telegram:

```bash
if [[ $1 == "--config" ]] ; then
    cat <<EOF
configVersion: v1
kubernetes:
- apiVersion: v1
  kind: Event
  executeHookOnEvent: ["Added"]
EOF
else
    SHELL_TYPE=$(cat "$BINDING_CONTEXT_PATH" | jq -r .[0].type)
    if [[ "$SHELL_TYPE" == "Added" ]]; then
        KIND=$(cat "$BINDING_CONTEXT_PATH" | jq -r .[0].object.kind)
        case "$KIND" in
            "Event")
                EVENT_TYPE=$(jq -r '.[0].object.type' "$BINDING_CONTEXT_PATH")
                if [[ "$EVENT_TYPE" == "Warning" ]]; then
                    REASON=$(cat "$BINDING_CONTEXT_PATH" | jq -r '.[0].object.reason')
                    MESSAGE=$(cat "$BINDING_CONTEXT_PATH" | jq -r '.[0].object.message')
                    OBJECT_KIND=$(cat "$BINDING_CONTEXT_PATH" | jq -r '.[0].object.involvedObject.kind')
                    OBJECT_NAME=$(cat "$BINDING_CONTEXT_PATH" | jq -r '.[0].object.involvedObject.name')
                    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_API_KEY/sendMessage" \
                        -d "chat_id=$TELEGRAM_CHAT_ID_DEFAULT" \
                        -d "text=⚠ [K8s Warning Event]\n\n*Object:* $OBJECT_KIND/$OBJECT_NAME\n*Reason:* $REASON\n*Message:* $MESSAGE" \
                        -d "parse_mode=markdown"
                fi
            ;;
        esac
    fi
fi
```

Собираем контейнер:

```Dockerfile
FROM flant/shell-operator:latest

COPY notify-operator.sh /hooks/handler.sh

RUN chmod +x /hooks/handler.sh
```

Запускаем оператор в кластере для отслеживания системных событий:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: event-operator
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: event-operator
  template:
    metadata:
      labels:
        app: event-operator
    spec:
      # SA с правами выполнения kubectl get events
      serviceAccountName: event-exporter-sa
      containers:
      - name: operator
        image: lifailon/event-operator:v1
        # Прокидываем переменные окружения из секрета в контейнер
        env:
        - name: TELEGRAM_API_KEY
          valueFrom:
            secretKeyRef:
              name: telegram-secrets
              key: TELEGRAM-API-KEY
        - name: TELEGRAM_CHAT_ID_DEFAULT
          valueFrom:
            secretKeyRef:
              name: telegram-secrets
              key: TELEGRAM-CHAT-ID
```

### Persistent Volume

Настройка `NFS` сервера для удаленного хранения данных:

```bash
# Установка NFS сервера
sudo apt update && sudo apt install nfs-kernel-server -y
# Создание директории
sudo mkdir -p /mnt/k8s_data
sudo chown nobody:nogroup /mnt/k8s_data
sudo chmod 777 /mnt/k8s_data
# Шарим директорию для всех *, указанной подсети 192.168.3.0/24 или конкретного IP-адреса
echo "/mnt/k8s_data *(rw,sync,no_root_squash)" | sudo tee -a /etc/exports
# Применение настроек
sudo exportfs -ra
sudo systemctl enable nfs-kernel-server
sudo systemctl restart nfs-kernel-server
# Установка NFS клиента на всех узлах Kubernetes
sudo apt install nfs-common -y
```

[Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes) (`PV`) - это объект для настройки ручного подключения хранилища в кластер.

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    server: 192.168.3.101
    path: /mnt/k8s_data
    readOnly: false
```

`kubectl apply -f nfs-pv.yaml`

`kubectl get pv`

### Persistent Volume Claim

`PersistentVolumeClaim` (`PVC`) - это запрос пользователя на хранилище данных (`PV`), который позволяет монтировать в поды и использовать ресурсы настроенного `PersistentVolume`. Для одного настроенного `PV` может быть привязан только один `PVC`.

Создание `PersistentVolumeClaim`:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs-pvc
spec:
  # Название вручную настроенного хранилища PersistentVolume
  volumeName: nfs-pv
  accessModes:
    - ReadWriteMany   # Подключен к многим нодам в режиме чтения-записи
    # - ReadWriteOnce # Подключен только к одной поде в режиме чтения-записи
    # - ReadOnlyMany  # Подключен к многим нодам в режиме только на чтение
  resources:
    requests:
      storage: 5Gi
```

`kubectl apply -f nfs-pvc.yaml`

`kubectl get pvc`

Подключение хранилища к поду:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: postgres:15
          ports:
            - containerPort: 5432
          env:
            - name: POSTGRES_PASSWORD
              value: "SecretPassword"
            - name: PGDATA
              value: "/var/lib/postgresql/data/pgdata"
          volumeMounts:
            - name: pg_data
              mountPath: /var/lib/postgresql/data
      volumes:
        - name: pg_data
          persistentVolumeClaim:
            claimName: nfs-pvc
```

### Storage Class

[Storage Class](https://kubernetes.io/docs/concepts/storage/storage-classes) (`SC`) - это объект для автоматического создания хранилищ `PV` в кластере при каждом новом запросе `PVC`.

[NFS subdir external provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner) - это инструмент для автоматизации создания постоянных томов `PV` и директории под новые `PV` в формате `${namespace}-${pvcName}-${pvName}` на уже существующем и настроенном NFS-сервере.

```bash
helm install nfs-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set storageClass.create=false
    # --set nfs.server=192.168.3.101 \
    # --set nfs.path=/mnt/k8s_data \
    # --set storageClass.name=nfs-sc
```

Создать `Storage Class`:

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: nfs-sc
# Совпадает с ENV в Deployment
provisioner: k8s-sigs.io/nfs-subdir-external-provisioner
# При удаление PVC (kubectl delete pvc), объект PV и данные на NFS сервере будут сохранены
reclaimPolicy: Retain
# Создать архивную папку на сервере при удаление PVC (если reclaimPolicy: Delete)
parameters:
  archiveOnDelete: "true" 
```

`kubectl apply nfs-sc.yaml`

`kubectl get storageclass`

Выпоняем запрос постоянного тома из `nfs-sc`:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs-pvc
spec:
  storageClassName: nfs-sc
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 5Gi
```

[CSI Driver SMB](https://github.com/kubernetes-csi/csi-driver-smb) - это драйвер, который поддерживает динамическое выделение постоянных томов (`PV`) с помощью запросов на постоянные тома (`PVC`) путем создания нового подкаталога на уже существующем и настроенном SMB-сервере.

```bash
helm repo add csi-driver-smb https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts
helm install csi-driver-smb csi-driver-smb/csi-driver-smb --namespace kube-system --version 1.20.1

kubectl create secret generic smb-secret --from-literal username=USERNAME --from-literal password="PASSWORD"
```

Настраиваем подключение к SMB шаре:

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: smb
provisioner: smb.csi.k8s.io
parameters:
  source: //192.168.3.100/k8s-data
  csi.storage.k8s.io/provisioner-secret-name: smb-secret
  csi.storage.k8s.io/provisioner-secret-namespace: default
  csi.storage.k8s.io/node-stage-secret-name: smb-secret
  csi.storage.k8s.io/node-stage-secret-namespace: default
volumeBindingMode: Immediate
allowVolumeExpansion: true
mountOptions:
  - dir_mode=0777
  - file_mode=0777
  - uid=1001
  - gid=1001
```

### HPA

[Horizontal Pod Autoscaling](https://kubernetes.io/docs/concepts/workloads/autoscaling/horizontal-pod-autoscale) (`HPA`) - это механизм горизонтального масштабирования, который позволяет автоматически увеличивать или уменьшать количество реплик (подов) в зависимости от текущей нагрузки по показателям метрик, получаемых из `metrics-server`. Если нагрузка на одну поду увеличивается, то новая реплика должна снять нагрузку с первого пода, тем самым средняя нагрузка на 1 под будет ниже.

Включить автоскейлинг по нагрузке на процессор:

`kubectl autoscale deployment torapi --min=1 --max=3 --cpu-percent=80 `

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: torapi-hpa
  namespace: rest-api
spec:
  # Ссылка на масштабируемый объект (Deployment, StatefulSet или ReplicaSet)
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: torapi      # Имя Deployment, который будем масштабировать
  minReplicas: 1      # Минимальное количество реплик
  maxReplicas: 3      # Максимальное количество реплик
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization       # Значекние в процентах
          averageUtilization: 50  # Когда среднее использование CPU превышает 50%, будет увеличено количество реплик
    - type: Resource
      resource:
        name: memory
        target:
          type: AverageValue      # Точное значение
          averageValue: 500Mi     # Потребление памяти свыше 500 Мбайт
    # Кастомные метрики, например, количество запросов в секунду на Ingress
    # - type: External
    #   external:
    #     metric:
    #       name: nginx_ingress_controller_requests
    #     target:
    #       type: AverageValue
    #       averageValue: 50
  behavior:
    scaleUp:
      stabilizationWindowSeconds: 0     # задержка перед увеличением реплик
      policies:
        - type: Pods                    # Pod или Percent (в процентном соотношение)
          value: 1                      # Добавлять по 1 поду за шаг (100 для Percent удвоит значение подов)
          periodSeconds: 30             # Интервал между шагов в секундах
    scaleDown:
      stabilizationWindowSeconds: 300   # задержка в 5 минут перед уменьшением реплик
```

`kubectl apply -f torapi-hpa.yaml`

```bash
# Отобразить статус работы всех HPA и текущие таргеты (`cpu: 1%/50%`)
kubectl get hpa
# Отобразить статус работы HPA (текущее и тригерное значение для масштабирования)
kubectl describe hpa -n rest-api torapi-hpa
# Отобразить нагрузку на подах по cpu и memory
kubectl top pods -n rest-api
# Получить метрики напрямую из API
kubectl get --raw "/apis/metrics.k8s.io/v1beta1/namespaces/rest-api/pods" | jq .
# Будет активен 1 под из 5 подов (вместо двух, изначально определенных в Deployment)
kubectl get pods
```

Запустить нагрузку на CPU (удобно для проверки срабатывания HPA)

```bash
# Запустить процессы
cpuCount=2
kubectl exec $pod -c $container -- sh -c "for i in \$(seq 1 $cpuCount); do yes $procName > /dev/null 2>&1 & done"

# Получить количество запущенных процессов с нагрузкой
function getPids() {
  kubectl -n $NS exec $podName -c $container -- sh -c "grep -a $procName /proc/[0-9]*/cmdline | grep -av grep |
    awk -F'/proc/' '{split(\$2,a,\"/\");sum=sum\" \"a[1]}END{print sum}'"
}
echo -e "Количество процессов нагрузки на поде $pod - $(getPids)"

# Остановить нагрузку
pids=$(getPids)
kubectl -n $NS exec $podName -c $container -- sh -c '
    PIDs="$1"
    if [ -n "$PIDs" ]; then
        for PID in $PIDs; do
            echo "Остановка процесса: $PID"
            kill -9 "$PID" 2>/dev/null || true
        done
    fi
' -- "$pids"
```

### VPA

[Vertical Pod Autoscaling](https://kubernetes.io/docs/concepts/workloads/autoscaling/vertical-pod-autoscale) (`VPA`) - механизм вертикального автоматического масштабирование позволяет выделять больше ресурсов (памяти или процессорного времени). Для применения нового значения лимитов, требуется перезапуск текущего пода.

```yaml
apiVersion: "autoscaling.k8s.io/v1"
kind: VerticalPodAutoscaler
metadata:
  name: torapi-vpa
spec:
  targetRef:
    apiVersion: "apps/v1"
    kind: Deployment
    name: torapi
  updatePolicy:
    updateMode: "Auto"        # Перезапустит под для обновления лимитов (по умолчанию)
    # updateMode: "Initial"   # Назначает ресурсы только при создании пода (не перезапускает рабочие)
    # updateMode: "Recreate"  # Удаляет и пересоздает под, если нужно изменить ресурсы
    # updateMode: "Off"       # Только рекомендации (ничего не меняет сам)
  resourcePolicy:
    containerPolicies:
      # Применит ко всем контейнерам пода
      - containerName: '*'
        # Какие ресурсы оптимизировать
        controlledResources: ["cpu", "memory"]
        # Минимальные значения, ниже которых VPA не опустит ресурсы
        minAllowed:
          cpu: "100m"
          memory: "128Mi"
        # Максимальные значения, выше которых VPA не поднимет ресурсы
        maxAllowed:
          cpu: "2"
          memory: "4Gi"
        # Какие значения VPA может менять (RequestsAndLimits или только Requests)
        controlledValues: RequestsAndLimits
```

### JSONPath

[JSONPath](https://kubernetes.io/docs/reference/kubectl/jsonpath) - шаблонизатор для фильтрации вывода в командах `kubectl`.

`kubectl get nodes -o=jsonpath='{.items[*].status.addresses[*].address}'` отобразить ip-адреса всех node \
`kubectl config view -o jsonpath='{.users[*].name}'` получить список пользователей в конфигурации \
`kubectl config view -o jsonpath='{.users[?(@.name == "admin")].user.password}'` получить пароль для пользователя admin

| Функция             | Описание                                        | Пример                                                          | Результат                                       |
| -                   | -                                               | -                                                               | -                                               |
| `text`              | обычный текст	                                  | `kind is {.kind}`                                               | kind is List                                    |
| `@`	                | текущий объект	                                | `{@}`	                                                          | то же, что и ввод                               |
| `.` или `[]`        | оператор выбора по ключу	                      | `{.kind}, {['kind']}` или `{['name\.type']}`                    | List                                            |
| `..`	              | рекурсивный спуск	                              | `{..name}`                                                      | 127.0.0.1 127.0.0.2 myself e2e                  |
| `*`	                | шаблон подстановки для получение всех объектов  | `{.items[*].metadata.name}`                                     | [127.0.0.1 127.0.0.2]                           |
| `[start:end:step]`  | оператор индексирования                         | `{.users[0].name}`                                              | myself                                          |
| `[,]`               | оператор объединения                            | `{.items[*]['metadata.name', 'status.capacity']}`               | 127.0.0.1 127.0.0.2 map[cpu:4] map[cpu:8]       |
| `?()`               | фильтрация                                      | `{.users[?(@.name=="e2e")].user.password}`                      | secret                                          |
| `range` и `end`     | перебор списка (цикл)                           | `{range .items[*]}[{.metadata.name}, {.status.capacity}] {end}` | [127.0.0.1, map[cpu:4]] [127.0.0.2, map[cpu:8]] |
| `''`	              | интерпретируемая в кавычках строка              | `{range .items[*]}{.metadata.name}{'\t'}{end}`                  | 127.0.0.1 127.0.0.2                             |

Вывести список подов в формате `nodeName: podeName` используя `JSONPath` и [Go Template](https://pkg.go.dev/text/template):

`kubectl get pods -o jsonpath='{range .items[*]}{.spec.nodeName}{": "}{.metadata.name}{"\n"}{end}'`

`kubectl get pods -o go-template --template '{{range .items}}{{.spec.nodeName}}: {{.metadata.name}}{{"\n"}}{{end}}'`

[Go Template Playground Online](https://repeatit.io)

Пример цикла и условия:

```go
{{ range .Items -}}
    {{ if eq  . "sleep" -}}
        pause
  {{- else -}}
        Go {{ . -}}
    {{ end }}
{{ end }}
```

Для шаблона:

```yaml
Items:
  - start
  - sleep
  - stop
```

## CRD

[Custom Resource Definition](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources) (`CRD`) - это расширение API Kubernetes, которое позволяет создавать собственные типы ресурсов.

### Traefik

`Ingress` - это прокси-сервер, который управляет входящим HTTP-трафиком в кластере и направляет его к нужным внутренним сервисам через единую точку входа, поддерживая балансировку между нодами по имени и маршрутизацию запросов к разным конечным точкам в пути.

#### Ingress Controller

Устанавливаем [Traefik](https://github.com/traefik/traefik) в роле `Ingress Controller`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: traefik
  name: traefik
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: traefik
  template:
    metadata:
      labels:
        app: traefik
    spec:
      # SA с правами доступа
      serviceAccountName: traefik-ingress-controller
      containers:
        - name: traefik
          image: traefik:v3.5.3
          args:
            - --api.dashboard=true
            - --api.insecure=true
            - --entrypoints.web.address=:80
            - --entrypoints.websecure.address=:443
            - --providers.kubernetescrd=true
            # Включить режим работы Ingress
            - --providers.kubernetesingress=true
            # Название класса, которое указывается в Ingress
            - --providers.kubernetesingress.ingressclass=traefik
            - --metrics.prometheus=true
            - --metrics.prometheus.entryPoint=traefik
            - --metrics.prometheus.addEntryPointsLabels=true
            - --metrics.prometheus.addServicesLabels=true
          ports:
            - name: web
              containerPort: 80
              # hostPort: 80
            - name: websecure
              containerPort: 443
              # hostPort: 8443
            - name: admin
              containerPort: 8080
              hostPort: 8888
          livenessProbe:
            httpGet:
              path: /dashboard/
              port: 8080
            initialDelaySeconds: 10
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /dashboard/
              port: 8080
            initialDelaySeconds: 10
            periodSeconds: 10
```

`kubectl apply -f traefik-deployment.yaml`

Установить `RBAC` для Traefik:

```yaml
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v3.6/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml
```

Сервис для доступа к `Ingress` за пределами кластера:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: traefik-service
  namespace: default
  annotations:
    metallb.universe.tf/address-pool: "default-pool"
    metallb.universe.tf/loadBalancerIPs: "192.168.3.200"
spec:
  type: LoadBalancer
  selector:
    app: traefik
  ports:
  - name: web
    port: 80
    protocol: TCP
    targetPort: 80
  - name: websecure
    port: 443
    protocol: TCP
    targetPort: 443
  - name: admin
    port: 8888
    protocol: TCP
    targetPort: 8080
```

Создаем тестовый под и сервис [go-httpbin](https://github.com/mccutchen/go-httpbin):

`kubectl apply -f traefik-service.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpbin
spec:
  replicas: 1
  selector:
    matchLabels:
      app: httpbin
  template:
    metadata:
      labels:
        app: httpbin
    spec:
      containers:
      - name: httpbin
        image: mccutchen/go-httpbin:2.18
        ports:
        - containerPort: 8080
        livenessProbe:
          httpGet:
            path: /status/200
            port: 8080
        readinessProbe:
          httpGet:
            path: /status/200
            port: 8080
```

`kubectl apply -f httpbin-deployment.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: httpbin-service
spec:
  selector:
    app: httpbin
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
```

`kubectl apply -f httpbin-service.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: httpbin
  namespace: default
spec:
  # Указывает, что этот Ingress должен обрабатывать Traefik
  ingressClassName: traefik
  rules:
  - host: httpbin.k8s.local
    # Настройка маршрутизации трафика
    http:
      paths:
      # Входящий endpoint
      - path: /
        # Начинается с (/.+)
        pathType: Prefix
        # Точное совпадение
        # pathType: Exact
        # На какой сервис и порт перенаправлять трафик
        backend:
          service:
            name: httpbin-service
            port:
              number: 80
```

#### Ingress Route

[Traefik CRD](https://doc.traefik.io/traefik/reference/install-configuration/providers/kubernetes/kubernetes-crd) - предоставляет дополнительные пользовательские ресурсы, такие как `IngressRoute` (вместо стандартного `kind: Ingress`), `Middleware` (промежуточный обработчик, например, для добавления авторизации), и другие.

```bash
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v3.6/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml
```

```yaml
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: httpbin
  namespace: default
spec:
  entryPoints:
  - web
  routes:
  - match: Host(`httpbin.k8s.local`)
    kind: Rule
    services:
    - name: httpbin-service
      port: 80
```

#### Middleware

Секрет c кредами для авторизации:

```yaml
# htpasswd -nbB admin admin | base64
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: httpbin-secret
  namespace: default
data:
  users: |
    YWRtaW46JDJ5JDA1JGMwcjVBNlNDS1g0UjZGanVDZ1JxcnVmYklFNXRtWHcyc0RQcTF2Wjh6TnJy
    d05aSUg5amdXCgo=
```

Посредник для проверки авторизации:

```yaml
apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: traefik-auth
  namespace: default
spec:
  basicAuth:
    secret: httpbin-secret
```

Настройка входящего трафика через `Ingress` с поддержкой авторизации:

```yaml
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: httpbin
  namespace: default
spec:
  entryPoints:
  - web
  routes:
  - match: Host(`httpbin.k8s.local`)
    kind: Rule
    services:
    - name: httpbin-service
      port: 80
    middlewares:
      - name: traefik-auth
```

### Istio

[Istio](https://github.com/istio/istio) - это платформа Service Mesh, обеспечивая прозрачную маршрутизацию трафика, повышенную безопасность (`mTLS`) и детальную телеметрию, используя прокси-серверы `Envoy`, развернутые как sidecar-контейнеры.

```mermaid
graph TD
    Internet == Input ==> Ingress[Ingress Gateway]
    Ingress ==> IngressVS[Virtual Service]
    IngressVS ==> Sidecar{Envoy Sidecar}
    Sidecar <==> App([Pod/Container/App])
    EF[[Envoy Filter]] ==> Sidecar
    Sidecar == Output ==> EgressVS[Virtual Service]
    EgressVS ==> SE[Service Entry]
    SE ==> Egress[Egress Gateway]
    Egress ==> DR[Destination Rule]
    DR ==> Internet
```

#### Istioctl

[istioctl](https://istio.io/latest/docs/reference/commands/istioctl) - утилита командной строки для настройки Istio, предназначенная для операторов сервисов, позволяющая отлаживать и диагностировать их сеть Istio.

```bash
# Скачивание последней версии Istio
curl -L https://istio.io/downloadIstio | sh -
cd istio-*
export PATH=$PWD/bin:$PATH

# Установить поды и сервисы для istio-ingressgateway и istio-egressgateway из профиля default
# https://github.com/istio/istio/blob/master/manifests/profiles/default.yaml
istioctl install --set profile=default -y
kubectl get pods -n istio-system

# Установить аддоны для Kiali, Jaeger и Prometheus
# https://github.com/istio/istio/tree/master/samples/addons
kubectl apply -f samples/addons

# При создании любого пода в указанном namespace будет автоматически подселяться прокси-контейнер Envoy
kubectl label namespace default istio-injection=enabled

# Изменить глобальный режим работы c ALLOW_ANY на REGISTRY_ONLY
kubectl edit configmap istio -n istio-system
# Любой исходящий трафик, который не указан в ServiceEntry конфигурациях будет отбрасываться
istioctl upgrade --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY

# Проверить текущую конфигурацию кластера на наличие ошибок (например, VS ссылается на несуществующий GW)
istioctl analyze
# Вывести таблицу статуса (proxy-status) работы всех подов и синхронизации (SYNCED или STALE) с контрольной панелью
istioctl ps
# Вывести маршруты (proxy-config), куда Envoy может слать трафик
istioctl pc route <pod-name>
istioctl pc cluster <pod-name>
# Вывести правила Istio (VS, DR, политики TLS) применяются к конкретному поду
istioctl describe pod <pod-name>
# Веб-интерфейс мониторинга Envoy контейнера (port-forward для 15000 порта)
istioctl dashboard envoy <pod-name>
```

#### Kiali

[Kiali](https://github.com/kiali/kiali) - это графическая панель, которая на основе метрик рисует карту сети в реальном времении и отображает как сервисы связаны друг с другом (стрелочки трафика), где проходят ошибки (красные линии) и объем трафика (`RPS`), а также поддерживает управление ресурсами Istio.

```bash
helm repo add kiali https://kiali.org/helm-charts
helm repo update

helm install \
  --namespace istio-system \
  --set auth.strategy="anonymous" \
  kiali-server \
  kiali/kiali-server

kubectl get pods -n istio-system -l app=kiali
# Пробросить панель через port-forward
istioctl dashboard kiali
# Обновить конфигурация сервиса Kiali для постоянного доступа к его Dashboard
kubectl patch svc kiali -n istio-system -p '{"spec": {"type": "LoadBalancer"}}'
```

#### Gateway

[Gateway](https://istio.io/latest/docs/reference/config/networking/gateway) (`GW`) - определяет правила маршрутизации трафика на транспортном уровне (L4-L6), т.е. на каких портах, по каким протоколам (`HTTP`, `HTTPS`, `TCP`), в каком режиме (`TLS` или `mTLS`) и для каких доменов кластер готов принимать входящий трафик из Интернета.

`mTLS` (Mutual Transport Layer Security) - это метод взаимной аутентификации, при котором клиент и сервер проверяют сертификаты друг друга перед установкой защищенного соединения (в обычном `TLS` только клиент проверяет подлинность сервера). В режиме `MUTUAL`, шлюз отдает сертификат клиенту и требует сертификат у клиента, подписанный твоим `caCertificates`, или запрос будет сброшен еще на входе.

Выпустить сертификаты и создать секрет с их содержимым:

```bash
# Выпускаем корневой сертификат (CA) и ключ
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
  -subj '/CN=ca.k8s.local' \
  -out ca.crt \
  -keyout ca.key

# Выпускаем сертификат для домена (получаем csr - запрос на подпись и приватный ключ)
openssl req -newkey rsa:2048 -nodes \
  -subj "/CN=httpbin.k8s.local" \
  -out httpbin.csr \
  -keyout httpbin.key

# Подписываем сертификат домена в CA и получаем подписанный сертификат
openssl x509 -req -sha256 -days 365 -set_serial 0 \
  -CA ca.crt -CAkey ca.key \
  -in httpbin.csr -out httpbin.crt

# Создаем секрет в кластере с содержимым сертификатов и ключа
kubectl create secret generic httpbin-certs \
  --namespace default \
  --from-file=cert=httpbin.crt \
  --from-file=key=httpbin.key \
  --from-file=cacert=ca.crt
```

Шлюз для приема трафика на внутренних сервисах через `ingressgateway`:

```yaml
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: httpbin-ingress-gw
  namespace: default
spec:
  selector:
    istio: ingressgateway
  servers:
    # Принимать запросы только с указанными Host-заголовками
    - hosts:
        - "httpbin.k8s.local"
      port:
        number: 80
        name: http
        protocol: HTTP
    - hosts:
        - "httpbin.k8s.local"
      port:
        name: https-443
        number: 443
        protocol: HTTPS
      tls:
        # Шлюз не трогает трафик, пересылая зашифрованный поток внутрь кластера.
        # Используется, если приложение само хранит сертификаты и умеет в TLS
        # mode: PASSTHROUGH
        # Шлюз отдает клиенту свой сертификат и клиент доверяет шлюзу (односторонний TLS)
        # mode: SIMPLE
        # Требует, чтобы клиент тоже предъявил сертификат, подписанный нашим CA
        mode: MUTUAL
        credentialName: httpbin-certs
        # caCertificates: /certs/ca.crt
        # serverCertificate: /certs/httpbin.crt
        # privateKey: /certs/httpbin.key
```

Шлюз для внешней интеграции через `egressgateway`:

```yaml
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: httpbingo-egress-gw    # Должно совпадать с именем в VirtualService
  namespace: default
spec:
  selector:
    istio: egressgateway
  servers:
    - hosts:
        - "httpbingo.org"
      port:
        number: 8080           # Порт сервиса для шлюза
        name: http
        protocol: HTTP
```

#### Virtual Service

[VirtualService](https://istio.io/latest/docs/reference/config/networking/virtual-service) (`VS`) - определяет правила маршрутизации трафика на прикладном уровне (`L7`), такие как разделение по весу для статегии `Canary`, перенаправление по конечным точкам или HTTP-заголовкам.

```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: httpbin-ingress-vs
  namespace: default
spec:
  # Список шлюзов, через которые этот сервис доступен извне
  gateways:
    - httpbin-ingress-gw
  # Список имен, которые слушает Istio (ищет VirtualService, у которого в hosts есть указанное имя)
  hosts:
    - "httpbin.k8s.local"                           
    - "httpbin"                           # Для запросов в том же namespace
    - "httpbin.default"                   # Для запросов из других namespace
    - "httpbin.default.svc.cluster.local" # Полное имя (FQDN)
  # Правила для HTTP-трафика
  http:
    - name: httpbin-default-route
      # Условие для приема трафика
      match:
        - uri:
            prefix: "/api/v1/"
          # method:
          #   exact: "GET"
          # headers:
          #   user-agent:
          #     prefix: "curl"
      # Подмена пути для пересылки внутрь сервиса
      # httpbingo.org/api/v1/headers -> httpbin-service/headers
      rewrite:
        uri: "/"
      # Куда отправить трафик
      route:
        - destination:
            host: httpbin-service
            port: 
              number: 80      # Порт на сервисе (spec.ports.port) 
            subset: v2        # Версия subset определяется в DestinationRule
          weight: 100         # 100% трафика из этого матча идет на v2
    # Если предыдущее правило не сработало, обрабатываем следующие
    - name: "canary-rollout"
      route:
        - destination:
            host: httpbin-service
            subset: v1
          weight: 90          # 90% трафика на старую версию
        - destination:
            host: httpbin-service
            subset: v2
          weight: 10          # 10% трафика на новую (Canary)
  # Настройки для L4 трафика (TCP и TLS)
  # tcp:
  #   - match:
  #       - port: 5432
  #     route:
  #       - destination:
  #           host: pg-svc
```

Внешняя интеграция:

```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: httpbingo-egress-vs
  namespace: default
spec:
  # Правила маршрутизации для указанных шлюзов
  gateways:
    - mesh
    - httpbingo-egress-gw
  hosts:
    - "httpbingo.org"
  http:
    # Правило для пересылки запроса от пода через Sidecar Envoy Proxy до сервиса Egress Gateway
    - match:
      - gateways:
          - mesh
        # Фильтровать правило по указанному порту (запросы на httpbingo.org:80)
        # port: 80
      rewrite:
        authority: "httpbingo.org"
      # Sidecar отправляет запрос на сервис istio-egressgateway:8080
      route:
        - destination:
            host: istio-egressgateway.istio-system.svc.cluster.local
            port:
              number: 8080
    # Запретить отправку подом на 443 порт
    # - match:
    #     - gateways: 
    #         -mesh
    #       port: 443
    #   fault:
    #     abort:
    #       httpStatus: 403
    #       percentage:
    #         value: 100
    # Правило для пересылки запроса из Egress Gateway Service в Интернет
    - match:
      - gateways:
          - httpbingo-egress-gw
        port: 8080
      rewrite:
        authority: "httpbingo.org"
      route:
        - destination:
            host: "httpbingo.org"
            port:
              number: 443
```

#### Service Entry

[ServiceEntry](https://istio.io/latest/docs/reference/config/networking/service-entry) (`SE` для `Egress`) - используется для регистрации внешних сервисов в адресной книге Istio (т.к. внешние сервисы не имею свои объекты `Service`), что позволяет Sidecar Envoy Proxy разрешать (требуется при использование режима работы `REGISTRY_ONLY` в [OutboundTrafficPolicy](https://istio.io/latest/docs/reference/config/istio.mesh.v1alpha1/#MeshConfig-OutboundTrafficPolicy) глобальной конфигурации Mesh) и применять направление трафика из `VirtualService`.

```yaml
apiVersion: networking.istio.io/v1beta1
kind: ServiceEntry
metadata:
  name: httpbingo-egress-se
  namespace: default
spec:
  hosts:
    - "httpbingo.org"       # Должно совпадать с hosts в VirtualService
  location: MESH_EXTERNAL   # Указываем, что ресурс находится вне кластера
  resolution: DNS           # Istio сам определит IP-адреса у хоста через DNS
  ports:
    # Чтобы под мог достучаться до Gateway через Sidecar
    - number: 80
      name: http
      protocol: HTTP
    # Чтобы шлюз мог выпустить трафик в Интернет через Gateway
    - number: 443
      name: https
      protocol: HTTPS
```

#### Destination Rule

[DestinationRule](https://istio.io/latest/docs/reference/config/networking/destination-rule) (`DR`) - настраивает политики трафика, применяемые после маршрутизации (`VS` -> `SE` -> `GW` -> `DR`). Отвечает за использование протокола `TLS`, режим балансировки, ограничение количества соединений и разделение на версии через `subsets`.

```yaml
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: httpbingo-egress-dr
  namespace: default
spec:
  host: "httpbingo.org"
  trafficPolicy:
    # Настройка TLS для подключений к вышестоящему сервису по указанному порту
    portLevelSettings:
      - port:
          number: 443
        # Заставляет использовать протокол TLS на шлюзе
        tls:
          mode: SIMPLE
    # Определяет режим работы, если у внешнего сервиса несколько IP-адресов
    # Которые получены с помощью resolution DNS через ServiceEntry
    loadBalancer:
      simple: ROUND_ROBIN
      # Отправляет на адрес, у которого меньше активных TCP-соединений или HTTP-запросов
      # simple: LEAST_CONN
      # simple: LEAST_REQUEST
      # Закрепляет клиента за определенным IP на основе IP клиента, заголовке или cookie
      # consistentHash:
      #   useSourceIp: true
      #   httpHeaderName: "X-User-ID"
      #   httpCookie:
      #     name: "user-session"
      #     ttl: "3600s"
    connectionPool:
      tcp:
        # Максимальное количество одновременных TCP-соединений
        maxConnections: 100
        # Время ожидания для установки соединения
        connectTimeout: 3s
      http:
        # Максимальное количество активных запросов к целевому адресу
        http2MaxRequests: 1000
        # Максимальное количество запросов на одно соединение
        maxRequestsPerConnection: 10
        # Максимальное количество попыток повторного подключения
        maxRetries: 3
```

#### Envoy Filter

[EnvoyFilter](https://istio.io/latest/docs/reference/config/networking/envoy-filter) (`EF`) - низкоуровневый ресурс, который позволяет внедрять кастомные настройки прямо в прокси-сервера `Envoy`, когда возможностей `VirtualService` не хватает (например, для настройки `Rate Limit`).

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: EnvoyFilter
metadata:
  name: add-egress-header
  namespace: istio-system
spec:
  # Применяем действие для шлюза
  workloadSelector:
    labels:
      istio: egressgateway
  configPatches:
    - applyTo: HTTP_FILTER
      match:
        context: GATEWAY
        listener:
          portNumber: 8080
          filterChain:
            filter:
              name: "envoy.filters.network.http_connection_manager"
      # Вставляем фильтр на lua-скрипте для добавления заголовка перед отправкой
      patch:
        operation: INSERT_BEFORE
        value:
          name: envoy.lua
          typed_config:
            "@type": type.googleapis.com/envoy.config.filter.http.lua.v2.Lua
            inlineCode: |
              function envoy_on_request(request)
                request:headers():add("X-Egress-Validated", "true")
              end
```

### MetalLB

[MetalLB](https://github.com/metallb/metallb) - балансировщик нагрузки для локальных кластеров, эмулирующий работу облачных провайдеров. Настраивается пул адресов, и в случае падения ноды, переводит IP-адреса сервисов на другую ноду. Для сервисов `LoadBalancer` (включая Ingress-контроллер) выдается один внешний виртуальный IP-адрес, который прописывается на внешнем DNS-сервере.

```bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.15.2/config/manifests/metallb-native.yaml
```

Создать новый пул адресов:

```yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default-pool
  namespace: metallb-system
spec:
  addresses:
  # - 192.168.3.201/32
  - 192.168.3.201-192.168.3.210
  autoAssign: false # требует аннотации пула и указание адреса в service
```

`kubectl apply -f ip-address-pool.yaml`

Разрешить анонсирование IP-адресов из `default-pool` в локальной сети через протокол `ARP` на канальном уровне `L2`:

```yaml
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default-l2
  namespace: metallb-system
spec:
  ipAddressPools:
  - default-pool
```

`kubectl apply -f l2-advertisement.yaml`

Добавляем `annotations` на целевом объекте `Service`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: traefik-service
  namespace: default
  annotations:
    metallb.universe.tf/address-pool: "default-pool"
    metallb.universe.tf/loadBalancerIPs: "192.168.3.200"
spec:
  type: LoadBalancer
  selector:
    app: traefik
  ports:
  - name: web
    port: 80
    protocol: TCP
    targetPort: 80
  - name: websecure
    port: 443
    protocol: TCP
    targetPort: 443
```

### Longhorn

[Longhorn](https://github.com/longhorn/longhorn) - это распределенная блочная система хранения данных для Kubernetes с поддержкой управления через Web UI, которая превращает локальные диски нод в кластерное хранилище за счет репликации. Pod обращается к тому хранилища через `Engine`, который в свою очередь записывает данные во все реплики синхронно, при этом чтение может происходить из любой реплики.

```bash
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.9.2/deploy/longhorn.yaml
# Сделить за процессом установки
kubectl get pods \
--namespace longhorn-system \
--watch
# Отобразить все доступные хранилища
kubectl get storageclass
```

Требуется установить зависимости на каждой ноде:

```bash
# Установка NFS-клиента для доступа в режиме ReadWriteMany
sudo apt-get install -y nfs-common

# Установка iSCSI-клента для размещения томов как таргетов на нодах
sudo apt-get install -y open-iscsi
iscsiadm --version
sudo systemctl enable iscsid
sudo systemctl start iscsid
sudo systemctl status iscsid
```

Доступ к данным:

```bash
# Директория хранения данных на нодах
ls ls /var/lib/longhorn
# Проверить, что образ используется процессом longhorn
lsof /var/lib/longhorn/replicas/pvc-eef4de6d-94b1-4e89-95e1-6a12fba607fa-1b4fe8ac/volume-head-000.img

# Просмотреть содержимое образа
# Скопировать образ
cp /var/lib/longhorn/replicas/pvc-eef4de6d-94b1-4e89-95e1-6a12fba607fa-1b4fe8ac/volume-head-000.img /var/lib/longhorn/replicas/pvc-eef4de6d-94b1-4e89-95e1-6a12fba607fa-1b4fe8ac/volume-head-000-backup.img
# Создать виртуальный диск
losetup -f -P --show /var/lib/longhorn/replicas/pvc-eef4de6d-94b1-4e89-95e1-6a12fba607fa-1b4fe8ac/volume-head-000-backup.img
# Примонтировать диск
mkdir -p /mnt/loops && mount /dev/loop2 /mnt/loops
# Поключиться к фс без монтирования
debugfs /dev/loop2
# Отмонтировать и отключить диск
umount /mnt/loops
losetup -d /dev/loop2
```

### ArgoCD

[Argo CD](https://github.com/argoproj/argo-cd) - это декларативный инструмент непрерывного развертывания Kubernetes, использующий методологию GitOps, где Git репозиторий является единственным источником правды. Из коробки поддерживает изменение исходной ветки и параметров для Kustomize или Helm, `Diff` изменений в кластере по сравнениюю с репозиторием, выбор ресурсов с фильтрацией для их обновления и визуализацию всех объектов.

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# Включить режим LB
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
# Зайти и изменить порт
port: 8466
port: 8467
# Получить пароль
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Режимы синхронизации:

- **Force** - принудительно пересоздает ресурсы, даже если Kubernetes запрещает их изменение без подтверждения (эквивалент команде `kubectl --force`).
- **Prune** - удаляет любые ресурсы в кластере, которые отсутствуют в текущем состоянии Git-репозитория (т.е. помечены желтой корзиной, эквивалент команде `kubectl apply --prune`).
- **Dry Run** - тестовый запуск (проверка синхронизации), позволяющий отобразить какие изменения будут применены к кластеру без фактического их выполнения.
- **Apply Only** - будет только добавлять/обновлять ресурсы, но никогда не удалит ресурсы (обратное действие **Prune**).

Опции синхронизации:

- **Skip Schema Validation** - отключает проверку на соответствие YAML-манифестов официальной схеме Kubernetes OpenAPI, например, для работы с кастомными ресурсами (CRD) или при ошибках валидации.
- **Auto-Create Namespace** - автоматическое создание namespace перед синхронизацией ресурсов, если пространство имен, указанное в манифесте, не существует.
- **Prune Last** - изменяет порядок, сначала применяет новые ресурсы, дожидается их готовности, и только потом удаляет старые/устаревшие ресурсы.
- **Apply Out of Sync Only** - обрабатывает только те ресурсы, которые Argo CD пометил как Out of Sync (который определяется после Refresh в процессе сравнения с Git-репозиторием), пропуская все остальные, ускоряя процесс.
- **Respect Ignore Differences** - игнорировать изменения в определенных полях, например, количество реплик, если используется HPA (Horizontal Pod Autoscaling).
- **Server-Side Apply** - использует логику объединения изменений на стороне API-сервера Kubernetes, а не на стороне клиента Argo CD, что помогает с большими ресурсами и предотвращает конфликты last-applied-configuration.
- **Replace** - вместо стандартного `kubectl apply`, для объединения изменений, использует `kubectl replace` (`delete` и `create` вместо `patch`), где полностью заменяются существующие объекты, или `kubectl create`, если объекта нет.
- **Retry** - если синхронизация завершается с ошибкой (например, API-сервер недоступен или лимит запросов превышен), будет повторяться попытка синхронизации через заданные интервалы времени.

Аннотации для настройки:

```yaml

annotations:
  # Управляет очередностью развертывания ресурсов
  argocd.argoproj.io/sync-wave: "0"
  # Не помечать приложение как OutOfSync, если этот ресурс есть в кластере, но нет в Git
  argocd.argoproj.io/compare-options: IgnoreExtraneous
  # Игнорировать ресурс при проверке здоровья всего приложения (Application Health)
  argocd.argoproj.io/ignore-healthcheck: "true"
  # Создать ресурс один раз и отключить его синхронизацию и проверку изменений с Git
  argocd.argoproj.io/compare-options: IgnoreAll

  # Опции синхронизации (можно комбинировать через запятую)
  argocd.argoproj.io/sync-options: "Force=true,Prune=true,Replace=false"

  # Хуки для Job/Pod
  argocd.argoproj.io/hook: PreSync        # До начала синхронизации
  # argocd.argoproj.io/hook: Sync         # Во время синхронизации
  # argocd.argoproj.io/hook: PostSync     # После успешной синхронизации (Healthy)
  # argocd.argoproj.io/hook: SyncFail     # Если синхронизация завершилась с ошибкой

  # Удаление хуков
  argocd.argoproj.io/hook-delete-policy: HookSucceeded      # После успеха
  argocd.argoproj.io/hook-delete-policy: HookFailed         # После ошибки
  argocd.argoproj.io/hook-delete-policy: BeforeHookCreation # Перед новым запуском ошибки
```

### MinIO

[MinIO](https://github.com/minio/minio) - это высокопроизводительное, совместимое с S3 решение для хранения объектов.

```yaml
services:
  minio1:
    image: minio/minio
    container_name: minio1
    restart: unless-stopped
    hostname: minio1
    command: server http://minio1:9000/data http://minio2:9000/data --console-address ":9001"
    environment:
      - MINIO_ROOT_USER=admin
      - MINIO_ROOT_PASSWORD=MinioAdmin
    volumes:
      - ./minio1_data:/data
    ports:
      - 9000:9000 # API
      - 9001:9001 # WebUI

  minio2:
    image: minio/minio
    container_name: minio2
    restart: unless-stopped
    hostname: minio2  
    command: server http://minio1:9000/data http://minio2:9000/data --console-address ":9001"
    environment:
      MINIO_ROOT_USER: admin
      MINIO_ROOT_PASSWORD: MinioAdmin
    volumes:
      - ./minio2_data:/data
    ports:
      - 9002:9000
      - 9003:9001
```

### S3fs

[S3fs](https://github.com/s3fs-fuse/s3fs-fuse) - инструмент для монтирования S3 совместимого хранилища на базе FUSE, позволяя управлять файлами и каталогами в локальной файловой системе.

`sudo apt install -y s3fs` установка \
`sudo mkdir -p /mnt/s3` создать директорию для монтирования \
`echo "admin:MinioAdmin" > /tmp/s3cred && chmod 600 /tmp/s3cred` сохранить авторизационные данные для подключения к s3 \
`s3fs <BUCKET_NAME:PATH> <MOUNTPOINT_PATH> <OPTION>` формат монтирования \
`sudo s3fs velero /mnt/s3 -o url=http://localhost:9000 -o use_path_request_style -o passwd_file=/tmp/s3_cred` монтировать файловую систему \
`mount | grep /mnt/s3` отобразить точки монтирования \
`sudo umount /mnt/s3` отмонтировать

```yaml
services:
  s3fs:
    image: efrecon/s3fs:1.95
    container_name: velero_data
    restart: unless-stopped
    privileged: true
    stdin_open: true
    tty: true
    devices:
      - /dev/fuse
    cap_add:
      - SYS_ADMIN
    security_opt:
      - apparmor=unconfined
    environment:
      - AWS_S3_URL=http://minio1:9000
      - AWS_S3_BUCKET=velero
      - AWS_S3_ACCESS_KEY_ID=admin
      - AWS_S3_SECRET_ACCESS_KEY=MinioAdmin
      - S3FS_ARGS=use_path_request_style,allow_other
    volumes:
      - ./velero_data:/opt/s3fs/bucket:rshared
```

### Velero

[Velero](https://github.com/vmware-tanzu/velero) (ранее Heptio Ark) - это инструменты для резервного копирования и восстановления ресурсов кластера Kubernetes и постоянных томов.

```bash
curl -sSL https://github.com/vmware-tanzu/velero/releases/download/v1.17.0/velero-v1.17.0-linux-amd64.tar.gz -o velero-linux-amd64.tar.gz
tar -xvf velero-linux-amd64.tar.gz
mv velero-*/velero ~/.local/bin/
rm -rf velero-*
velero version
```

Создаем креды для подключения к s3 хранилищу [minio](https://github.com/minio/minio):

```bash
cat <<EOF > velero-minio.env
[default]
aws_access_key_id=admin
aws_secret_access_key=MinioAdmin
EOF
```

Установка в кластер:

```bash
velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.13.0 \
    --bucket velero \
    --secret-file ./velero-minio.env \
    --backup-location-config region=minio,s3ForcePathStyle=true,s3Url=http://192.168.3.101:9000 \
    --namespace velero
```

`kubectl get pods -n velero` проверяем, что под запущен \
`kubectl logs deploy/velero -n velero` проверяем, что нет ошибок подключения к s3 \
`velero backup-location get` отобразить статус BSL (Backup Storage Location) (`PHASE` - `Available`)

`velero backup create telegram-bot-backup --include-namespaces telegram` запустить backup \
`velero schedule create telegram-daily --schedule "0 3 * * *" --include-namespaces telegram --ttl 168h` запускать каждый день в 03:00 (ttl определяет автоматическуое удаление всех созданных velero ресурсов через 7 дней) \
`velero backup describe telegram-bot-backup --details` отобразить статус резервного копирования (ключевое - статус, продолжительность копирования и список ресурсов) \
`velero backup get` отобразить список всех бэкапов, их статус (`Completed`, `Failed`, `InProgress`) и namespace

`velero restore create --from-backup telegram-bot-backup --include-namespaces telegram` восстанавливает все ресурсы из указанного бэкапа \
`kubectl get deployments -n telegram --show-labels` отобразить все доступные лейблы в deployments \
`kubectl get all -n telegram --show-labels` отобразить все доступные ресурсы в указанном namespace \
`velero restore create --from-backup telegram-bot-backup --include-namespaces telegram --include-resources deployments,configmaps --selector app=your-deployment-name` восстановить только конкретные ресурсы с фильтрацией по `label` \
`velero restore get` отобразить статус восстановления

### Velero UI

[velero-ui](https://github.com/otwld/velero-ui) - веб-интерфейс для управления Velero (vmware-tanzu).

```yaml
services:
  velero-ui:
    image: otwld/velero-ui:latest
    container_name: velero-ui
    restart: unless-stopped
    volumes:
      - ~/.kube/config:/app/.kube/config:ro
      # - /etc/rancher/k3s/k3s.yaml:/app/.kube/config:ro
    environment:
      - PORT=3504
      - KUBE_CONFIG_PATH=/app/.kube/config
    # network_mode: host # use for k3s cluster config on localhost
    ports:
      - 3504:3504 # admin:admin
```

## Kustomize

[Kustomize](https://github.com/kubernetes-sigs/kustomize) - это встроенный в `kubectl` (с версии `1.14`) инструмент для управления и слияния конфигураций Kubernetes без использования шаблонизаторов (как в [Helm](https://github.com/helm/helm)). Он похож на `Make`, т.к. его действия объявлены в файле `kustomization.yaml`, и на `sed`, т.к. он выводит отредактированный текст (без создания новых и изменения исходных манифестов).

### Resources

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: rest-api
commonLabels:
  app: torapi
commonAnnotations:
  argocd.argoproj.io/sync-wave: "0"

resources:
- deployment.yaml
- service.yaml
# - hpa.yaml
- ingress.yaml
```

Формат запуска: `kubectl kustomize <path/url>`

Объеденить все манифесты перечисленные в `resources` в один `yaml` файл в заданном порядке:

```bash
kubectl kustomize ./base
```

Для каждого ресурса автоматически добавляется указанный `namespace`, все `labels` и `annotations`.

Применить все перечисленные манифесты из файла `kustomization.yaml` в кластере:

```bash
kubectl apply -k ./base
```

Kustomize позволяет отключать объекты ресурсов и удалять их из кластера по лейблу:

```bash
kubectl apply -k . --prune -l app=torapi
```

### Overlays Patch

Kustomize работает по принципу наследования конфигураций:

- `base/` - это директори, которая содержит базовые манифесты (например, `deployment.yaml` и `service.yaml`)
- `overlays/` - это директория, которая содержит изменения для разных окружений (например, `overlays/dev` и `overlays/test`), переопределяя только указанные параметры, соблюдая исходную `YAML` структуру.

Пример структуры каталога:

```bash
├── base
│   ├── deployment.yaml
│   ├── hpa.yaml
│   ├── ingress.yaml
│   ├── kustomization.yaml
│   ├── namespace.yaml
│   └── service.yaml
└── overlays
    ├── dev
    │   ├── kustomization.yaml
    │   └── patch-resources.yaml
    └── test
        ├── kustomization.yaml
        └── patch-resources.yaml
```

Пример дочернего файла `overlays/test/kustomization.yaml`:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

# Наследуем все манифесты из base
resources:
- ../../base

# Добавляем патч для изменения ресурсов контейнера
patches:
- path: patch-resources.yaml
```

Пример конфигурации для `overlays/test/path-resources.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: torapi
  namespace: rest-api
spec:
  template:
    spec:
      containers:
      - name: torapi
        resources:
          requests:
            cpu: "500m"
            memory: "1Gi"
          limits:
            cpu: "1000m"
            memory: "2Gi"
```

`kubectl kustomize overlays/test/` проверить конфигурацию

`kubectl apply -k overlays/test` применить конфигурацию

### ConfigMap Generator

Генерация `configMap` из файлов и переменных окружения:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: telegram

resources:
# - configmap.yaml
- deployment.yaml

configMapGenerator:
- name: openrouter-bot-config
  # Передать содержимое файла в configMap
  files:
    - .env
  # Передать переменные окружения из env файла
  # envs:
  #   - .env
  # Передать переменные окружения вручную (key=value)
  # literals:
  #   - LOG_MODE=DEBUG
```

### Helm Charts

Используя Kustomize, возможно объединить запуск нескольких Helm-чартов, например, для группировки в один ArgoCD Application.

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: telegram

helmCharts:
  - name: ssh-bot
    includeCRDs: true
    releaseName: ssh-bot
    additionalValuesFiles:
      - ./values/ssh-bot/values.yaml
      - ./values/default/values.yaml
  - name: openrouter-bot
    includeCRDs: true
    releaseName: openrouter-bot
    additionalValuesFiles:
      - ./values/openrouter-bot/values.yaml
      - ./values/default/values.yaml

helmGlobals:
  chartHome: ./charts
```

Структура:

```bash
├── charts/
│   ├── ssh-bot/
│   │   └── Chart.yaml
│   └── openrouter-bot/
│       └── Chart.yaml
│
├── values/
│   ├── default/
│   │   └── values.yaml
│   ├── ssh-bot/
│   │   └── values.yaml
│   └── openrouter-bot/
│       └── values.yaml
│
└── kustomization.yaml
```

## Helm

### Charts

[Helm](https://github.com/helm/helm) - это шаблонизатор для управления конфигурациями, а также менеджер пакетов для управления версионированием в Kubernetes, использующий чарты (`charts`, которые являются пакетами), содержащими всю информацию для установки и управления приложениями в Kubernetes.

`curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash`

Пример базовой структуры:

```bash
├── Chart.yaml
├── values.yaml
└── templates
    ├── deployment.yaml
    └── service.yaml
```

- `Chart.yaml` (содержит описание пакета)

```yaml
apiVersion: v2
name: torapi
description: Unofficial API for torrent trackers
version: 0.1.0
appVersion: "0.5.2"
```

- `values.yaml` (содержит переменные по умолчанию)

```yaml
# Deployment
replicaCount: 2
image: "lifailon/torapi:latest"
containerPort: 8443
resources:
  requests:
    cpu: "100m"
    memory: "128Mi"
  limits:
    cpu: "200m"
    memory: "256Mi"
probe:
  path: "/api/provider/list"
  port: 8443
  initialDelaySeconds: 5
  periodSeconds: 10
  timeoutSeconds: 3
  failureThreshold: 3

# Service
service:
  type: LoadBalancer
  port: 8444
  targetPort: 8443
```

Все шаблоны манифестов харнятся в директории `templates`.

- `templates/deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}
  namespace: rest-api
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Release.Name }}
  template:
    metadata:
      labels:
        app: {{ .Release.Name }}
    spec:
      containers:
      - name: {{ .Release.Name }}
        image: {{ .Values.image }}
        ports:
        - containerPort: {{ .Values.containerPort }}
        resources:
          requests:
            cpu: "{{ .Values.resources.requests.cpu | default "100m" }}"
            memory: "{{ .Values.resources.requests.memory | default "128Mi" }}"
          limits:
            cpu: "{{ .Values.resources.limits.cpu | default "200m" }}"
            memory: "{{ .Values.resources.limits.memory | default "256Mi" }}"
        livenessProbe:
          httpGet:
            path: {{ .Values.probe.path }}
            port: {{ .Values.probe.port }}
          initialDelaySeconds: {{ .Values.probe.initialDelaySeconds }}
          periodSeconds: {{ .Values.probe.periodSeconds }}
          timeoutSeconds: {{ .Values.probe.timeoutSeconds }}
          failureThreshold: {{ .Values.probe.failureThreshold }}
```

- `templates/service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}-service
  namespace: rest-api
spec:
  selector:
    app: {{ .Release.Name }}
  ports:
    - protocol: TCP
      targetPort: {{ .Values.service.targetPort }}
      port: {{ .Values.service.port }}
  type: {{ .Values.service.type }}
```

`helm template torapi .` напечатать итоговую спецификацию (проверить подстановку переменных) \
`helm install torapi . -n monitoring --create-namespace` установка в кластер \
`helm upgrade --install torapi . -n monitoring` обновление релиза (при изменение значение в `values.yaml`) \
`helm uninstall torapi .` удалить

Публикация и установка:

```bash
helm package . # упаковать пакет (архив)
helm repo index . --url https://<username>.github.io/<repo_name> # создать или обновить индекс
# Разместить <repo_name>-0.1.0.tgz и index.yaml в новую ветку gh-pages

helm repo add openrouter-bot https://<username>.github.io/<repo_name> # добавить новый репозиторий
helm repo list
helm upgrade --install <repo_name> <repo_name>/<repo_name> # установить пакет
```

### Переменные

Все переменные, объявленные в файлах переменных (в т.ч. переданные через флаг `--values`) начинаются с `{{ .Values. }}`, поддерживая вложенность структуры `yaml`.

```yaml
name: {{ .Values.app.name }}
```

Встроенные переменные:

`Chart` содержимое файла `Chart.yaml`, где доступны любые объявленные в нем переменные, например, `{{ .Chart.Name }}-{{ .Chart.Version }}` \
`Subcharts` предоставляет родительскому элементу доступ к области видимости (`.Values`, `.Charts`, `.Releases` и т. д.) дочерних диаграмм \
`Release.Name` название релиза \
`Release.Namespace` пространство имен (если манифест не переопределяет это) \
`Release.IsInstall` параметр устанавливается как true, если текущая операция - установка \
`Release.IsUpgrade` параметр устанавливается как true, если текущая операция представляет собой обновление или откат \
`Release.Revision:` номер ревизии для этого выпуска (при первой установке он равен 1 и увеличивается при каждом обновлении и откате) \
`Release.Service:` сервис, который отображает текущий шаблон (в Helm это всегда Helm) \
`Capabilities` предоставляет информацию о возможностях, которые поддерживает кластер Kubernetes \
`Capabilities.APIVersions` представляет набор версий \
`Capabilities.APIVersions.Has $versionу` показывает, доступна ли версия (например, `batch/v1`) или ресурс (например, `apps/v1/Deployment`) в кластере \
`Capabilities.KubeVersion или Capabilities.KubeVersion.Version` версия для Kubernetes \
`Capabilities.KubeVersion.Major` основная версия Kubernetes \
`Capabilities.KubeVersion.Minor` минорная версия Kubernetes \
`Capabilities.HelmVersion` содержит подробную информацию о версии Helm (как в helm version) \
`Capabilities.HelmVersion.Version` текущая версия Helm в формате `semver`  \
`Capabilities.HelmVersion.GitCommit` helm git sha1 \
`Capabilities.HelmVersion.GitTreeState` состояние дерева Helm в Git \
`Capabilities.HelmVersion.GoVersion` это версия используемого компилятора Go \
`Template` содержит информацию о текущем выполняемом шаблоне \
`Template.Name` путь к файлу с указанием пространства имен для текущего шаблона (например, `mychart/templates/mytemplate.yaml`) \
`Template.BasePath` путь с указанием пространства имен к каталогу шаблонов текущей диаграммы (например, `mychart/templates`)

### Файлы

Функции с файлами:

`Files` функция предоставляет доступ ко всем неспециальным файлам в диаграмме \
`Files.Get` функция для получения файла по имени (`.Files.Get config.ini`) \
`Files.GetBytes` функция для получения содержимого файла в виде массива байтов, а не строки (полезно, например, для изображений) \
`Files.Glob` функция, которая возвращает список файлов, имена которых соответствуют заданному шаблону оболочки \
`Files.Lines` функция, которая считывает файл построчно (полезно для перебора каждой строки в файле) \
`Files.AsSecrets` функция, которая возвращает содержимое файлов в виде строк, закодированных в `Base64` \
`Files.AsConfig` функция, которая возвращает тела файлов в виде YAML-карты

Структура:

```bash
├── Chart.yaml
├── values.yaml
├── templates
│   └── configmap.yaml
└── configs
    ├── application.yml
    └── ip-addr-list.txt
```

Читаем содержимое файла `configs/application.yml` для передачи его содержимого в `ConfigMap`:

```yaml
data:
  application.yml: |-
{{ .Files.Get "configs/application.yml" | indent 4 }}
```

Предварительная шаблонизация содержимого файла с помощью функции `tpl`:

```yaml
data:
  application.yml: |-
{{- tpl (.Files.Get "configs/application.yml") . | indent 4 }}
```

Массовая загрузка файлов по шаблону (например, все `.yml` файлы из директории):

```yaml
data:
{{- range $path, $_ :=  .Files.Glob "configs/*.yml" }}
  {{ base $path }}: |-
{{ $.Files.Get $path | indent 4 }}
{{- end }}
```

Автоматическое заполнение `ConfigMap` всеми файлами из директории:

```yaml
data:
{{- (.Files.Glob "configs/**.yml").AsConfig | indent 2 }}
```

Читаем содержимое бинарного файла (картинки, сертификаты и т.п.):

```yaml
data:
  logo.png: {{ .Files.GetBytes "assets/logo.png" | b64enc }}
```

Читаем содержимое в бинарном формате из содержимого переменной в `Values`:

```yaml
binaryData:
  keystore.p12: |-
    {{ .Values.app.integrations.kafka.keystore }}
  truststore.p12: |-
    {{ .Values.app.integrations.kafka.truststore }}
```

Чтение списка имен, IP-адресов или других слов из файла для цикла:

```yaml
# Файл ip-addr-list.txt содержит список IP по одному на каждой строке
metadata:
  annotations:
    {{- range $index, $line := .Files.Lines "configs/ip-addr-list.txt" }}
    {{- if $line }}
    ip-allow-{{ $index }}: {{ $line | trim | quote }}
    {{- end }}
    {{- end }}
```

Пример вывода:

```yaml
metadata:
  annotations:
    ip-allow-0: "192.168.1.101"
    ip-allow-1: "192.168.1.105"
    ip-allow-2: "192.168.1.106"
```

### Функции

Встроенные [функции](https://helm.sh/docs/chart_template_guide/function_list) для обработки текста:

```yaml
name: {{ .Values.storageClassName | quote }} # оборачивает значение в кавычки
name: {{ .Values.storageClassName | lower }} # преобразует строку в нижний регистр
name: {{ .Values.storageClassName | upper }} # преобразует строку в верхний регистр

name: {{ .Values.storageClassName | trim }}  # удаляет пробелы по краям строки
name: {{ .Values.storageClassName | trimAll "/" }} # удаляет все указанные символы (/) с обоих концов строки
name: {{ .Values.storageClassName | trimPrefix "/" }} # удаляет указанный префикс (/) в начале строки
name: {{ .Values.storageClassName | trimSuffix "/" }} # удаляет указанный суффикс (/) в конце строки

name: {{ printf "%s-%d" .Values.storageClassName .Values.storageClassVersion }} # форматирует строку по шаблону (объединяет значения разных типов, например, string и int)
name: {{ .Values.storageClassName | default "тут значение по умолчанию" }}  # устанавливает значение по умолчанию, если переменная пуста
name: {{ .Values.storageClassName | required "значение в storageClassName не определено" }} # прерывает установку с ошибкой, если значение не задано
```

Замена текста с помощью функции `replace`.

Содержимое в файле `Values`:

```yaml
dbHost: "prod-db-01.internal"
connectionString: "postgresql://user:password@{HOST}:5432/mydb"
```

Заменяем заглушку `{HOST}` на значение из `dbHost` в манифесте:

```yaml
url: {{ .Values.connectionString | replace "{HOST}" .Values.dbHost }}
```

Заполнение содержимого с помощью функции `toYaml`:

Содержимое в файле `Values`:

```yaml
env:
  DN_NAME: test
  DN_USERNAME: admin
```

Заполняем содержимое:

```yaml
env: {{ .Values.env | toYaml | nindent 2 }}
```

Вывод:
```yaml
env:
  DN_NAME: test
  DN_USERNAME: admin
```

### Условия

Условия для проверки значений:

```yaml
# Проверка на присутствия значений в переменных
{{ if .Values.enablePersistence }}
  enablePersistence: true
{{ else if .Values.enableFilesystem }}
  enableFilesystem: true
{{ else }}
  enablePersistence: false
  enableFilesystem: false
{{ end }}

# Сокращенный формат (?:) для проверки булевого значения
# Если переменная содержит false или значение отсутствует, вернет второе значение
{{ ternary "true" "false" .Values.integrations.database.enable }}

# Проверка на равенство и неравенство
{{ if eq .Values.environment "production" }}
{{ if ne .Values.environment "production" }}
# Проверка нескольких условий (и/или)
{{ if and (eq .Values.environment "production") (eq .Values.host "minikube") }}
{{ if or (eq .Values.environment "production") (eq .Values.host "minikube") }}
# Отрицание
{{ if not (eq .Values.environment "production") }}

# Арфеметические условия
# Больше
{{ if gt (len .Values.items) 3 }}
# Больше или равно
{{ if gte (len .Values.items) 3 }}
# Меньше
{{ if lt (len .Values.items) 3 }}
# Меньше или равно
{{ if lte (len .Values.items) 3 }}

# Проверка строковых значения
{{ if .Values.app.name | contains "example" }}
{{ if .Values.app.name | hasPrefix "app-" }}
{{ if .Values.app.name | hasSuffix "-fix" }}
{{ if .Values.app.name | regexMatch "^[a-z]+$" }}

# Присутствие значения в списке
{{ if .Values.items | has "example" }}
  # Этот блок выполнится, если "example" есть в массиве items
{{ end }}
```

### Циклы

Циклы для перебора значений и заполнения массивов:

```yaml
volumes:
  {{ range .Values.volume.ids }}
  - volumeName: {{ . }}
  {{ end }}

volumes:
  {{ range $id := .Values.volume.ids }}
  - volumeName: {{ $id }}
  {{ end }}

# Используем индекс и значение
volumes:
  {{ range $index, $value := .Values.configuration }}
  - {{ $index }}: {{ $value }}
  {{ end }}
```

Пример заполнения набора манифестов:

```yaml
{{ range $key, $task := $.Values.integrations.database }}
kind: Service
apiVersion: v1
metadata:
  name: egressgateway-svc-{{ $task.name }}
  labels:
    app: egress-gateway
spec:
  type: ClusterIP
  selector:
    app: egress-gateway
  ports:
    - name: tcp-{{ $task.port }}
      protocol: TCP
      port: {{ $task.port }}
      targetPort: {{ $task.port }}
{{ end }}
```

### Define

Используются как как функции, позволяя не дублировать код и поддерживают глобальную область видимости. Они объявляются в любом манифесте из директории `templates` или в специальном файле шаблона (например, `_helpers.tpl`).

Переменные в файле `Values`:

```yaml
app:
  image: app
  tag: "v1.2.3"
```

Объявляем `define`:

```yaml
{{- define "app.image" -}}
  {{- $image := .Values.app.image -}}
  {{- $tag := .Values.app.tag | default .Chart.AppVersion -}}
  {{- printf "%s:%s" $image $tag -}}
{{- end -}}
```

Используем в любом манифесте:

```yaml
spec:
  containers:
    - name: web
      image: {{ include "app.image" . }}
```

### Helper

`_helper` - это вспомогательный файл шаблона, который можно использовать повторно в разных манифестах одного чарта. Любой файл, имя которого начинается с нижнего подчеркивания не превращаются в Kubernetes-манифесты, из их содержимого сохраняется шаблоны `define`, но результат их выполнения не отправляются в кластер.

```yaml
{{- define "istio-egress.resources" -}}
  {{/* Проходим циклом по списку ключей "limits" и "requests" */}}
  {{- range $key := list "limits" "requests" }}
    {{/* Извлекаем объект (например, limits) из переданного контекста ($) по имени ключа */}}
    {{- $resources := index $ $key }}
    {{/* Проверяем, что такой блок существует в данных */}}
    {{- if $resources }}
      {{/* Проверяем, что его значение не пустое */}}
      {{- $hasValues := false }}
      {{- range $name, $value := $resources }}
        {{- if $value }}
          {{- $hasValues = true }}
        {{- end }}
      {{- end }}
      {{/* Если хотя бы одно значение (cpu/memory) найдено, выводим в YAML */}}
      {{- if $hasValues }}
  {{/* Выводим заголовок секции: "limits:" или "requests:" учитывая отступы */}}
  {{ $key }}:
        {{/* Снова перебираем параметры внутри секции для их отрисовки */}}
        {{- range $name, $value := $resources }}
          {{/* Печатаем только те поля, у которых есть значение (игнорируем пустые строки) */}}
          {{- if $value }}
    {{ $name }}: {{ $value }}
          {{- end }}
        {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end -}}
```

Пример использования:

```yaml
resources:
  # Опредиление ресурсов вручную с принудительным добавлением кавычек
  requests:
    cpu: {{ .Values.gateways.istio-ingressgateway.resources.requests.cpu | quote }}
    memory: {{ .Values.gateways.istio-ingressgateway.resources.requests.memory | quote }}
  limits:
    cpu: {{ .Values.gateways.istio-ingressgateway.resources.limits.cpu | quote }}
    memory: {{ .Values.gateways.istio-ingressgateway.resources.limits.memory | quote }}
  # Подставить все ресурсы в формате YAML и добавить 12 пробелов для каждой строки
  {{- toYaml .Values.gateways.istio-ingressgateway.resources | nindent 12 }}
  # Использовать шаблон, котоырй гарантирует пропуск пустых значений
  {{- include "istio-ingress.resources" .Values.gateways.istio-ingressgateway.resources | nindent 12 }}
```

## Helmfile

[Helmfile](https://github.com/helmfile/helmfile) - это декларативный инструмент для одновременного управления несколькими Helm-чартами с помощью одного `helmfile.yaml`, котоырй позволяет параметризовать чарты для разных сред (`dev`, `test`, `prod`), определять порядок развертывания и автоматизировать процесс установки/обновления приложений (как `docker-compose` для `Helm`).

```bash
curl -sSL https://github.com/helmfile/helmfile/releases/download/v1.4.4/helmfile_1.4.4_linux_amd64.tar.gz | tar -xz && sudo mv helmfile /usr/local/bin/
```

Пример для установки стека [Prometheus](https://github.com/prometheus-community/helm-charts):

```yaml
# Helm репозитории, откуда будет скачивать чарты
# Заменяет команды: helm repo add prometheus-community https://prometheus-community.github.io/helm-charts и helm repo update
repositories:
  - name: prometheus-community
    url: https://prometheus-community.github.io/helm-charts
  - name: headlamp
    url: ttps://kubernetes-sigs.github.io/headlamp

# Стендозависимые параметры
environments:
  dev:
    values:
      - namespace: "dev"
        path: "env/dev/values.yaml"
  test:
    values:
      - namespace: "test"
        path: "env/test/values.yaml"

# Список чартов для установки
releases:
  - name: prometheus-stack
    # <название репозитория>/<название чарта>
    chart: prometheus-community/kube-prometheus-stack
    # Локальный путь к чарту
    # chart: charts/prometheus-stack
    namespace: {{ .Values.namespace | default "monitoring" }}
    createNamespace: true
    # Локальный путь к стендозависимым переменным
    values:
      - {{ .Values.path }}
    # Игнорировать ошибку, если файл с переменными не найден
    missingFileHandler: Warn
    # Приоритет (запускать после указанных чартов)
    needs:
    - headlamp
  - name: headlamp
    chart: headlamp/headlamp
    namespace: kube-system
```

`helmfile init` проверяет и устанавливает/обновляет зависимости, необходимые для работы Helmfile (`helm` и плагины) \
`helmfile deps` добавление и обновление указанных репозиториев \
`helmfile diff` отобразить разницу для всех `charts` c состоянием кластера используя плагин [helm diff](https://github.com/databus23/helm-diff) \
`helmfile apply` применить конфигурацию (синхронизировать состояние кластера с файлом) \
`helmfile -e dev apply` применить конфигурацию для окружения `dev` \
`helmfile -l name=kube-prometheus-stack sync --include-needs` запустить только указанный чарт с учетом зависимых чартов

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

### Docker Build and Push

Сборка Docker образа из указанного коммита и публикация указанной версии на [Docker Hub](https://hub.docker.com).

```yaml
name: Docker build and push from specified commit

on:
  workflow_dispatch:
    inputs:
      # Принимает два строковых параметра
      Commit:
        description: "Commit for git checkout"
        required: true
        default: ""
      Version:
        description: "Version for docker tag"
        required: true
        default: ""

jobs:
  build:
    name: Docker build on ubuntu-latest

    runs-on: ubuntu-latest

    env:
      REPO_NAME: 'lazyjournal'

    steps:
      # Клонируем репозиторий (ветку main и историю всех комиттов)
      - name: Checkout repository (main branch and all commits)
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
          ref: main

      # Переключаем состояние истории репозитория на указанный коммит
      - name: Checkout the specified commit
        run: git checkout ${{ github.event.inputs.Commit }}

      # Авторизуемся
      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          # Предварительно создаем секреты в https://github.com/<userName>/<repoName>/settings/secrets/actions
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      # Устанавливаем плагин buildx для мультиархитектурной сборки (amd64 и arm64)
      - name: Install Docker Buildx
        uses: docker/setup-buildx-action@v3
        with:
          driver: docker-container
          install: true

      # Собираем и публикуем одной командой (используем тег из параметра)
      - name: Build and push Docker images for Linux on amd64 and arm64
        run: |
          version=${{ github.event.inputs.Version }}
          docker buildx build \
            --platform linux/amd64,linux/arm64 \
            -t ${{ secrets.DOCKER_USERNAME }}/${{ env.REPO_NAME }}:$version \
            --push .
```

### Dockerfile Linters Check

Проверка Dockerfile на [базовые линтеры](https://docs.docker.com/reference/build-checks) и с помощью инструмента [Hadolint](https://github.com/hadolint/hadolint).

🔗 [Hadolint Playground](https://hadolint.github.io/hadolint) ↗

```yaml
name: Dockerfile linters check

on:
  workflow_dispatch:
    # Принимает два булевых параметра
    inputs:
      Lint:
        description: 'Dockerfile basic linters check'
        default: false
        type: boolean
      Hadolint:
        description: 'Dockerfile hadolint check'
        default: false
        type: boolean

jobs:
  build:
    name: Docker build on ubuntu-latest

    runs-on: ubuntu-latest

    steps:
      # Клонируем репозиторий (ветку main и последний коммит)
      - name: Checkout repository (main branch and all commits)
        id: dockerPull
        uses: actions/checkout@v4
        with:
          fetch-depth: 1
          ref: main

      - name: Dockerfile basic linters check
        # Проверка условия перед выполнения шага
        if: ${{ github.event.inputs.Lint == 'true' }}
        # Определяем индивидуальный идентификатор для извлечения данных из шага
        id: lint
        run: docker build --check --build-arg "BUILDKIT_DOCKERFILE_CHECK=experimental=all" .

      - name: Dockerfile hadolint check
        if: ${{ github.event.inputs.Hadolint == 'true' }}
        id: hadolint
        run: docker run --rm -i hadolint/hadolint:latest < Dockerfil
```

### Telegram Notification

Отправка уведомлений в Telegram с помощью [Telegram Actions](https://github.com/appleboy/telegram-action).

```yaml
- name: Send report to Telegram
  if: ${{ github.event.inputs.Lint == 'true' || github.event.inputs.Hadolint == 'true' }}
  uses: appleboy/telegram-action@master
  with:
    token: ${{ secrets.TELEGRAM_API_TOKEN }}
    to: ${{ secrets.TELEGRAM_CHANNEL_ID }}
    debug: true
    format: markdown
    message: |
      🔔 **Action**: Docker linters check

      📁 **Repository**: ${{ github.repository }}
      👤 **User**: ${{ github.actor }}
      
      ${{ steps.lint.outcome == 'failure' && '❌' || '✅' }} **Dockerfile basic linters check**: ${{ steps.lint.outcome }}
      ${{ steps.hadolint.outcome == 'failure' && '❌' || '✅' }} **Dockerfile hadolint check**: ${{ steps.hadolint.outcome }}
```

### AI Issue Analysis

Анализ Issues с использованием [AI Inference](https://github.com/actions/ai-inference) и автоматическим ответом в комментариях.

```yaml
name: AI Issue Analysis

on:
  issues:
    types: [opened, closed, reopened]
  issue_comment:
    types: [created]

run-name: "Issue #${{ github.event.issue.number }}: ${{ github.event.issue.title }}"

jobs:
  issue_analysis:
    permissions:
      issues: write
      models: read

    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository (main branch and 1 last commits)
        uses: actions/checkout@v4
        with:
          fetch-depth: 1
          ref: main

      # Отправляем оповещение в Telegram с темой и содержимым проблемы
      # Срабатываем на открытие, закрытие и комментарии в задаче
      - name: Send message to Telegram
        uses: appleboy/telegram-action@master
        with:
          token: ${{ secrets.TELEGRAM_API_TOKEN }}
          to: ${{ secrets.TELEGRAM_CHANNEL_ID }}
          debug: true
          format: markdown
          message: |
            🔔 **Action**: ${{ github.event_name }} ${{ github.event.action }} [#${{ github.event.issue.number }}](${{ github.event.comment.html_url || github.event.issue.html_url }})

            📁 **Repository**: ${{ github.repository }}
            👤 **From user**: ${{ github.actor }}

            📌 **Title**: ${{ github.event.issue.title }}
            💬 **Description**:
            ${{ github.event.comment.body || github.event.issue.body }}

      # Генерируем отчет (только при открытие новой проблемы)
      - name: Generate report using AI
        if: ${{ github.event_name == 'issues' && github.event.action == 'opened' }}
        id: ai_query
        uses: actions/ai-inference@v2
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          endpoint: https://models.github.ai/inference
          model: gpt-4.1
          max-tokens: 1024
          system-prompt: |
            Ты консультант разработчика.
            Твоя задача анализировать проблемы (issues) на GitHub и предлагать решения.
            Твои ответы должны быть краткими и на английском языке.
          prompt: |
            Title: ${{ github.event.issue.title }}
            Description: ${{ github.event.issue.body }}

      # Постим комментарий от AI в ответ на Issue
      - name: Post comment from AI
        if: ${{ github.event_name == 'issues' && github.event.action == 'opened' && steps.ai_query.outputs.response != '' }}
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          ISSUE_NUMBER: ${{ github.event.issue.number }}
          AI_RESPONSE: ${{ steps.ai_query.outputs.response }}
        run: |
          gh pr comment "$PR_NUMBER" --body "### AI Issue Analysis
          
          $AI_RESPONSE"
```

### AI README Translate

Перевод `README` файла на англйский язык с помощью AI.

```yaml
name: AI Translate

on:
  workflow_dispatch:
    inputs:
      Input:
        description: Input README file
        required: true
        default: README_RU.md
      Output:
        description: Output README file
        required: true
        default: README.md
      Language:
        description: Target language for translation
        required: true
        default: English

jobs:
  translate:
    runs-on: ubuntu-latest

    permissions:
      contents: write
      pull-requests: write
      models: read

    steps:
      - name: Checkout
        uses: actions/checkout@v6

      - name: Read README
        id: read_file
        run: |
          INPUT_README=$(cat ${{ github.event.inputs.Input }})
          {
            echo "readme<<EOF"
            echo "$INPUT_README"
            echo "EOF"
          } >> "$GITHUB_OUTPUT"

      - name: AI-powered translation
        id: ai_translate
        uses: actions/ai-inference@v2
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          endpoint: https://models.github.ai/inference
          model: gpt-4.1
          max-tokens: 4096
          system-prompt: |
            You are a professional translator in the automated GitHub Actions CI system.
            Translate the file submitted in the README message into ${{ github.event.inputs.Language }}.
            You should not provide answers or change the original text structure.
            Preserve the original Markdown formatting and links.
          prompt: ${{ steps.read_file.outputs.readme }}

      - name: Write README
        env:
          README_TRANSLATE: ${{ steps.ai_translate.outputs.response }}
        run: |
          cat <<'EOF' > ${{ github.event.inputs.Output }}
          ${{ env.README_TRANSLATE }}
          EOF

      - name: Create PR
        uses: peter-evans/create-pull-request@v8
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          commit-message: "actions: readme translation"
          branch: "docs/readme"
          title: "README translation on ${{ github.event.inputs.Language }}"
          body: "AI-powered translation of a README file"
          add-paths: |
            ${{ github.event.inputs.Output }}
```

### Go Build and Testing

Процесс тестирования и сборки Go приложений с выгрузкой артифактов.

```yaml
name: CI (Build and Testing)

on:
  workflow_dispatch:
    inputs:
      # Параметр выпадающего списка для выбора
      # Список доступных дистрибутивов на публичных сборщиках: https://github.com/actions/runner-images
      Distro:
        description: 'Select runner image'
        required: true
        default: 'ubuntu-24.04'
        type: choice
        options:
          - 'ubuntu-22.04'
          - 'ubuntu-24.04'
          - 'macos-26'
          - 'macos-15'
          - 'windows-2025'
          - 'windows-2022'
      # Обновление зависимостей
      Update:
        description: 'Update dependencies'
        default: false
        type: boolean
      # Статическая проверка кода
      Linters:
        description: 'Go linters check'
        default: false
        type: boolean
      # Запуск unit тестов
      Test:
        description: 'Go unit testing'
        default: false
        type: boolean
      # Сборка
      Binary:
        description: 'Build binary and deb packages'
        default: false
        type: boolean

# Определяем индивидуальное название для каждой сборки
run-name: "Build #${{ github.run_number }} on ${{ github.event.inputs.Distro }}"

jobs:
  test:
    name: Testing on ${{ github.event.inputs.Distro }}

    runs-on: ${{ github.event.inputs.Distro }}

    # Объявляем переменные окружения, которые будут использоваться в процессе сборки
    env:
      APP_NAME: 'app'
      APP_VERSION: 'latest'
      COVERAGE: 'n/a'

    steps:
      - name: Checkout repository (main branch and 1 last commits)
        uses: actions/checkout@v4
        with:
          fetch-depth: 1
          ref: main

      # Установка Go указанной версии
      - name: Install Go
        uses: actions/setup-go@v5
        with:
          go-version: 1.25

      # Форматирование, статический анализ, установка зависимостей и проверка компиляции
      - name: Install dependencies
        run: |
          go fmt ./...
          go vet ./...
          go get ./...
          go mod tidy
          go mod verify
          go build -v ./...

      # Извлекаем версию приложения и сохраняем ее в переменные окружения для использования в других шагах
      - name: Get app version in gh env for build
        run: |
          version=$(go run main.go -v)
          echo "APP_VERSION=$version" >> $GITHUB_ENV

      # Обновление зависимостей в go.mod
      - name: Update dependencies
        if: ${{ github.event.inputs.Update == 'true' }}
        run: go get -u ./...

      # Устанавливаем пакет golangci-lint и запуск анализа кода
      - name: Golangci linters check
        if: ${{ github.event.inputs.Linters == 'true' }}
        # Исключаем падение всего шага при ошибке (last exit code != 0)
        continue-on-error: true
        run: |
          go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
          golangci-lint run -v ./main.go

      # Запуск unit тестов и записываем результат в лог файл
      - name: Unit testing
        if: ${{ github.event.inputs.Test == 'true' }}
        # Ограничиваем время выполнения
        timeout-minutes: 10
        continue-on-error: true
        run: sudo env "PATH=$PATH" go test -v -cover | tee test.log

      # Извлекаем результат покрытия кода и публикуем на страницу сборки в формате Markdown
      - name: Unit testing
        if: ${{ github.event.inputs.Test == 'true' }}
        continue-on-error: true
        run: |
          COVERAGE=$(cat test.log | tail -n 2 | head -n 1 | sed "s/coverage: //" | sed -E "s/of.+//g")
          echo "## Test results" >> $GITHUB_STEP_SUMMARY
          echo -e "Version: $APP_VERSION" >> $GITHUB_STEP_SUMMARY
          echo -e "Coverage: $COVERAGE" >> $GITHUB_STEP_SUMMARY

      # Собираем приложение для разных ОС и архитектур
      - name: Build binaries
        if: ${{ github.event.inputs.Binary == 'true' }}
        run: |
          mkdir -p bin
          architectures=("amd64" "arm64")
          oss=("linux" "darwin" "openbsd" "freebsd" "windows")
          for arch in "${architectures[@]}"; do
              for os in "${oss[@]}"; do
                  binName="bin/$APP_NAME-$APP_VERSION-$os-$arch"
                  if [[ "$os" == "windows" ]]; then
                      binName="$binName.exe"
                  fi
                  CGO_ENABLED=0 GOOS=$os GOARCH=$arch go build -o "$binName"
              done 
          done
          ls -lh bin
          # Формируем названия архива для выгрузки артефактов
          echo "ARTIFACT_NAME=$APP_NAME-$APP_VERSION" >> $GITHUB_ENV

      # Выгружаем все файлы из директории bin в артефакты GitHub
      - name: Upload binaries
        if: ${{ github.event.inputs.Binary == 'true' }}
        uses: actions/upload-artifact@v4
        with:
          name: ${{ env.ARTIFACT_NAME }}
          path: bin/
        env:
          ARTIFACT_NAME: ${{ env.ARTIFACT_NAME }}
```

### Ubuntu PPA Repository

Создание и подготовка PPA (Personal Package Archives) репозитория для публикации `deb` пакетов.

Генерируем ключ:

`gpg --gen-key`

Получить путь к `pubring.kbx`, а также спислк всех ключей с их отпечаток и сроком действия:

`gpg --list-secret-keys --keyid-format=long`

Получить приватный ключ по email или отпечатку:

`gpg --armor --export-secret-keys lifailon@main.com` \

Отправляем ключ на сервер ключей Ubuntu:

`gpg --keyserver keyserver.ubuntu.com --send-keys <ОТПЕЧАТОК>`

Поиск ключа на сервере ключей: https://keyserver.ubuntu.com

Импортируем ключ: https://launchpad.net/~lifailon/+editpgpkeys \
Выбираем: `Import an OpenPGP key` \
Вставляем отпечаток в `Fingerprint` и нажимаем `Import Key` \
Дожидаемся сообщение на почту, указанную в ключе

Расшифровать содержимое `pgp` сообщения в формате `BEGIN PGP MESSAGE`:

`gpg --decrypt pgp.txt`

Переходим по полученной ссылке после расшифровки и подтверждаем добавление ключа.

Загружаем Ubuntu Codes of Conduct последней версии: https://launchpad.net/codeofconduct/2.0

Подписываем кодекс поведения:

`gpg -u A60D863D --clearsign UbuntuCodeofConduct-2.0.txt` \
`cat UbuntuCodeofConduct-2.0.txt.asc` \
Переходим по ссылке: https://launchpad.net/codeofconduct \
Нажимаем `Sign it!` и вставляем содержимое `UbuntuCodeofConduct-2.0.txt.asc`

После этих действий создаем PPA репозиторий.

Идем в настройки репозитория: \
https://launchpad.net/~<userName>/+archive/ubuntu/<ppaName>/+edit \
Добавляем `amd64` и `arm64` в `Processors` для мультиархитектурной сборки

### Ubuntu Build and Push

Использование данного подхода может сэкономить много времени на подготовке к сборке и публикации Go приложения в PPA.

```yaml
name: Build deb package and push to PPA

on:
  workflow_dispatch:
    inputs:
      # Запустить только установку
      Install:
        description: 'Check install only'
        default: false
        type: boolean
      # Дистрибутив на котором будет производиться сборка
      # Это влияет на название версии дистрибутива Ubuntu в файле changelog по умолчанию
      Runner:
        description: 'Select runner image'
        required: true
        default: 'ubuntu-22.04'
        type: choice
        options:
          - 'ubuntu-24.04' # noble
          - 'ubuntu-22.04' # jammy
      # Название дистрибутива Ubuntu для обновления в файле changelog
      Distro:
        description: 'Ubuntu distro name in changelog'
        required: true
        default: 'jammy'
        type: choice
        options:
          - 'resolute' # 26.04
          - 'questing' # 25.10
          - 'noble'    # 24.04
          - 'jammy'    # 22.04
          - 'focal'    # 20.04
          - 'bionic'   # 18.04
          - 'xenial'   # 16.04
          - 'trusty'   # 14.04
      # Обновить версию в changelog (для пересборок)
      Version:
        description: 'Version for build'
        required: false
        default: '' # 0.8.4 -> 0.8.4.1 -> 0.8.4.2
      # Публикация в репозитория PPA
      Push:
        description: 'Push to PPA'
        default: false
        type: boolean

jobs:
  test:
    name: Build deb package and push to PPA

    runs-on: ${{ github.event.inputs.Runner }}

    steps:
      - name: Checkout repository (main branch and 1 last commits)
        uses: actions/checkout@v6
        with:
          fetch-depth: 1
          ref: main

      # Шаг проверки установки пакета
      - name: Check install package from PPA
        if: ${{ github.event.inputs.Install == 'true' }}
        run: |
          sudo add-apt-repository -y ppa:lifailon/lazyjournal
          sudo apt update
          apt-cache policy lazyjournal
          sudo apt install -y lazyjournal
          lazyjournal -v
          sudo apt remove -y lazyjournal

      # Устанавливаем Go
      - name: Install Go
        if: ${{ github.event.inputs.Install != 'true' }}
        run: |
          sudo apt-get update
          sudo apt-get install -y golang-1.23-go
          /usr/lib/go-1.23/bin/go version

      # Устанавливаем зависимости для сборки
      - name: Install dependencies for build deb package
        if: ${{ github.event.inputs.Install != 'true' }}
        run: |
          sudo apt-get install -y \
            devscripts \
            debhelper \
            dh-golang \
            dh-make-golang \
            dput \
            golang-golang-x-text-dev \
            golang-gopkg-yaml.v3-dev

      # Импортируем GPG ключ из секретов в систему
      - name: Import GPG key
        if: ${{ github.event.inputs.Install != 'true' }}
        uses: crazy-max/ghaction-import-gpg@v6
        with:
          gpg_private_key: ${{ secrets.PPA_GPG_PRIVATE_KEY }}

      - name: Build deb package and publish to Launchpad PPA
        if: ${{ github.event.inputs.Install != 'true' }}
        env:
          DEB_FULLNAME: "lifailon"
          DEB_EMAIL: ${{ secrets.PPA_EMAIL }}
          DISTRO: ${{ github.event.inputs.Distro }}
          APP_VERSION: ${{ github.event.inputs.Version }}
        run: |
          # Объявляем переменные для локальной сборки
          export PATH="/usr/lib/go-1.23/bin:$PATH"
          # Не загружать зависимости
          export GOTOOLCHAIN=local
          export DEBFULLNAME="$DEB_FULLNAME"
          # Email из gpg ключа
          export DEBEMAIL="$DEB_EMAIL"
          
          # Генерируем Debia шаблоны (структуру файлов и каталогов) для Go приложения
          echo -e "\n\033[33m>>> Debian template generation\033[0m\n"
          dh-make-golang make github.com/Lifailon/lazyjournal
          cd lazyjournal

          # Загружаем все зависимости (используемые пакеты) и обновляем архив для сборки без интернета на серверах Ubuntu
          echo -e "\n\033[33m>>> Download dependencies for offline build\033[0m\n"
          go mod vendor
          VERSION=$(ls ../*.orig.tar.gz | sed -E 's/.*_([0-9.]+)\.orig\.tar\.gz/\1/')
          rm ../*.orig.tar.gz
          tar --exclude-vcs -C .. -czf ../lazyjournal_$VERSION.orig.tar.gz lazyjournal
          sed -i '1a export GOFLAGS=-mod=vendor' debian/rules

          # Обновляем версию Go на актуальную во избежание ошибок при сборке
          echo -e "\n\033[33m>>> Update go version\033[0m\n"
          sed -i 's/golang-any/golang-1.23-go/' debian/control
          # Экспортируем путь к Go в основной Makefile для сборки
          sed -i '1a export PATH := /usr/lib/go-1.23/bin:$(PATH)' debian/rules
          sed -i '1a export GOTOOLCHAIN := local' debian/rules

          # Обновляем секцию TODO в файл debian control для избежания ошибок
          echo -e "\n\033[33m>>> Update debian control\033[0m\n"
          sed -i 's/Section: TODO/Section: utils/' debian/control
          # Используем мультиархитектурную сборку
          sed -i -E 's/Architecture:.+/Architecture: any/' debian/control

          # Пропускаем встроенные тесты и dwz проверки
          echo -e "\n\033[33m>>> Skip go test and dwz in build\033[0m\n"
          # export DEB_BUILD_OPTIONS=nocheck
          printf "\noverride_dh_auto_test:\n\t:\n" >> debian/rules
          printf "\noverride_dh_dwz:\n\t:\n" >> debian/rules
          echo -e "\n\033[33m>>> Rules\033[0m\n"
          cat debian/rules

          # Обновляем название дистрибутива
          echo -e "\n\033[33m>>> Update distro name in changelog\033[0m\n"
          sed -i "1s/)[[:space:]]\+[^;]\+;/) $DISTRO;/" debian/changelog
          sed -i 's/(Closes: TODO)//' debian/changelog
          
          # Обновляем версию (если значение определено в параметре)
          if [ -n "$APP_VERSION" ]; then
            echo -e "\n\033[33m>>> Update version in changelog\033[0m\n"
            VERSION=$(cat debian/changelog | head -n 1 | sed -E "s/.+\(//" | sed -E "s/\).+//" | sed -E "s/-[0-9]+//")
            sed -i -E "s/$VERSION-/$APP_VERSION-/" debian/changelog
            mv ../lazyjournal_$VERSION.orig.tar.gz ../lazyjournal_$APP_VERSION.orig.tar.gz
            echo -e "\n\033[33m>>> Changelog\033[0m\n"
            cat debian/changelog
          fi

          # Проверяем сборку (эта команда выполняется на серверах Ubuntu перед публикацией)
          echo -e "\n\033[33m>>> Check build\033[0m\n"
          dpkg-buildpackage -us -uc -b

          # Собираем файл changes
          echo -e "\n\033[33m>>> Build changes\033[0m\n"
          rm -f ../*.upload ../*.changes
          debuild -S -sa -k"$DEBEMAIL"
          cd ..
          ls *.changes

      # Публикуем пакет в репозиторий PPA
      - name: Push to PPA
        if: ${{ github.event.inputs.Install != 'true' && github.event.inputs.Push == 'true' }}
        run: |
          dput ppa:lifailon/lazyjournal *.changes
```

API запрос для получения версии и создание динамического бейджа в [Shields](https://shields.io/badges/dynamic-json-badge) c помощью json запрос.

```bash
apiUrl="https://api.launchpad.net/1.0/~lifailon/+archive/ubuntu/lazyjournal?ws.op=getPublishedSources&distro_series=https://api.launchpad.net/1.0/ubuntu/jammy&status=Published"
apiQuery="entries[0].source_package_version"
curl -sS "$apiUrl" | jq ".$apiQuery"

# Кодируем URL
ppaUrl=$(jq -rn --arg url "$apiUrl" '$url | @uri')

# Формируем динамический json запрос в Shields для получения бейджа с версией
echo "https://img.shields.io/badge/dynamic/json?url=$ppaUrl&query=$apiQuery&label=Ubuntu+PPA&logo=ubuntu&color=orange"
```

### Composite Action

Пример создания своего Action для подключения в Workflow других проектах на примере объединения результатов unit-тестирования в Go приложении с использованием [gocovmerge](https://github.com/wadey/gocovmerge).

```yaml
name: 'Go Coverage Merge Action'
description: 'Merges multiple Go coverage profiles using gocovmerge'
author: 'Lifailon'

inputs:
  go-version:
    description: 'Go version'
    required: false
    default: 'stable'
  input-pattern:
    description: 'Glob pattern for coverage files'
    required: false
    default: '*.out'
  output-coverage:
    description: 'Output merged filename'
    required: false
    default: 'summary.out'

runs:
  using: composite
  steps:
    - name: Install Go
      uses: actions/setup-go@v6
      with:
        go-version: ${{ inputs.go-version }}

    - name: Install gocovmerge
      shell: bash
      run: go install github.com/wadey/gocovmerge@latest

    - name: Merge files
      shell: bash
      run: |
        files=$(ls ${{ inputs.input-pattern }})
        if [ -z "$files" ]; then
          echo "No coverage files found for pattern: ${{ inputs.input-pattern }}"
          exit 1
        fi
        gocovmerge $files > "${{ inputs.output-coverage }}"

    - name: Summary
      shell: bash
      run: go tool cover -func "${{ inputs.output-coverage }}"
```

Использование в Workflow:

```yaml
- name: Go coverage merge
  uses: Lifailon/gocovmerge-action@v1
  with:
    pattern: 'coverage/*.out'
    output: 'coverage/total.out'
```

### Repository Dispatch

[Repository Dispatch](https://github.com/peter-evans/repository-dispatch) используется для отправки запроса из скрипта или другой системы для запуска Workflow.

Создаем действие для реакции на событие:

```yaml
name: Webhook Payload

on:
  repository_dispatch:
    # Workflow запустится только если event_type совпадает с одним из списка
    types: [script_run, action_run]

jobs:
  payload:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Check version
        run: |
          echo "App version: ${{ github.event.client_payload.app_version }}"
          echo "Run tests: ${{ github.event.client_payload.run_tests }}"
```

Отправляем запрос для вызова события:

```bash
userName=Lifailon
repoName=lazyjournal
token=ghp_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

curl -X POST "https://api.github.com/repos/$userName/$repoName/dispatches" \
    -H "Authorization: token $token" \
    -H "Accept: application/vnd.github.v3+json" \
    -d '{
      "event_type": "script_run", 
      "client_payload": {
        "app_version": "0.8.5",
        "run_tests": true
      }
    }'
```

Использует workflow для вызова события:

```yaml
jobs:
  Dispatch:
    runs-on: ubuntu-latest
    permissions:
      contents: write
     steps:
       - name: Repository Dispatch
         uses: peter-evans/repository-dispatch@v4
         with:
           event-type: action_run
```

### Actions API

```PowerShell
$userName = "Lifailon"
$repoName = "lazyjournal"

# Получить количество всех рабочих процессов
$(Invoke-RestMethod https://api.github.com/repos/$userName/$repoName/actions/workflows).total_count
# Подробная информации о запускаемых рабочих процессах
$(Invoke-RestMethod https://api.github.com/repos/$userName/$repoName/actions/workflows).workflows
# Получить идентификатор первого workflow
$workflowId = $(Invoke-RestMethod https://api.github.com/repos/$userName/$repoName/actions/workflows).workflows[0].id
# Подробная информация о последней сборке
$(Invoke-RestMethod https://api.github.com/repos/$userName/$repoName/actions/workflows/$workflowId/runs).workflow_runs
# Получить идентификатор последнего запуска указанного workflow
$lastRunId = $(Invoke-RestMethod https://api.github.com/repos/$userName/$repoName/actions/workflows/$workflowId/runs).workflow_runs.id[0]
# Подробная информация для всех шагов выполнения (время работы и статус выполнения из conclusion)
$(Invoke-RestMethod "https://api.github.com/repos/$userName/$repoName/actions/runs/$lastRunId/jobs").jobs.steps

# Получить идентификатор последнего jobs в конкретной сборке
$lastJobsId = $(Invoke-RestMethod "https://api.github.com/repos/$userName/$repoName/actions/runs/$lastRunId/jobs").jobs[-1].id
# Отобразить логи выполнения указанного задания
$url = "https://api.github.com/repos/$userName/$repoName/actions/jobs/$lastJobsId/logs"
$headers = @{
    Authorization = "token ghp_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}
Invoke-RestMethod -Uri $url -Headers $headers
```

### Actions locally

[act](https://github.com/nektos/act) - пользволяет запускать действия GitHub Actions локально (используется в [Gitea](https://github.com/go-gitea/gitea)).

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

## Groovy

[Apache Groovy](https://groovy-lang.org) - скриптовый язык для `JVM`, похожий на Java по стилю и синтаксису, но не требующий компиляции (как `PowerShell` в экосистеме `.NET`). Используется для описания в DSL (Domain-Specific Language) формате, например, процесса сборки Java-приложений в [Gradle](https://github.com/gradle/gradle) и Jenkins Pipeline.

Базовый синтаксис:

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
// Ждем завершения всех потоков
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

(versions[1].toInteger() + 1).toString().padLeft(4, '0') // 0019 + 1 = 0020 ("19".padLeft(4, '0') -> "0019")
```

## Gradle

```groovy
// Подключаем плагины для работы с Java
plugins {
    id 'java'
    // Плагин для сборки исполняемого jar и запуска приложения
    id 'org.springframework.boot' version '3.2.0'
    // Плагин для автоматического управления версиями зависимостей Spring
    id 'io.spring.dependency-management' version '1.1.4'
}

// Метаданные проекта
group = 'com.example'
version = '1.0.0'

// Настраиваем репозитории, откуда Gradle будет качать библиотеки
repositories {
    mavenCentral()
}

// Описание зависимостей
dependencies {
    // Основной стартер для создания веб-приложений (включает Tomcat и Jackson)
    implementation 'org.springframework.boot:spring-boot-starter-web'
    // Библиотека для работы с JSON
    implementation 'com.google.code.gson:gson:2.10.1'
    // Библиотека для тестов (Spring Boot Starter Test уже включает JUnit 5)
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

// Настройка встроенной задачи (task) для тестирования
test {
    useJUnitPlatform()
}
```

## Jenkins

`docker run -d --name=jenkins -p 8080:8080 -p 50000:50000 --restart=unless-stopped -v jenkins_home:/var/jenkins_home jenkins/jenkins:latest` \
`ls /var/lib/docker/volumes/jenkins_home/_data/jobs` директория хранящая историю сборок в хостовой системе \
`docker exec -it jenkins /bin/bash` подключиться к контейнеру \
`cat /var/jenkins_home/secrets/initialAdminPassword` получить токен инициализации

```bash
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

| Плагин                                                                                            | Описание                                                                                                                        |
| -                                                                                                 | -                                                                                                                               |
| [Pipeline Nodes and Processes](https://jenkins.io/doc/pipeline/steps/workflow-durable-task-step)  | Плагин, который предоставляет доступ к интерпретаторам `sh`, `bat`, `powershell` и `pwsh`                                       |
| [Pipeline Utility Steps](https://jenkins.io/doc/pipeline/steps/pipeline-utility-steps)            | Добавляет методы `readJSON`, `writeJSON`, `readYaml`, `writeYaml`, `readTOML`, `writeTOM`, `untar`, `unzip`, и другие           |
| [HTTP Request](https://plugins.jenkins.io/http_request)                                           | Простой `REST` API Client для отправки и обработки `GET` и `POST` запросов через метод `httpRequest(url: url, httpMode: "GET")` |
| [Credentials Binding](https://jenkins.io/doc/pipeline/steps/credentials-binding)                  | Добавляет метод `withCredentials` для доступа к секретам                                                                        |
| [HashiCorp Vault](https://plugins.jenkins.io/hashicorp-vault-plugin)                              | Автоматизирует процесс получения содержимого значений из `HashCorp Vault` с помощью метода `withVault`                          |
| [Ansible](https://plugins.jenkins.io/ansible)                                                     | Параметраризует запуск `ansible-playbook` (требуется установка на агенте) через метод `ansiblePlaybook`                         |
| [SSH Pipeline Steps](https://plugins.jenkins.io/ssh-steps)                                        | Плагин для подключения к удаленным машинам через протокол `ssh` по ключу или паролю                                             |
| [SSH Agent](https://www.jenkins.io/doc/pipeline/steps/ssh-agent)                                  | Плагин для подключения к удаленным машинам с использованием `ssh-agent` и `Credentials`                                         |
| [Pipeline Stage View](https://plugins.jenkins.io/pipeline-stage-view)                             | Визуализация шагов (`stages`) в интерфейсе проекта с временем их выполнения                                                     |
| [Rebuilder](https://plugins.jenkins.io/rebuild)                                                   | Позволяет перезапускать параметризованную сборку с предустановленными параметрами в выбранной сборке                            |
| [Schedule Build](https://plugins.jenkins.io/schedule-build)                                       | Позволяет запланировать сборку на указанный момент времени                                                                      |
| [Webhook Trigger](https://plugins.jenkins.io/generic-webhook-trigger)                             | Принимает `POST` запросы на конечной точке `/generic-webhook-trigger/invoke` для извлечения значений и запуска Pipeline         |
| [Job Configuration History](https://plugins.jenkins.io/jobConfigHistory)                          | Сохраняет копию файла сборки в формате `xml` (который хранится на сервере) в истории для сверки                                 |
| [Export Job Parameters](https://plugins.jenkins.io/export-job-parameters)                         | Добавляет кнопку `Export Job Parameters` для конвертации все параметров в декларативный синтаксис Pipeline                      |
| [Active Choices Parameters](https://plugins.jenkins.io/uno-choice)                                | Активные параметры, которые позволяют динамически обновлять содержимое параметров                                               |
| [File Parameters](https://plugins.jenkins.io/file-parameters)                                     | Добавляет параметры для загрузки файлов                                                                                         |
| [Separator Parameter](https://plugins.jenkins.io/parameter-separator)                             | Параметр для визуального разделения набора параметров на странице сборки задания с поддержкой `HTML`                            |
| [Custom Tools](https://plugins.jenkins.io/custom-tools-plugin)                                    | Позволяет загружать пакеты (исполняемые файлы) из Интернета с помощью предустановленного набора команд                          |
| [Copy Artifact](https://plugins.jenkins.io/copyartifact)                                          | Позволяет копировать артифакты из одной сборки в другую (например, из последней успешной `copyArtifacts(projectName: jobName)`) |
| [ANSI Color](https://plugins.jenkins.io/ansicolor)                                                | Добавляет поддержку стандартных escape-последовательностей `ANSI` для покраски вывода                                           |
| [Email Extension](https://plugins.jenkins.io/email-ext)                                           | Отправка сообщений на почту по протоколу `SMTP` из Pipeline                                                                     |
| [Config File Provider](https://plugins.jenkins.io/config-file-provider)                           | Хранение конфигураци (например, `settings.xml` для `Maven`) в интерфейсе Jenkins и их шаблонизация c `Credentials`              |
| [Allure](https://plugins.jenkins.io/allure-jenkins-plugin)                                        | Создает отчеты [Allure](https://allurereport.org) для автотестов в интерфейсе Pipeline с отправкой в TestOps                    |
| [SonarQube Scanner](https://plugins.jenkins.io/sonar)                                             | Интегрирует статический анализ кода с помощью метода [withSonarQubeEnv](https://jenkins.io/doc/pipeline/steps/sonar)            |
| [Test Results Analyzer](https://plugins.jenkins.io/test-results-analyzer)                         | Показывает историю результатов сборки `junit` тестов в табличном древовидном виде                                               |
| [Embeddable Build Status](https://plugins.jenkins.io/embeddable-build-status)                     | Предоставляет настраиваемые значки [Shields](https://shields.io), который возвращает статус сборки                              |
| [Prometheus Metrics](https://plugins.jenkins.io/prometheus)                                       | Предоставляет конечную точку `/prometheus` с метриками, которые используются для сбора данных                                   |
| [Web Monitoring](https://plugins.jenkins.io/monitoring)                                           | Добавляет конечную точку `/monitoring` для отображения графиков мониторинга в веб-интерфейсе                                    |
| [CloudBees Disk Usage](https://plugins.jenkins.io/cloudbees-disk-usage-simple)                    | Отображает использование диска всеми заданиями во вкладке `Manage-> Disk usage` для анализа                                     |

### Credentials

Примеры использования метода `withCredentials` для извлечения и использования секретов:

```Groovy
withCredentials([string(
  credentialsId: 'github-token', variable: 'TOKEN'
)]) {
  sh 'curl -H "Authorization: Bearer $TOKEN" https://api.github.com/rate_limit'
}

withCredentials([usernamePassword(
  credentialsId: 'nexus-creds',
  usernameVariable: 'NEXUS_USER',
  passwordVariable: 'NEXUS_PASS'
)]) {
  sh 'echo "$NEXUS_PASS" | docker login -u "$NEXUS_USER" --password-stdin registry.example.com'
}

withCredentials([sshUserPrivateKey(
  credentialsId: params.credentials,
  usernameVariable: 'SSH_USER',
  keyFileVariable: 'SSH_KEY',
  passphraseVariable: ''
)]) {
    // sh 'GIT_SSH_COMMAND="ssh -i $SSH_KEY -o StrictHostKeyChecking=no" git fetch'
    writeFile(file: env.SSH_KEY_FILE, text: readFile(SSH_KEY))
    sh "chmod 600 ${env.SSH_KEY_FILE}"
}

withCredentials([file(
  credentialsId: 'google-cloud-key',
  variable: 'KEYFILE'
)]) {
  sh 'gcloud auth activate-service-account --key-file="$KEYFILE"'
}
```

### configFile

Загрузка конфигурации из Jenkins:

```Groovy
configFileProvider([configFile(
    fileId: 'dev-config',
    variable: 'DEV_CONFIG'
)]) {
    sh "cp ${DEV_CONFIG} devsecops-config.yml"
}
def config = readYaml(
    file: 'dev-config.yml'
)
```

### SSH Agent

```Groovy
sshagent (credentials: ['d5da50fc-5a98-44c4-8c55-d009081a861a']) {
  sh 'ssh -o StrictHostKeyChecking=no -l lifailon 192.168.3.101 uname -a'
}
```

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
                            'Lifailon/$APP_NAME',
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

### withVault

Команда (скрипт) для загрузки `kubectl` в Custom tool:

```bash
mkdir -p ./bin
curl https://dl.k8s.io/release/v1.33.3/bin/linux/amd64/kubectl -sSLo ./bin/kubectl
chmod +x ./bin/kubectl
# Домашний каталог утилиты: bin
```
Получение секретов (на примере содержимого `kubeconfig`) с помощью метода `withVault`:
```Groovy
def log = {
    def m = [:]
    m.info = { text -> echo "\u001B[34m${text}\u001B[0m" }
    m.success = { text -> echo "\u001B[32m${text}\u001B[0m" }
    m.error = { text -> echo "\u001B[31m${text}\u001B[0m" }
    return m
}()

pipeline {
    agent any
    options {
        ansiColor("xterm")
        timestamps()
        timeout(time: 10, unit: "MINUTES")
    }
    environment {
        KUBECONFIG = "${WORKSPACE}/kubeconfig"
        KUBECTLPATH = tool(
            name: "kubectl-amd64-1.33.3",
            type: "com.cloudbees.jenkins.plugins.customtools.CustomTool"
        )
        PATH = "${KUBECTLPATH}:${env.PATH}"
    }
    parameters {
        separator(
            name: "separatorVault",
            sectionHeader: "Vault",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        string(
            name: "vaultUrl",
            defaultValue: "http://192.168.3.101:8200",
            description: "Адрес Vault"
        )
        string(
            name: "vaultPath",
            defaultValue: "v1/kv/kube",
            description: "Путь к секретам в Vault (где хранится ключ config с содержимым kubeconfig)"
        )
        credentials(
            name: "vaultAppRole",
            credentialType: "com.datapipe.jenkins.vault.credentials.VaultAppRoleCredential",
            defaultValue: "main_approle",
            description: "AppRole для доступа на чтение секретов из Vault"
        )
        separator(
            name: "separatorDebug",
            sectionHeader: "Debug",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        booleanParam(
            name: "checkConfig",
            defaultValue: true,
            description: "Проверить содержимое kubeconfig и версию kubectl"
        )
        // text(name: "multiLine", defaultValue: "line1\nline2")
        // choice(name: "addresses", choices: ["192.168.3.101", "192.168.3.105","192.168.3.106"])
        // password(name: "token", defaultValue: "YWRtaW4K")
        // credentials(name: "sshKey", credentialType: "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey", defaultValue: "d5da50fc-5a98-44c4-8c55-d009081a861a", required: true)
        // activeChoice(
        //     name: "activeChoicesParameter", choiceType: "PT_CHECKBOX", filterable: true,
        //     script: [$class: "GroovyScript", box: true, script: [script: '''return ["1","2","3"]''']]
        // )
        // reactiveChoice(
        //     name: "activeChoicesReactiveParameter", choiceType: "PT_RADIO", filterable: false,
        //     referencedParameters: "activeChoicesParameter",
        //     script: [$class: "GroovyScript", box: true, script: [script: '''return [activeChoicesParameter]''']]
        // )
    }
    stages {
        stage("Get kubeconfig from Vault") {
            steps {
                script {
                    // Конфигурация для подключения к Vault
                    def vaultConfiguration = [
                        vaultUrl:           params.vaultUrl,
                        vaultCredentialId:  params.vaultAppRole,
                        engineVersion:      1
                    ]
                    // Переменная для извлечения секретов
                    def vaultSecrets  = [
                        [
                            path: params.vaultPath,
                            engineVersion: 1,
                            secretValues: [
                                [
                                    envVar: "kubeconfig", // название переменной
                                    vaultKey: "config"    // ключ в Vault
                                ]
                            ]
                        ]
                    ]
                    // Метод извлечения секретов из Vault
                    withVault(
                        [
                            configuration:  vaultConfiguration,
                            vaultSecrets:   vaultSecrets
                        ]
                    ) {
                        // Записываем содержимое в файл
                        writeFile(
                            file: "${WORKSPACE}/kubeconfig", // Не принимает переменные из environment
                            text: kubeconfig
                        )
                    }
                }
            }
        }
        stage("Check kubeconfig and kubectl") {
            when {
                expression { params.checkConfig }
            }
            steps {
                script {
                    log.info("Проверяем содержимое kubeconfig")
                    def kubeconfig = readFile(
                        file: KUBECONFIG
                    )
                    if (kubeconfig.trim().length() == 0) {
                        log.error("Конфигурация отсутствует (файл kubeconfig пустой)")
                    } else {
                        def firstLine = kubeconfig.split("\n")[0]
                        log.success("Конфигурация получена")
                        log.success(firstLine)
                    }
                    log.info("Проверка версии kubectl")
                    def kubectlVersion = sh(
                        script: """
                            kubectl version --output=json || true
                        """,
                        returnStatus: false, // Возвращяет код возврата если true (для проверки или игнорирования ошибок)
                        returnStdout: true   // Возвращяет вывод в переменную
                    )
                    log.success(kubectlVersion)
                }
            }
        }
    }
    post {
        always {
            script {
                sh(
                    script: """
                        ls -lh
                        rm -rf ./*
                        ls -lh
                    """
                )
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

### SimpleTemplateEngine

[SimpleTemplateEngine](https://github.com/groovy/groovy-core/blob/master/subprojects/groovy-templates/src/main/groovy/groovy/text/SimpleTemplateEngine.java) - простой движок шаблонов, который встроен в язык Groovy. Он принимает текст, в котором заменяет значения на содержимое переданных переменных.

Шаблон для подстановки значений:

```yaml
apiVersion: v1
kind: Config
current-context: ${contextName}
preferences: {}

clusters:
- name: ${contextName}-ctx
  cluster:
    server: ${clusterUrl}

users:
- name: ${contextName}-usr
  user:
    token: ${token}

contexts:
- name: ${contextName}
  context:
    cluster: ${contextName}-ctx
    namespace: ${namespace}
    user: ${contextName}-usr
```

Запускаем рендеринг (шаблонизируем конфигурацию):

```groovy
import groovy.text.SimpleTemplateEngine

def renderTemplate(String fileName, Map varMap) {
    def templateFile = readFile(fileName)
    def outputFile = fileName.replace('.tmpl', '').replace('.tmp', '')
    echo "\n\u001B[34mRender template: ${fileName} => ${outputFile}\u001B[0m\n"
    def engine = new SimpleTemplateEngine()
    def result = engine.createTemplate(templateFile).make(varMap).toString()
    writeFile file: outputFile, text: result
    return "\u001B[34m${result}\u001B[0m"
}

pipeline {
    agent {
        label "masterLin"
    }
    options {
        ansiColor("xterm")
        timestamps()
        timeout(time: 5, unit: "MINUTES")
    }
    stages {
        stage("Render kubeconfig") {
            steps {
                script {
                    def varMap = [
                        contextName: 'ctx-test',
                        clusterUrl: 'https://api.test.local:6443',
                        namespace: 'ns-test',
                        token: 'KEY'
                    ]
                    def result = renderTemplate('templates/kubeconfig.tmp', varMap)
                    echo result
                }
            }
        }
    }
}
```

Пример условий и циклов:

```yaml
apiVersion: v1
kind: Config
current-context: <%= clusters[0].name %>
preferences: {}

clusters:
<% clusters.each { c -> %>
- name: ${c.name}-cluster
  cluster:
    server: ${c.url}
<% } %>

users:
<% clusters.each { c -> %>
<% if (c.token) { %>
- name: ${c.name}-usr
  user:
    token: ${c.token}
<% } %>
<% } %>

contexts:
<% clusters.each { c -> %>
- name: ${c.name}-ctx
  context:
    cluster: ${c.name}-cluster
    namespace: ${c.namespace ?: 'default'}
    user: ${c.token ? c.name + '-usr' : ''}
<% } %>
```

Переменные для заполнения:

```groovy
def varMap = [
    clusters: [
        [
            name: 'ctx-01',
            url: 'https://api.test-01.local:6443',
            namespace: 'ns-test',
            token: 'token'
        ],
        [
            name: 'ctx-02',
            url: 'https://api.test-02.local:6443',
            namespace: 'ns-test',
            token: 'token'
        ],
        [
            name: 'ctx-03',
            url: 'https://api.test-03.local:6443'
            // namespace и token отсутствуют, в шаблоне сработает default и проверка на null
        ]
    ]
]
```

### YamlSlurper

[YamlSlurper](https://docs.groovy-lang.org/latest/html/api/groovy/yaml/YamlSlurper.html) - преобразует `YAML` файлы в объекты Groovy (списки и мапы), например, для чтения конфигураций с специфичными параметрами для разных окружений и заполнения шаблонов в процессе рендеринга.

```groovy
// @Grab('org.apache.groovy:groovy-yaml:3.0.9')
import groovy.yaml.YamlSlurper

def yamlConfig = '''
clusters:
  dev:
    contextName: "ctx-test"
    clusterUrl: "https://api.test.local:6443"
    namespace: "ns-test"
    token: "TEST_KEY"
  prod:  
    contextName: "ctx-prod"
    clusterUrl: "https://api.prod.local:6443"
    namespace: "ns-prod"
    token: "PROD_KEY"
'''

def config = new YamlSlurper().parseText(yamlConfig)

config.clusters.each { clusterName, varMap ->
    echo "=== Cluster: ${clusterName} ==="
    varMap.each { key, value ->
        echo "${key}: ${value}"
    }
    // renderTemplate('templates/kubeconfig.tmp', varMap)
}
```

## IaC

### Ansible

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

`ansible --version`

Конфигурация настроек Ansible в файле `/etc/ansible/ansible.cfg`

```yaml
[defaults]
inventory = /etc/ansible/hosts
# Отключить проверку ключа ssh (для подключения используя пароль)
host_key_checking = False
```
Настройка списка групп хостов в файле `/etc/ansible/hosts`
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

#### Windows Modules

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
#### Jinja

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

### Puppet/Bolt

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

`echo name: $APP_NAME > bolt-project.yaml` создать файл проекта

`mkdir plans && nano test.yaml` создать директорию и файл с планом работ
```yaml
parameters:
  targets:
    type: TargetSpec

steps:
  - name: clone
    command: rm -rf $APP_NAME && git clone https://github.com/Lifailon/$APP_NAME
    targets: $targets

  - name: test
    command: cd $APP_NAME && go test -v -cover --run TestMainInterface
    targets: $targets

  - name: remove
    command: rm -rf $APP_NAME
    targets: $targets
```
`bolt plan show` вывести список всех планов

`bolt plan run $APP_NAME::test --inventory inventory.yaml --targets bsd -v` запустить план

### Sake

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
### HashiCorp Vault

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
API Swagger: http://192.168.3.101:8200/ui/vault/tools/api-explorer
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
$urlUpdate = "http://192.168.3.101:8200/v1/kv/data/main-path"
Invoke-RestMethod -Uri $urlUpdate -Method POST -Headers $Headers -Body $Body

# Удалить все секреты
Invoke-RestMethod -Uri "http://192.168.3.101:8200/v1/kv/data/main-path" -Method DELETE -Headers $Headers
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
### HashiCorp Consul

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

Создание экспортера на примере получения метрик температуры всех дисков из [CrystalDiskInfo](https://crystalmark.info/en/software/crystaldiskinfo) с помощью PowerShell и отправки в [Prometheus](https://github.com/prometheus/prometheus) через [PushGateway](https://github.com/prometheus/pushgateway).

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

## PromQL

Функции `PromQL`:

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

## Cloud

### AWS/LocalStack

Установка [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions):
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip
```

Настройка профиля по умолчанию:

```bash
aws configure # --profile localstack
AWS Access Key ID: test
AWS Secret Access Key: test
Default region name: us-east-1
Default output format: json
```

Переменные окружения для подключения к облаку или localstack:

```bash
export AWS_ENDPOINT_URL="http://192.168.3.101:4566"
# export AWS_ACCESS_KEY_ID="test"
# export AWS_SECRET_ACCESS_KEY="test"
# export AWS_DEFAULT_REGION="us-east-1"
# Windows
$env:AWS_ENDPOINT_URL="http://192.168.3.101:4566"
```

#### S3

Создание s3 хранилища:

```bash
aws --endpoint-url=http://192.168.3.101:4566 --profile localstack s3 mb s3://test-bucket
aws --endpoint-url=http://192.168.3.101:4566 --profile localstack s3 ls
```

#### Fluent Bit

Запускаем [localstack](https://github.com/localstack/localstack) вместе с [fluent-bit](https://github.com/fluent/fluent-bit) для пересылки логов:

```yaml
services:
  localstack:
    image: localstack/localstack
    container_name: localstack
    restart: always
    ports:
      - 4566:4566
      - 4510-4559:4510-4559
    environment:
      - DEBUG=1
      - PERSISTENCE=1
      - EXTRA_CORS_ALLOWED_ORIGINS=*
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./localstack_data:/var/lib/localstack

  fluent-bit:
    image: fluent/fluent-bit:latest
    container_name: fluent-bit
    ports:
      - 24224:24224
    environment:
      - AWS_ENDPOINT_URL=http://localstack:4566
      - AWS_ACCESS_KEY_ID=test
      - AWS_SECRET_ACCESS_KEY=test
      - AWS_REGION=us-east-1
    volumes:
      - ./fluent-bit.conf:/fluent-bit/etc/fluent-bit.conf
```

Создаем конфигурацию `fluent-bit.conf` для приема логов из контейнеров Docker и их переадресации в AWS CloudWatch:

```ini
[SERVICE]
    Log_Level    info

[INPUT]
    Name  forward
    Listen 0.0.0.0
    Port  24224

[OUTPUT]
    Name                localstack_cloudwatch_logs
    Match               *
    region              us-east-1
    # Автоматическое создание группы, если она отсутствует
    auto_create_group   On
    # Название группы
    log_group_name      docker-logs
    # Название потока, например, container-zerobyte
    log_stream_prefix   container-
    # Адрес сервера localstack
    endpoint            localstack
    port                4566
```

Подключаем драйвер `fluentd` для отправки логов из любого контейнера Docker:

```yaml
    logging:
      driver: fluentd
      options:
        fluentd-address: localhost:24224
        tag: zerobyte
```

#### CloudWatch

Создание группы, потока и запись логов в CloudWatch:

```bash
# Создание группы для хранения логов (Log Group)
aws logs create-log-group --log-group-name "docker-logs"
# Отобразить все группы
aws logs describe-log-groups
# Создание потока для записи логов (Log Stream)
aws logs create-log-stream --log-group-name "docker-logs" --log-stream-name "script-test"
# Отобразить все потоки в группе
aws logs describe-log-streams --log-group-name "docker-logs"
# Отправка лога (Put Log Events)
aws logs put-log-events --log-group-name "docker-logs" --log-stream-name "script-test" --log-events timestamp=$(date +%s000),message="Test message from Bash"
# Windows
$timestamp = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
aws logs put-log-events --log-group-name "docker-logs" --log-stream-name "script-test" --log-events "timestamp=$timestamp,message='Test message from PowerShell'"
# Чтение логов (Get Log Events)
aws logs get-log-events --log-group-name "docker-logs" --log-stream-name "script-test"
# Фильтрация логов
aws logs filter-log-events --log-group-name "docker-logs" --query "events[*].message" --output text 
# Чтение логов из всех потоков за последние сутки
aws logs tail docker-logs --since 1d
```

### Azure

`Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force` установить все модули для работы с Azure \
`Get-Module *Az.*` список всех модулей

`Get-Command -Module Az.Accounts` отобразить список команд модуля Az.Accounts \
`Connect-AzAccount` подключиться у учетной записи Azure \
`Get-AzContext` получить текущий статус подключения к Azure \
`Get-AzSubscription` получить список подписок Azure, доступных для текущего пользователя \
`Set-AzContext` установить контекст Azure для конкретной подписки и/или учетной записи \
`Disconnect-AzAccount` отключиться от учетной записи Azure

`Get-Command -Module Az.Compute` \
`Get-AzVM` получить список виртуальных машин в текущей подписке или группе ресурсов \
`Get-AzVMSize` получить список доступных размеров виртуальных машин в определенном регионе \
`Get-AzVMImage` получить список доступных образов виртуальных машин \
`New-AzVM` создать новую виртуальную машину \
`Remove-AzVM` удалить виртуальную машину \
`Start-AzVM` запустить виртуальную машину \
`Stop-AzVM` остановить виртуальную машину \
`Restart-AzVM` перезагрузить виртуальную машину

`Get-Command -Module Az.Network` \
`Get-AzVirtualNetwork` получить список виртуальных сетей в текущей подписке или группе ресурсов \
`New-AzVirtualNetwork` создать новую виртуальную сеть \
`Remove-AzVirtualNetwork` удалить виртуальную сеть \
`Get-AzNetworkInterface` получить список сетевых интерфейсов \
`New-AzNetworkInterface` создать новый сетевой интерфейс \
`Remove-AzNetworkInterface` удалить сетевой интерфейс

`Get-Command -Module Az.Storage` \
`Get-AzStorageAccount` получить список учетных записей хранилища \
`New-AzStorageAccount` создать новую учетную запись хранилища \
`Remove-AzStorageAccount` удалить учетную запись хранилища \
`Get-AzStorageContainer` список контейнеров в учетной записи хранилища \
`New-AzStorageContainer` создать новый контейнер в учетной записи хранилища \
`Remove-AzStorageContainer` удалить контейнер

`Get-Command -Module Az.ResourceManager` \
`Get-AzResourceGroup` получить список групп ресурсов в текущей подписке \
`New-AzResourceGroup` создать новую группу ресурсов \
`Remove-AzResourceGroup` удалить группу ресурсов \
`Get-AzResource` получить список ресурсов \
`New-AzResource` создать новый ресурс \
`Remove-AzResource` удалить ресурс

`Get-Command -Module Az.KeyVault` \
`Get-AzKeyVault` список хранилищ ключей \
`New-AzKeyVault` создать новое хранилище ключей в Azure \
`Remove-AzKeyVault` удалить хранилище ключей в Azure

`Get-Command -Module Az.Identity` \
`Get-AzADUser` получить информацию о пользователях Azure Active Directory \
`New-AzADUser` создать нового пользователя \
`Remove-AzADUser` удалить пользователя \
`Get-AzADGroup` получить информацию о группах \
`New-AzADGroup` создать новую группу \
`Remove-AzADGroup` удалить группу

- [Manage-VM](https://learn.microsoft.com/ru-ru/azure/virtual-machines/windows/tutorial-manage-vm)

`New-AzResourceGroup -Name "Resource-Group-01" -Location "EastUS"` создать группу ресурсов (логический контейнер, в котором происходит развертывание ресурсов Azure) \
`Get-AzVMImageOffer -Location "EastUS" -PublisherName "MicrosoftWindowsServer"` список доступных образов Windows Server для установки \
`$cred = Get-Credential` \
`New-AzVm -ResourceGroupName "Resource-Group-01" -Name "vm-01" -Location 'EastUS' -Image "MicrosoftWindowsServer:WindowsServer:2022-datacenter-azure-edition:latest" -Size "Standard_D2s_v3" -OpenPorts 80,3389 --Credential $cred` создать виртуальную машину \
`Get-AzVM -ResourceGroupName "Resource-Group-01" -Name "vm-01" -Status | Select @{n="Status"; e={$_.Statuses[1].Code}}` статус виртуальной машины \
`Start-AzVM -ResourceGroupName "Resource-Group-01" -Name "vm-01"` запустить виртуальную машину \
`Stop-AzVM -ResourceGroupName "Resource-Group-01" -Name "vm-01" -Force` остановить виртуальную машину \
`Invoke-AzVMRunCommand -ResourceGroupName "Resource-Group-01" -VMName "vm-01" -CommandId "RunPowerShellScript" -ScriptString "Install-WindowsFeature -Name Web-Server -IncludeManagementTools"` установить роль веб-сервера IIS

- [Manage-Disk](https://learn.microsoft.com/ru-ru/azure/virtual-machines/windows/tutorial-manage-data-disk)

`$diskConfig = New-AzDiskConfig -Location "EastUS" -CreateOption Empty -DiskSizeGB 512 -SkuName "Standard_LRS"` создать диск на 512 Гб \
`$dataDisk = New-AzDisk -ResourceGroupName "Resource-Group-01" -DiskName "disk-512" -Disk $diskConfig` создание объекта диска для подготовки диска данных к работе \
`Get-AzDisk -ResourceGroupName "Resource-Group-01" -DiskName "disk-512"` список дисков \
`$vm = Get-AzVM -ResourceGroupName "Resource-Group-01" -Name "vm-01"` \
`Add-AzVMDataDisk -VM $vm -Name "Resource-Group-01" -CreateOption Attach -ManagedDiskId $dataDisk.Id -Lun 1` подключить диск к виртуальной машине \
`Update-AzVM -ResourceGroupName "Resource-Group-01" -VM $vm` обновить конфигурацию виртуальной машины \
`Get-Disk | Where PartitionStyle -eq 'raw' | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "disk-512" -Confirm:$false` инициализировать диск в ОС (необходимо подключиться к виртуальной машине) с таблицей MBR, создать раздел и назначить все пространство и форматировать в файловую систему NTFS

### Vercel

[Vercel](https://github.com/vercel/vercel) - это бессерверная платформа для публикации веб-приложений и `REST API`.

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

Развертвывание `JavaScript` приложения через GitHub Actions:
```yaml
name: CD (Deploy to Vercel)

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout repository
      uses: actions/checkout@v4

    - name: Install node.js
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
## Proxy

### Traefik

Запускаем контейнере [Traefik](https://github.com/traefik/traefik) в стеке с [Jaeger](https://github.com/jaegertracing/jaeger) для анализа трассировки трафика и [DNS](https://github.com/TechnitiumSoftware/DnsServer) сервером:
```yaml
services:
  traefik:
    image: traefik:v3
    container_name: traefik
    restart: always
    # Используем режим хоста для доступа к сети всех контейнеров 
    network_mode: host
    # ports:
    #   - 8080:8080   # Web UI
    #   - 80:80       # HTTP Proxy
    #   - 443:443     # HTTPS Proxy
    #   - 4318:4318   # Prometheus Metrics
    dns:
      - 127.0.0.1
    volumes:
      - ./traefik.yml:/etc/traefik/traefik.yml
      - ./rules:/rules
      - /var/run/docker.sock:/var/run/docker.sock:ro
    healthcheck:
      test: wget -qO- http://127.0.0.1:8080/ping
      start_period: 10s
      interval: 30s
      timeout: 5s
      retries: 5
    labels:
      # Включаем маршрутизацию и определяем имя хоста
      - traefik.enable=true
      - traefik.http.routers.traefik.rule=Host(`traefik.docker.local`)
      # Указываем порт назначения в контейнере (если используется несколько портов)
      - traefik.http.services.traefik.loadbalancer.server.port=8080
      # Создаем базовую авторизацию
      - traefik.http.middlewares.basic-auth-traefik.basicauth.users=admin:$$2y$$05$$c0r5A6SCKX4R6FjuCgRqrufbIE5tmXw2sDPq1vZ8zNrrwNZIH9jgW # htpasswd -nbB admin admin
      # Включаем базовую авторизацию в маршрутизацию текущего сервиса
      - traefik.http.routers.traefik.middlewares=basic-auth-traefik
      # Настраиваем подключение к Authentik
      # - traefik.http.middlewares.authentik.forwardauth.address=http://192.168.3.101:9000/outpost.goauthentik.io/auth/traefik
      # - traefik.http.middlewares.authentik.forwardauth.trustForwardHeader=true
      # - traefik.http.middlewares.authentik.forwardauth.authResponseHeaders=X-authentik-username,X-authentik-groups,X-authentik-entitlements,X-authentik-email,X-authentik-name,X-authentik-uid,X-authentik-jwt,X-authentik-meta-jwks,X-authentik-meta-outpost,X-authentik-meta-provider,X-authentik-meta-app,X-authentik-meta-version
      # Включаем авторизацию через Authentik из провайдера Docker
      # - traefik.http.routers.traefik.middlewares=authentik@docker
      # Включаем авторизацию через Authentik из провайдера file
      # - traefik.http.routers.traefik.middlewares=authentik@file

  jaeger:
    image: jaegertracing/all-in-one:1.55
    container_name: jaeger
    restart: always
    ports:
      - 16686:16686 # Веб-интерфейс
      - 4317:4317   # Сборщик трассировок

  tech-dns-srv:
    image: technitium/dns-server:latest
    container_name: tech-dns-srv
    restart: always
    volumes:
      - ./dns_data:/etc/dns
    environment:
      - DNS_SERVER_DOMAIN=dns.docker.local
      - DNS_SERVER_FORWARDERS=1.1.1.1,8.8.8.8
      - DNS_SERVER_BLOCK_LIST_URLS=https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
    network_mode: host
    labels:
      - traefik.enable=true
      # Определяем FQDN
      - traefik.http.routers.tech-dns-srv.rule=Host(`dns.docker.local`)
      # Переадресация на порт
      - traefik.http.services.tech-dns-srv.loadbalancer.server.port=5380
```
Конфигурация настроек в файле `traefik.yml`:
```yaml
entryPoints:
  # Настраиваем переадресацию на websecure для принудительного использования HTTPS
  web:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: websecure
          scheme: https
          permanent: true
  websecure:
    address: ":443"
    http:
      tls: {}
    transport:
      keepAliveMaxRequests: 0
      # Определяем время ожидания для неактивного соединения (для поддержания активной сессии)
      respondingTimeouts:
        idleTimeout: "30m"
  # Адрес веб-интерфейса
  traefik:
    address: ":8080"
  # Переопределяем порт для получения метрик
  metrics:
    address: ":4318"

# Включаем веб-интерфейс
api:
  dashboard: true
  insecure: true

# Конечная точка для healthcheck
ping:
  terminatingStatusCode: 204

# Настройка переадресации трассировок в Jaeger
tracing:
  serviceName: traefik
  otlp:
    grpc:
      endpoint: jaeger:4317
      insecure: true

# Включаем prometheus exporter
metrics:
  prometheus:
    entryPoint: metrics
    addRoutersLabels: true
    addServicesLabels: true

# Настраиваем формата логов
log:
  format: "common"  # common or json
  level: "INFO"     # DEBUG, INFO, WARN, ERROR, FATAL and PANIC

# Настройка фильтрации логов доступа
accessLog:
  format: "common"
  filters:
    minDuration: "1ms"
    statusCodes:
      - "200-299"
      - "300-399"
      - "400-499"
      - "500-599"

# Провайдеры для автоматического опредиления сервисов
providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: true
    # Формат по умолчанию при опредиление сервисов compose: <service_name>-<project_name>
    # defaultRule: "Host(`{{ .Name }}.docker.local`)"
    # Шаблон в формате (используем функцию index): index <map> <key>
    defaultRule: "Host(`{{ index .Labels \"com.docker.compose.service\" | default .Name }}.docker.local`)"
  file:
    directory: /rules
    watch: true
```
Настройка дополнительных конфигураций из провайдера `file` в директории `rules` на примере интеграции с [Authentik](https://github.com/goauthentik/authentik) для авторизации с использование технологии `SSO`.

Настройка промежуточной переадресации (между Traefik и веб-приложением) в файле `authentik-middlewares.yml`:
```yaml
http:
  middlewares:
    authentik:
      forwardAuth:
        address: http://192.168.3.101:9000/outpost.goauthentik.io/auth/traefik
        trustForwardHeader: true
        authResponseHeaders:
          - X-authentik-username
          - X-authentik-groups
          - X-authentik-entitlements
          - X-authentik-email
          - X-authentik-name
          - X-authentik-uid
          - X-authentik-jwt
          - X-authentik-meta-jwks
          - X-authentik-meta-outpost
          - X-authentik-meta-provider
          - X-authentik-meta-app
          - X-authentik-meta-version
```
Настройка маршрутизации в файле `authentik-routers.yml`:
```yaml
http:
  routers:
    homepage-src:
      rule: "Host(`home.docker.local`)"
      service: homepage-dst
      entryPoints:
        - websecure
      middlewares:
        - authentik
    dns-src:
      rule: "Host(`dns.docker.local`)"
      service: dns-dst
      entryPoints:
        - websecure

  services:
    homepage-dst:
      loadBalancer:
        servers:
          - url: http://172.26.0.2:3000
    dns-dst:
      loadBalancer:
        servers:
          - url: http://192.168.3.101:5380
```
### HAProxy

Запускаем [HAProxy](https://github.com/haproxy/haproxy) в контейнере Docker:
```yaml
services:
  httpbin-proxy:
    image: haproxy:3.2.4-alpine
    container_name: httpbin-proxy
    restart: unless-stopped
    ports:
      - 8089:8080
      - 2376:2376
    volumes:
      - ./haproxy.cfg:/haproxy.cfg
    command:
      - haproxy
      - -f
      - /haproxy.cfg
      - -d
    environment:
      - STATS_USER=admin
      - STATS_PASS=admin
      - STATS_URI=/
      - METRICS_URI=/metrics

  httpbin-go:
    image: ghcr.io/mccutchen/go-httpbin
    container_name: httpbin-go
    restart: unless-stopped
```

Конфигурация с проверкой тела ответа:

```ini
global
    log stdout format raw daemon info
    maxconn 4096

defaults
    mode http
    maxconn global
    log global
    option httplog
    option log-health-checks
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend metrics
    bind *:2376
    mode http
    stats enable
    stats uri "$STATS_URI"
    stats auth "$STATS_USER":"$STATS_PASS"
    stats refresh 5s
    http-request use-service prometheus-exporter if { path "$METRICS_URI" }
    no log

frontend frontend_httpbin
    bind *:8080
    default_backend backend_httpbin

backend backend_httpbin
    mode http
    balance roundrobin

    timeout check 10s
    default-server inter 5s fall 3 rise 3
    option httpchk GET /get
    http-check expect status 200
    http-check expect string "origin"

    server internal-httpbin-go httpbin-go:8080 check weight 20
    # server external-httpbin-go httpbingo.org:443 ssl verify none check weight 10
    server external-httpbin httpbin.org:443 ssl verify none check weight 10

```
- options:

`maxconn` максимальное количество одновременных соединений \
`nbproc` количество процессов HAProxy \
`option httplog` включает журналирование HTTP-трафика, полезно для отладки и мониторинга прохождения трафика через HAProxy и дает возможность просматривать HTTP-трафик в журнале, чтобы отслеживать запросы и ответы \
`option httpchk` отправлять HTTP-запросы к серверам в бэкенде, чтобы определить, работают ли они, это позволяет выявлять неработающие сервера и перераспределять запросы на работающие \
`option httpchk GET / HTTP/1.1\r\nHost:\ localhost` отправляет GET-запрос на корневой путь (/) используя версию протокола HTTP 1.1, Host:\ localhost - это часть заголовка Host, который также включается в HTTP-запрос и указывает на целевой хост, который проверяется \
`option tcp-check` активирует общую функцию TCP-проверок для всего бэкэнда, без необходимости указывать порт явно \
`tcp-check connect port 443` HAProxy будет устанавливать соединение с серверами в бэкенде на порту 443 для проверки, что серверы доступны и способны принимать соединения на этом порту

- balance:

`Round Robin (roundrobin)` алгоритм используемый по умолчанию, отправляет запросы на сервера по очереди \
`static-rr` похож на roundrobin, но он сохраняет порядок серверов в конфигурации \
`Least Connections (leastconn)` выбирает сервер с наименьшим количеством активных соединений, это полезно, если у серверов разная производительность или загруженность, так как запросы будут отправляться на менее загруженные серверы \
`source` использует IP-адрес источника (клиента) для привязки к одному и тому же серверу, это означает, что клиент всегда будет направляться к одному и тому же серверу, это полезно для сохранения состояния сеанса \
`uri` запросы с одним и тем же URL (до знака вопроса) будут переправляться на один и тот же сервер, это полезно для балансировки запросов к разным частям приложения \
`rdp-cookie` используется для балансировки запросов RDP (Remote Desktop Protocol), он анализирует cookie-заголовок RDP для принятия решений о направлении запросов

- server:

`ssl` использование SSL \
`verify none` отсутствие проверки сертификата \
`weight` распределение запросов по весу, если необходимо на определенный сервер отправлять больше запросов \
`inter` изменяет интервал между проверками, по умолчанию две секунды \
`fall` устанавливает допустимое количество неудачных проверок, по умолчанию три \
`rise` задает, сколько проходных проверок должно быть, прежде чем вернуть ранее отказавший сервер в ротацию, по умолчанию два \
`check port 443` указать явную проверку порта для конкретного сервера \
`check backup` параметр означает, что сервер будет использоваться только в случае, если все основные серверы становятся недоступными и не будет участвовать в балансировке, пока основные серверы функционируют

### Keepalive

**VRRP (Virtual Router Redundancy Protocol)** - сетевой протокол, предназначенный для увеличения доступности маршрутизаторов, выполняющих роль шлюза \
**VRRP-пакеты** - это специальные сообщения, которые узлы (маршрутизаторы/сервера) в VRRP-группе рассылают для сообщения своего состояния \
**VIP (Virtual IP)** - виртуальный IP адрес, который может автоматически переключаться между серверами в случае сбоя (frondend для haproxy/dns-rr), у кого в данный момент в сетевом интерфейсе прописан VIP, тот сервер и работает \
**Master** - сервер, на котором в данный момент активен VIP (отправляет VRRP-пакеты на backup nodes) \
**Backup** - сервера на которые переключится VIP, в случае сбоя мастера (следим за мастером) \
**VRID (virtual_router_id)** - сервера, объединенные общим виртуальным IP (VIP) образуют виртуальный роутер, уникальный идентификатор которого, принимает значения от 1 до 255. Сервер может одновременно состоять в нескольких VRID, при этом для каждой VRID должны использоваться уникальные виртуальные IP адреса. \
Master сервер с заданным интервалом отправляет VRRP пакеты на зарезервированный адрес multicast (многоадресной) рассылки или unicast на указанные ip-адреса, а все backup/slave сервера слушают этот адрес. Если Slave сервер не получает пакеты, он начинает процедуру выбора Master в соответствии с приоритетом, и если он переходит в состояние Master, то у него активирует VIP (поднимается виртуальный интерфейс) и отравляет gratuitous ARP. \
**Gratuitous ARP** - это вид ARP ответа, который обновляет MAC таблицу на подключенных коммутаторах, чтобы проинформировать о смене владельца виртуального IP-адреса и MAC-адреса для перенаправления трафика. При настройке VRRP, в качестве адреса для виртуального IP не используется реальный адрес сервера, так как, в случае сбоя, его адрес переместится на соседний, и при восстановлении, он окажется изолированным от сети, и чтобы вернуть свой адрес, нужно отправить в сеть VRRP пакет, но не будет IP адреса, с которого это возможно сделать.

`nano /etc/keepalived/keepalived.conf`

```ini
global_defs {
    enable_script_security
}

vrrp_script nginx_check {
    script "/usr/bin/curl http://127.0.0.1"
    interval 5
    user nginx
}

vrrp_instance web {
    state MASTER # на втором сервере BACKUP
    interface ens33
    virtual_router_id 110
    priority 255 # на втором сервере 100
    advert_int 2
    notify /etc/keepalived/notify-web.sh root
    virtual_ipaddress {
        192.168.3.110
    }
    track_interface {
        ens333
    }
    track_script {
        nginx_check
    }
}
```

`state <MASTER|BACKUP>` начальное состояние при запуске, в режиме nopreempt единственное допустимое значение - BACKUP \
`interface` интерфейс, на котором будет работать VRRP и подниматься VIP \
`virtual_router_id <0-255>` уникальный идентификатор VRRP экземпляра, должен совпадать на всех серверах одной группы \
`priority <0-255>` задает приоритет при выборе MASTER, сервер с большим числом приоритета становится MASTER \
`advert_int <число секунд>` определяет, с какой периодичностью мастер должен сообщать остальным о себе, и если по истечению данного периода сервера не получат от мастера широковещательный пакет, то они инициируют выборы нового мастера \
`nopreempt` если мастер пропал из сети, и был выбран новый мастер с меньшим приоритетом, то по возвращении старшего мастера, он останется в состоянии BACKUP, пока новый мастер не отвалится \
`preempt_delay` что бы мастером был конкретный сервер, то заменить настройку nopreempt на preempt_delay \
`notify` скрипт, который будет выполняться при каждом изменении состояния сервера, и имя пользователя, от имени которого данный скрипт будет выполняться (логирование или отправка на почту) \
`virtual_ipaddress` виртуальный IP-адрес (VIP), которые будет активирован на сервере в состоянии MASTER, должны совпадать на всех серверах внутри VRRP экземпляра \
`track_interface` мониторинг состояния интерфейсов, переводит VRRP экземпляр в состояние FAULT, если один из перечисленных интерфейсов находится в состоянии DOWN \
`track_script` мониторинг с использованием скрипта, который должен возвращать 0 если проверка завершилась успешно или 1, если проверка завершилась с ошибкой \
`fall <число>` количество раз, которое скрипт вернул не нулевое значение, при котором перейти в состояние FAULT \
`rise <число>` количество раз, которое скрипт вернул нулевое значение, при котором выйти из состояния FAULT \
`timeout <число>` время ожидания, пока скрипт вернет результат, после которого вернуть ненулевое значение

`journalctl -u keepalived` \
`cat /var/log/messages | grep -i keepalived` \
`tail /var/run/keepalived.INSTANCE.web.state`

## GlusterFS

[GlusterFS](https://github.com/gluster/glusterfs) - это распределенная и масштабируемая файловая система, которая объединяет хранилища с разных серверов в единое виртуальное сетевое хранилище, обеспечивая отказоустойчивость и высокую производительность без необходимости отдельного сервера для метаданных. Работает поверх обычных файловых систем (например, `ext4`) с помощью технологии FUSE (в пользовательском пространстве). 

```bash
# Определить имена хостов для всех нод
echo '
192.168.3.101  hv-us-101
192.168.3.105  rpi-105
192.168.3.106  rpi-106
' >> /etc/hosts

# Установить сервер на все ноды
add-apt-repository ppa:gluster/glusterfs-11
apt update
apt install glusterfs-server -y
systemctl start glusterd
systemctl enable glusterd
systemctl status glusterd

# Подключить (peer detach для отключения) все узлы к пулу Trusted Server Pool (TSP)
gluster peer probe rpi-105
gluster peer probe rpi-106
gluster peer status
gluster pool list

# Создать директорию хранения на всех нодах
mkdir /gluster

# Создать том в пуле и запустить его
gluster volume create docker-fs replica 3 hv-us-01:/gluster rpi-105:/gluster rpi-106:/gluster force
gluster volume start docker-fs
gluster volume status docker-fs
gluster volume info docker-fs
gluster volume list

echo 'localhost:/docker-fs /mnt glusterfs defaults,_netdev,backupvolfile-server=localhost 0 0' >> /etc/fstab
mount localhost:/docker-fs /mnt
df -h

# Монтирование с помощью клиента
apt install -y glusterfs-client
mount -t glusterfs server1:/gv0 /mnt/gluster-volume

# Включение модуля NFS для удаленного монтирования
gluster volume set docker-fs nfs.disable off
mount -t nfs hv-us-101:/docker-fs /mnt/gluster-nfs

# Включить CIFS/SMB протокол
gluster volume set docker-fs storage.brick-multiplex off
gluster volume set docker-fs server.allow-insecure on
```
