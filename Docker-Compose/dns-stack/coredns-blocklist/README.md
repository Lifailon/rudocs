# coredns and blocklist plugin

Автоматизированный процесс сборки исходного [coredns](https://github.com/coredns/coredns) вместе с плагином [blocklist](https://github.com/relekang/coredns-blocklist) в контейнере Docker. Данный процесс позволяет превратить `coredns` в легковестную альтернативу [Pi-hole](https://github.com/pi-hole/pi-hole), а в качестве интерфейса использовать подготовленная панель Grafana с новыми метриками плагина.

```bash
cd $HOME
git clone https://github.com/Lifailon/PS-Commands
mkdir coredns
mv -f PS-Commands/Docker-Compose/dns-stack/coredns-blocklist/ coredns/
rm -rf PS-Commands
cd coredns
docker-compose up -d
```