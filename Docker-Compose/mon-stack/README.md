# Monitoring Stack

Этой мой основной стек, который я использую для мониторинга систем на базе Linux и контейнеров Docker в своей домашней среде.

Он запускает [Grafana](https://github.com/grafana/grafana) для визуализации метрик и логов, [Prometheus](https://github.com/prometheus/prometheus) для хранения метрик, [Node Exporter](https://github.com/prometheus/node_exporter) для сбора системных метрик, [cAdvisor](https://github.com/google/cadvisor) или [LogPorter](https://github.com/Lifailon/logporter) (на выбор, можно закомментировать любой из них) для сбора метрик из контейнеров Docker, [Alertmanager](https://github.com/prometheus/alertmanager) с преднастроенными базовыми правилами и шаблоном Telegram, [Loki](https://github.com/grafana/loki) сервер и агент `promtail` для сборка логов из файловой системы и контейнеров через сокет Docker с поддержкой фильтрации по `node`, `container`, `level` и `tag`.

Перед запуском необходимо настроить параметры подключения к Telegram боту в файле [alertmanager](./alertmanager.yml) для отправки оповещений.

```yml
- chat_id: <CHAT/CHANNEL_ID>
  bot_token: <BOT_API_KEY>
```

Клонируем и запускаем:

```bash
cd $HOME
mkdir mon-stack && cd mon-stack
git clone https://github.com/Lifailon/PS-Commands
mv ./PS-Commands/Docker-Compose/mon-stack/* ./
rm -rf PS-Commands

# cat prometheus-dev.yml > prometheus.yml

docker-compose up -d
```

Идем в браузер: http://localhost:9091 (логин и пароль `admin:admin`) и подключаем источники данных:

- Prometheus: http://prometheus:9092
- Loki: http://loki-server:3100

Импортируем Dashboards из директории [grafana](./grafana) (все панели преднастроенны для работы с текущим стеком).