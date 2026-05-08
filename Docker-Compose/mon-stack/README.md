## Monitoring Stack

Этой основной стек, который я использую для мониторинга систем на базе Linux, Windows и контейнеров Docker в своей домашней среде.

- [Grafana](https://github.com/grafana/grafana) для визуализации метрик и логов.
- [Prometheus](https://github.com/prometheus/prometheus) для хранения метрик.
- [Alertmanager](https://github.com/prometheus/alertmanager) с преднастроенными базовыми правилами и шаблоном Telegram.
- [Blackbox Exporter](https://github.com/prometheus/blackbox_exporter/tree/master) для проверки доступности Интернета, а также хостов и сервисов в сети.
- [Node Exporter](https://github.com/prometheus/node_exporter) для сбора системных метрик.
- [Process Exporter](https://github.com/ncabatoff/process-exporter) для сбора метрик запущенных процессов.
- [logporter](https://github.com/Lifailon/logporter) для сбора всех базовых метрик из контейнеров Docker (легковесная альтернатива [cAdvisor](https://github.com/google/cadvisor)).
- [Loki](https://github.com/grafana/loki) сервер и агент `promtail` для сборка логов из файловой системы и контейнеров через сокет Docker с поддержкой фильтрации по `node`, `container`, `level` и `tag`.

Клонируем и запускаем:

```bash
mkdir -p $HOME/docker/mon-stack && cd $HOME/docker/mon-stack
git clone https://github.com/Lifailon/rudocs
mv ./rudocs/Docker-Compose/mon-stack/* ./
rm -rf rudocs
```

Перед запуском необходимо настроить параметры подключения к Telegram боту в файле [alertmanager](./alertmanager.yml) для отправки оповещений.

```yml
- chat_id: <CHAT/CHANNEL_ID>
  bot_token: <BOT_API_KEY>
```

В стеке используется контейнер `volume-permissions-update` для предварительной настройки прав доступа к файлам.

Запускаем стек:

```bash
docker-compose up -d
```

Источики данных prometheus и koki, а также все dashboards автоматически импортируются при запуске. Панели уже преднастроенны для работы с текущим стеком.

Идем в браузер => http://localhost:9091

- Логин: `admin`
- Пароль: `GrafanaAdmin`