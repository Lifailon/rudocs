## Graylog

Установкай [Graylog](https://github.com/Graylog2/graylog2-server) и настройка передачи системных логов Linux через `rsyslog`.

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
