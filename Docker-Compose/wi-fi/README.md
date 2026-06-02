# Wi-Fi over Vless

Настройка [RaspAP](https://github.com/RaspAP/raspap-webgui) в контейнере [Docker](https://github.com/RaspAP/raspap-docker) на Raspberry Pi с использованием одного Wi-Fi интерфейса для приема и раздачи интернета с маршрутизацией трафика через Vless с помощью клиента [v2rayA](https://github.com/v2rayA/v2rayA).

Вводные:

- `wlan0` - интерфейс для подключения к роутеру (выход в интернет).
- `uap0` - виртуальный интерфейс для раздачи сети Wi-Fi.

- 1. Создаем юнит systemd для инициализации виртуального адаптера из физического чипа `wlan0` при загрузки системы (до запуска Docker):

`sudo nano /etc/systemd/system/uap0-init.service`

```
[Unit]
Description=Create Virtual Wi-Fi Interface uap0
After=network.target
Before=docker.service

[Service]
Type=oneshot
ExecStart=/sbin/iw dev wlan0 interface add uap0 type __ap
ExecStart=/sbin/ip link set uap0 address 00:11:22:33:44:55
ExecStart=/sbin/ip link set uap0 up
ExecStart=/sbin/ip addr add 192.168.50.1/24 dev uap0
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

Применяем настройки:

```bash
sudo systemctl daemon-reload
sudo systemctl enable uap0-init.service
sudo systemctl start uap0-init.service
```

- 2. Освобождаем порты для `DHCP` и `DNS`:

В Ubuntu Server системный резолвер по умолчанию занимает 53 порт.

`sudo nano /etc/systemd/resolved.conf`

```
[Resolve]
DNS=8.8.8.8 1.1.1.1
DNSStubListener=no
```

`sudo systemctl restart systemd-resolved`

Создаем файл конфигурации для изоляции DHCP-сервера RaspAP:

`sudo nano /etc/dnsmasq.d/raspap.conf`

```
interface=uap0
bind-interfaces
```

Проверяем порты:

`ss -tulpn | grep -E ":(53|67)"`


- 3. Включаем пересылку трафика между интерфейсами на уровне ядра Linux:

```bash
sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
```

- 4. Настраиваем правила Firewall:

```bash
# Сбрасываем старые правила
sudo iptables -F FORWARD
sudo iptables -P FORWARD ACCEPT
sudo iptables -t nat -F
# Включаем маскарадинг (трафик из сети Hotspot наружу через Wi-Fi интерфейс wlan0)
sudo iptables -t nat -A POSTROUTING -s 192.168.50.0/24 -o wlan0 -j MASQUERADE
# Разрешаем сквозной проход пакетов между виртуальным Hotspot и Интернетом
sudo iptables -A FORWARD -i uap0 -o wlan0 -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o uap0 -m state --state RELATED,ESTABLISHED -j ACCEPT
```

Сохраняем правила Firewall при перезагрузки системы:

```bash
sudo apt update && sudo apt install -y iptables-persistent
sudo iptables-save | sudo tee /etc/iptables/rules.v4
```

- 5. Запускаем стек контейнеров:

```bash
mkdir -p ~/docker/wi-fi-stack
cd ~/docker/wi-fi-stack
nano docker-compose.yml
```

```yaml
services:
  raspap:
    image: ghcr.io/raspap/raspap-docker:latest
    container_name: raspap
    restart: always
    privileged: true
    network_mode: host
    environment:
      - RASPAP_SSID=failon.vpn
      - RASPAP_SSID_PASS=12340987
      - RASPAP_COUNTRY=RU
      - RASPAP_WEBGUI_PORT=8081
      - RASPAP_WEBGUI_USER=admin
      - RASPAP_WEBGUI_PASS=admin
      - INTERFACE=uap0
      - UPSTREAM_INTERFACE=wlan0
    cap_add:
      - SYS_ADMIN
    volumes:
      - /lib/modules:/lib/modules:ro
      - /sys/fs/cgroup:/sys/fs/cgroup:rw
    cgroup: host

  v2raya:
    image: ghcr.io/v2raya/v2raya:latest
    container_name: v2raya
    restart: always
    privileged: true
    network_mode: host
    volumes:
      - /lib/modules:/lib/modules:ro
      - /etc/resolv.conf:/etc/resolv.conf
      - ./service:/service:ro
```

`docker-compose up -d`

- 6. Идем в интерфейс v2rayA для настройки подключения к Vless: http://localhost:2017

- 7. Идем в интерфейс RaspAP для настройки интерфейса `uap0 (AP)` в Hotspot: http://localhost:8081