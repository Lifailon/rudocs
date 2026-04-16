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