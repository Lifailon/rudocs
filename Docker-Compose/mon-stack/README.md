# Monitoring Stack

Этой мой основной стек, который я использую для мониторинга систем на базе Linux, Windows и контейнеров Docker в своей домашней среде.

- [Grafana](https://github.com/grafana/grafana) для визуализации метрик и логов.
- [Prometheus](https://github.com/prometheus/prometheus) для хранения метрик.
- [Alertmanager](https://github.com/prometheus/alertmanager) с преднастроенными базовыми правилами и шаблоном Telegram.
- [Blackbox Exporter](https://github.com/prometheus/blackbox_exporter/tree/master) для проверки доступности Интернета, а также хостов и сервисов в сети.
- [Node Exporter](https://github.com/prometheus/node_exporter) для сбора системных метрик.
- [logporter](https://github.com/Lifailon/logporter) для сбора всех базовых метрик из контейнеров Docker (легковесная альтернатива [cAdvisor](https://github.com/google/cadvisor)).
- [Loki](https://github.com/grafana/loki) сервер и агент `promtail` для сборка логов из файловой системы и контейнеров через сокет Docker с поддержкой фильтрации по `node`, `container`, `level` и `tag`.

Перед запуском необходимо настроить параметры подключения к Telegram боту в файле [alertmanager](./alertmanager.yml) для отправки оповещений.

```yml
- chat_id: <CHAT/CHANNEL_ID>
  bot_token: <BOT_API_KEY>
```

Клонируем и запускаем:

```bash
cd $HOME && mkdir mon-stack && cd mon-stack
git clone https://github.com/Lifailon/PS-Commands
mv ./PS-Commands/Docker-Compose/mon-stack/* ./
rm -rf PS-Commands
chmod 644 ./*
docker-compose up -d
```

Идем в браузер: http://localhost:9091 (логин и пароль `admin:admin`) и подключаем источники данных:

- Prometheus: http://prometheus:9092
- Loki: http://loki-server:3100

Импортируем Dashboards из директории [grafana](./grafana) (все панели преднастроенны для работы с текущим стеком).