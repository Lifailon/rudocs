## Monitoring Stack

Этой основной стек, который я использую для мониторинга систем на базе Linux, Windows и контейнеров Docker в своей домашней среде.

- [Grafana](https://github.com/grafana/grafana) - интерфейс для визуализации метрик, логов, трейсов и профилей.
- [Prometheus](https://github.com/prometheus/prometheus) - база данных для хранения метрик.
- [Alertmanager](https://github.com/prometheus/alertmanager) - система оповещений, с преднастроенными базовыми правилами и шаблоном Telegram.
- [Blackbox Exporter](https://github.com/prometheus/blackbox_exporter) - система мониторинга доступности внешних сервисов и хостов в Интернете и локальной сети.
- [Node Exporter](https://github.com/prometheus/node_exporter) - экспортер для сбора системных метрик Linux.
- [Process Exporter](https://github.com/ncabatoff/process-exporter) - экспортер метрик запущенных процессов.
- [Beyla](https://github.com/grafana/beyla) - экспортер RED метрик (RPS, ошибок и продолжительности времени запросов) для HTTP и gRPC трафика.
- [logporter](https://github.com/Lifailon/logporter) - экспортер для сбора всех базовых метрик из контейнеров Docker (легковесная альтернатива [cAdvisor](https://github.com/google/cadvisor)).
- [Loki](https://github.com/grafana/loki) - сервер для хранения и агрегации логов.
- [Promtail](https://grafana.com/docs/loki/latest/send-data/promtail) - агент для сбора логов из файловой системы и контейнеров через сокет Docker.
- [Tempo](https://github.com/grafana/tempo) - хранилище для данных трассировок.
- [Pyroscope](https://github.com/grafana/pyroscope) - хранилище для данных профилирования.
- [Alloy](https://github.com/grafana/alloy) - агент для сбора и пересылки данных профилирования контейнеров Docker из сокета с помощью eBPF и трассировок с помощью встроенного в агент Beyla.

Клонируем все конфигурационные файлы необходимоые для настройки мониторинга из репозитория GitHub:

```bash
mkdir -p ~/docker && cd ~/docker
git clone https://github.com/Lifailon/rudocs
mv ./rudocs/Docker-Compose/mon-stack ./
rm -rf rudocs

```

Перед запуском необходимо настроить параметры подключения к Telegram боту и чату/каналу в файле [alertmanager](./alertmanager.yml) для отправки оповещений:

```yml
- chat_id: <CHAT/CHANNEL_ID>
  bot_token: <BOT_API_KEY>
```

Сервис `volume-permissions-update` используется для инициализации прав доступа к файлам перед запуском стека.

Запускаем стек:

```bash
docker-compose up -d
```

Источики данных, а также все dashboards автоматически импортируются при запуске. Панели уже преднастроенны для работы с текущим стеком.

Идем в браузер 👉 http://localhost:9091

- 🙍‍♂️ Логин: `admin`
- 🔑 Пароль: `GrafanaAdmin`