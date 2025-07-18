# Crystal Disk Info Exporter (cdi-exporter)

Пример создания экспортера для получения метрик температуры всех дисков из [CrystalDiskInfo](https://crystalmark.info/en/software/crystaldiskinfo) и отправки в [Prometheus](https://github.com/prometheus/prometheus) через [PushGateway](https://github.com/prometheus/pushgateway).

- Запускаем `pushgateway` в контейнере:

`docker run -d --name pushgateway --restart unless-stopped -p 19091:9091 prom/pushgateway`

- Запускаем скрипт в консоли:

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

- Проверяем наличие метрик на конечной точке шлюза:

```PowerShell
$(Invoke-RestMethod http://192.168.3.100:9091/metrics).Split("`n") | Select-String "disk_temperature"
```

- Добавляем конфигурацию в `prometheus.yml`:

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

- Собираем контейнер в среде `WSL` с помощью `Dockerfile` монтированием системного диска Windows:

```dockerfile
FROM mcr.microsoft.com/powershell:latest
WORKDIR /cdi-exporter
COPY cdi-exporter.ps1 ./cdi-exporter.ps1
CMD ["pwsh", "-File", "cdi-exporter.ps1"]
```

`docker build -t cdi-exporter .` \
`docker run -d -v /mnt/c:/mnt/c --name cdi-exporter cdi-exporter`

- Собираем стек из шлюза и скрипта в `docker-compose.yml`:

```yaml
services:
  cdi-exporter:
    build:
      context: .
      dockerfile: Dockerfile
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

- Настраиваем `Dashboard` в `Grafana`:

Переменные для фильтрации запроса:

hostName: `label_values(exported_instance)` \
diskName: `label_values(disk)`

Метрика температуры: `disk_temperature{exported_instance="$hostName", disk=~"$diskName"}`