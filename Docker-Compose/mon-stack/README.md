# Monitoring Stack

Этой мой основной стек, который я использую для мониторинга систем на базе Linux и контейнеров Docker в своей домашней среде.

Он запускает стект из Grafana для визуализации метрик и логов, Prometheus для хранения метрик, Alertmanager с преднастроенными базовыми правилами и шаблоном Telegram, Loki сервер и агент promtail для сборка логов из файловой системы и контейнеров через сокет. В директории [grafana](./grafana) все преднастроенные Dashboard для работы с текущим стеком.

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

Идем в браузер: http://localhost:9091 (логин и пароль `admin:admin`).

- Подключаем источники данных:

Prometheus: http://prometheus:9092

Loki: http://loki-server:3100

- Импортируем Dashboards.