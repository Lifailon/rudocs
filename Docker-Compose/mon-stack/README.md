# Monitoring Stack

Этой основной стек, который я использую для мониторинга систем на базе Linux, Windows и контейнеров Docker в своей домашней среде.

- [Grafana](https://github.com/grafana/grafana) для визуализации метрик и логов.
- [Prometheus](https://github.com/prometheus/prometheus) для хранения метрик.
- [Alertmanager](https://github.com/prometheus/alertmanager) с преднастроенными базовыми правилами и шаблоном Telegram.
- [Blackbox Exporter](https://github.com/prometheus/blackbox_exporter/tree/master) для проверки доступности Интернета, а также хостов и сервисов в сети.
- [Node Exporter](https://github.com/prometheus/node_exporter) для сбора системных метрик.
- [Process Exporter](https://github.com/ncabatoff/process-exporter) для сбора метрик запущенных процессов.
- [logporter](https://github.com/Lifailon/logporter) для сбора всех базовых метрик из контейнеров Docker (легковесная альтернатива [cAdvisor](https://github.com/google/cadvisor)).
- [Loki](https://github.com/grafana/loki) сервер и агент `promtail` для сборка логов из файловой системы и контейнеров через сокет Docker с поддержкой фильтрации по `node`, `container`, `level` и `tag`.

Перед запуском необходимо настроить параметры подключения к Telegram боту в файле [alertmanager](./alertmanager.yml) для отправки оповещений.

```yml
- chat_id: <CHAT/CHANNEL_ID>
  bot_token: <BOT_API_KEY>
```

Клонируем и запускаем:

```bash
mkdir -p $HOME/docker/mon-stack && cd $HOME/docker/mon-stack
git clone https://github.com/Lifailon/rudocs
mv ./rudocs/Docker-Compose/mon-stack/* ./
rm -rf rudocs

mkdir -p grafana_data && sudo chown -R 472:472 grafana_data
mkdir -p prometheus_data && sudo chown -R 65534:65534 prometheus_data prometheus.yml alert-rules.yml alertmanager.yml telegram.tmpl
mkdir -p loki_data && sudo chown -R 1000:1000 loki_data

docker-compose up -d
```

Идем в браузер: http://localhost:9091 (логин и пароль `admin:admin`) и подключаем источники данных:

- Prometheus: http://prometheus:9092
- Loki: http://loki-server:3100

Импортируем Dashboards из директории [grafana_dashboards](./grafana_dashboards) (все панели уже преднастроенны для работы с текущим стеком).