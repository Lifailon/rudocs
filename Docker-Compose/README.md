# Compose Stacks

Коллекция стеков Docker Compose (конфигурации к некоторым сервисам доступны в [репозитории](https://github.com/Lifailon/PS-Commands/tree/rsa/Docker-Compose)).

## Admin Stack

### Guacamole

[Apache Guacamole](https://github.com/apache/guacamole-server) — это клиент-серверное веб-приложение для централизованного удаленного доступа к серверам и рабочим столам на основе протоколов RDP, VNC и SSH через веб-браузер и управления доступом.

```yaml
services:
  guacd:
    image: guacamole/guacd
    container_name: gua-cd
    restart: unless-stopped
    volumes:
    - ./drive:/drive:rw
    - ./record:/record:rw

  guacamole-db:
    image: postgres:15.2-alpine
    container_name: guacamole-db
    restart: unless-stopped
    environment:
      PGDATA: /var/lib/postgresql/data/guacamole
      POSTGRES_DB: guacamole_db
      POSTGRES_USER: guacamole_user
      POSTGRES_PASSWORD: PgAdmin
    volumes:
    - ./init:/docker-entrypoint-initdb.d:z
    - ./data:/var/lib/postgresql/data:Z
 
  guacamole:
    image: guacamole/guacamole
    container_name: guacamole
    restart: unless-stopped
    environment:
      GUACD_HOSTNAME: guacd
      POSTGRES_HOSTNAME: guacamole-db
      POSTGRES_DATABASE: guacamole_db
      POSTGRES_USER: guacamole_user
      POSTGRES_PASSWORD: PgAdmin
    volumes:
      - ./record:/record:rw
    ports:
      - 8080:8080/tcp
    depends_on:
    - guacd
    - guacamole-db
```

### MeshCentral

[MeshCentral](https://github.com/Ylianst/MeshCentral) - сервер для управления множеством компьютеров в локальной сети через веб-интерфейс.

```yaml
services:
  meshcentral:
    image: ghcr.io/ylianst/meshcentral:latest
    container_name: meshcentral
    restart: unless-stopped
    ports:
      - 8086:443
    env_file:
      - .env
    volumes:
      - ./meshcentral/data:/opt/meshcentral/meshcentral-data
      - ./meshcentral/user_files:/opt/meshcentral/meshcentral-files
      - ./meshcentral/backup:/opt/meshcentral/meshcentral-backups
      - ./meshcentral/web:/opt/meshcentral/meshcentral-web
```

env:

```env
NODE_ENV=production
HOSTNAME=meshcentral.docker.local

REVERSE_PROXY=false
REVERSE_PROXY_TLS_PORT=

USE_MONGODB=false
MONGO_URL=
MONGO_INITDB_ROOT_USERNAME=mongodbadmin
MONGO_INITDB_ROOT_PASSWORD=mongodbpasswd
 
IFRAME=false
ALLOW_NEW_ACCOUNTS=true
WEBRTC=false
ALLOWPLUGINS=false
LOCALSESSIONRECORDING=false
MINIFY=true
ARGS=
```

## Bot Stack

### SSH Bot

[SSH Bot](https://github.com/Lifailon/ssh-bot) - Telegram бот, который позволяет запускать заданные команды на выбранном хосте в домашней сети и возвращать результат их выполнения. Бот не устанавливает постоянное соединение с удаленным хостом, что позволяет выполнять команды асинхронно.

```yaml
services:
  OpenRouter-Bot:
    container_name: OpenRouter-Bot
    image: lifailon/openrouter-bot:latest
    volumes:
      - ./openrouter-bot.env:/openrouter-bot/.env
    restart: unless-stopped
```

env:

```env
# Telegram api key from https://telegram.me/BotFather
TELEGRAM_BOT_TOKEN=XXXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# Your Telegram id from https://t.me/getmyid_bot
TELEGRAM_USER_ID=7777777777

# Interpreter used only when running the bot local in Windows
# Available values: powershell/pwsh
WIN_SHELL=pwsh
# Interpreter used on local and remote hosts in Linux
# Available values: sh/bash/zsh or other
LINUX_SHELL=bash

# Parallel (async) execution of commands (default: false)
PARALLEL_EXEC=true

# Global parameters for ssh connection (low priority)
SSH_PORT=2121
SSH_USER=lifailon
# Use password to connect (optional)
SSH_PASSWORD=
# Full path to private key (default: ~/.ssh/id_rsa)
SSH_PRIVATE_KEY_PATH=
SSH_CONNECT_TIMEOUT=2
# Save and reuse passed variables and functions (default: false)
SSH_SAVE_ENV=true
# List of hosts separated by comma (high priority for username and port)
SSH_HOST_LIST=192.168.3.101,root@192.168.3.102:22,root@192.168.3.103:22,192.168.3.105,192.168.3.106

# Log the output of command execution
LOG_MODE=DEBUG
```

### OpenRouter Bot

[OpenRouter Bot](https://github.com/Lifailon/openrouter-bot) - Telegram бота для общения с бесплатными и платными моделями ИИ через [OpenRouter](https://openrouter.ai), или локальными LLM, например, через [LM Studio](https://lmstudio.ai).

```yaml
services:
  ssh-bot:
    container_name: ssh-bot
    image: lifailon/ssh-bot:latest
    volumes:
      - ./ssh-bot.env:/ssh-bot/.env
      - $HOME/.ssh/id_rsa:/root/.ssh/id_rsa
    restart: unless-stopped
```

env:

```env
# OpenRouter api key from https://openrouter.ai/settings/keys
API_KEY=

# Telegram api key from https://telegram.me/BotFather
TELEGRAM_BOT_TOKEN=

# Your Telegram id from https://t.me/getmyid_bot
ADMIN_IDS=
# List of users to access the bot, separated by commas
ALLOWED_USER_IDS=

BASE_URL=https://openrouter.ai/api/v1
# List of free models: https://openrouter.ai/models?max_price=0
MODEL=deepseek/deepseek-r1:free
# System preset that specifies the role for AI
#ASSISTANT_PROMPT="Ты переводчик, умеешь только переводить текст с русского на англйский язык (и наоборот) и не отвечаешь на вопросы."

# Using local LLM via LM Studio (https://lmstudio.ai)
#BASE_URL=http://localhost:1234/v1
# Using local model: https://huggingface.co/ruslandev/llama-3-8b-gpt-4o-ru1.0
#MODEL=llama-3-8b-gpt-4o-ru1.0

VISION=false
#VISION_PROMPT="Описание изображения"
#VISION_DETAIL="низкий"

# The maximum number of messages or time in minutes for store messages in history
MAX_HISTORY_SIZE=20
MAX_HISTORY_TIME=60

#BUDGET_PERIOD=monthly
# Enable user access (default)
#USER_BUDGET=1
# Disable guest access (enabled by default)
GUEST_BUDGET=0

# Language used for bot responses (supported: EN/RU)
LANG=RU

# ADMIN/USER/GUEST
STATS_MIN_ROLE=ADMIN
```

### yt-dlp Telegram Bot

[yt-dlp-telegram-bot](https://github.com/nonoo/yt-dlp-telegram-bot) - Telegram бот для загрузки видео из YouTube с помощью [yt-dlp](https://github.com/yt-dlp/yt-dlp).

```yaml
services:
  yt-dlp-telegram-bot:
    image: lifailon/yt-dlp-telegram-bot:latest
    container_name: yt-dlp-telegram-bot
    restart: unless-stopped
    env_file:
      - .env
```

env:

```env
API_ID=             # get from https://my.telegram.org
API_HASH=           # get from https://my.telegram.org
BOT_TOKEN=          # get from https://telegram.me/BotFather

ALLOWED_USERIDS=    # get from https://t.me/getmyid_bot
ADMIN_USERIDS=      # get from https://t.me/getmyid_bot

YTDLP_PATH=         # default: /tmp/yt-dlp
ALLOWED_GROUPIDS=
MAX_SIZE=
YTDLP_COOKIES=
```

### yt-dlp-telegram

[yt-dlp-telegram](https://github.com/ssebastianoo/yt-dlp-telegram) - Telegram бот для загрузки видео из YouTube с ограничением 50 МБ.

```yaml
services:
  yt-dlp-bot:
    image: lifailon/yt-dlp-bot:latest
    build:
      context: .
      dockerfile: Dockerfile
    container_name: yt-dlp-bot
    restart: unless-stopped
    volumes:
      - ./config:/bot/config.py
```

config:

```env
token = ""                  # Telegram api key your bot
logs = 2390049              # Telegram your chat id
max_filesize = 50000000     # Max file size in bytes

# output_folder = "/download"
```

### smtp_to_telegram

[SMTP to Telegram](https://github.com/KostyaEsmukov/smtp_to_telegram) - SMTP сервер (листенер) для переадресации сообщений в Telegram.

```yaml
services:
  smtp2telegram:
    image: kostyaesmukov/smtp_to_telegram
    container_name: smtp2telegram
    restart: unless-stopped
    environment:
      - ST_SMTP_LISTEN=0.0.0.0:2525
      - ST_TELEGRAM_CHAT_IDS=
      - ST_TELEGRAM_BOT_TOKEN=
      - "ST_TELEGRAM_MESSAGE_TEMPLATE=Subject: {subject}\\\\n\\\\n{body}"
    ports:
      - 2525:2525

# echo -e "Subject: Test\n\nThis is test body" | curl smtp://localhost:2525 \
#   --mail-from admin@docker.local \
#   --mail-rcpt admin@docker.local \
#   --user admin:admin \
#   -T -
```

## API Stack

### Scalar

[Scalar](https://github.com/scalar/scalar) - интерактивный справочник для документации OpenAPI (like Swagger UI) и REST API клиент в одном веб-приложение.

🔗 [API Reference Demo](https://docs.scalar.com/editor#/reference) ↗

🔗 [API Client Demo](https://client.scalar.com/workspace/default/request/default) ↗

```yaml
services:
  scalar:
    image: scalarapi/api-reference:latest
    container_name: scalar
    restart: unless-stopped
    ports:
      - 4005:8080
    environment:
      API_REFERENCE_CONFIG: |
        {
          "theme": "purple"
        }
    volumes:
      - ./docs:/docs:ro
```

### Restfox

[Restfox](https://github.com/flawiddsouza/Restfox) - легковесный и быстрый офлайн API-клиент (WebUI/Desktop) с поддержкой импорт коллекций из OpenAPI и экспорт в Postman и Insomnia.

🔗 [Restfox API Client Demo](https://restfox.dev) ↗

🔗 [Hoppscotch API Client Demo](https://hoppscotch.io/) ↗

🔗 [HTTPie API Client Demo](https://httpie.io/app) ↗

🔗 [Postman Collections to OpenAPI Docs](https://kevinswiber.github.io/postman2openapi) ↗

```yaml
services:
  restfox:
    image: flawiddsouza/restfox:latest
    container_name: restfox
    restart: unless-stopped
    ports:
      - 4004:4004
```

### Yaade

[Yaade](https://github.com/EsperoTech/yaade) — это среда совместной разработки API, размещаемая на собственном сервере (еще один API клиент с веб-интерфейсом).

```yaml
services:
  yaade:
    image: esperotech/yaade:latest 
    container_name: yaade
    restart: unless-stopped
    ports:
      - 9339:9339
    environment:
      - YAADE_ADMIN_USERNAME=admin
      - YAADE_ADMIN_PASSWORD=password
    volumes:
      - ./yaade_data:/app/data
```

### HTTPBin

[go-httpbin](https://github.com/mccutchen/go-httpbin) - API сервер клиент для тестирования HTTP запросов и ответов (fork [httpbin](https://github.com/postmanlabs/httpbin) от Postman Labs).

🔗 [HTTPBin Demo](https://httpbin.org) ↗

🔗 [HTTPBin Go Demo](https://httpbingo.org) ↗

```yaml
services:
  httpbin:
    image: ghcr.io/mccutchen/go-httpbin
    container_name: httpbin
    restart: unless-stopped
    ports:
      - 8888:8080
```

### Swagger UI

[Swagger UI](https://github.com/swagger-api/swagger-ui) - браузер для спецификации OpenAPI (поддерживает загрузку любой переданной спецификации через url).

🔗 [Swagger UI Demo](https://petstore.swagger.io) ↗

```yaml
services:
  swagger-ui:
    image: docker.swagger.io/swaggerapi/swagger-ui
    container_name: swagger-ui
    restart: unless-stopped
    ports:
      - 8889:8080
    environment:
      - PORT=8080
      - SWAGGER_JSON=/app/swagger.json
      - SWAGGER_JSON_URL=
      - API_KEY=**None**
    volumes:
      - ./docs/httpbin.json:/app/swagger.json:ro
    depends_on:
      - httpbin
```

### Swagger Editor

[Swagger Editor](https://github.com/swagger-api/swagger-editor) - онлайн редактор документации OpenAPI с поддержкой генерации клентов и заглушек API для разных языков с помощью [codegen](https://github.com/swagger-api/swagger-codegen).

🔗 [Swagger Editor Demo](https://editor.swagger.io) ↗

```yaml
services:
  swagger-editor:
    image: docker.swagger.io/swaggerapi/swagger-editor
    container_name: swagger-editor
    restart: unless-stopped
    ports:
      - 8890:8080
    environment:
      - PORT=8080
      - BASE_URL=/
      - URL=http://192.168.3.101:8889/swagger.json
    depends_on:
      - httpbin
```

### Mitm Proxy

[Mitm Proxy](https://github.com/mitmproxy/mitmproxy) - прямой (forward) прокси сервер для перехвата, анализа и изменения HTTP-трафика (удобно для отладки запросов в мобильных приложениях).

```yaml
services:
  mitmproxy:
    image: mitmproxy/mitmproxy:latest
    container_name: mitmproxy
    restart: unless-stopped
    ports:
      - 8880:8080 # Proxy
      - 8881:8081 # Web UI
    command: mitmweb --web-host 0.0.0.0 --listen-host 0.0.0.0
```

### Step CI

[Step CI](https://github.com/stepci/stepci) - инструмент командной строки для тестирования GraphQL, gRPC, SOAP и REST API в DevOps Pipelines (например, локально в консоли или в GitHub Actions)

🔗 [Step CI Demo](https://stepci.com) ↗

```yaml
services:
  step-ci:
    image: ghcr.io/stepci/stepci
    container_name: step-ci
    volumes:
      - ./step-ci-tests:/tests
    command: tests/httpbin.yml
```

## Network Stack

### Networking Toolbox

[Networking Toolbox](https://github.com/lissy93/networking-toolbox) - более 100 сетевых инструментов и утилит, предназначенных для работы в автономном режиме (от создателя web-check, [dashy](https://github.com/Lissy93/dashy) и [AdGuardian-Term](https://github.com/Lissy93/AdGuardian-Term)).

🔗 [Networking Toolbox Demo](https://networkingtoolbox.net) ↗

```yaml
services:
  networking-toolbox:
    image: lissy93/networking-toolbox:latest
    container_name: networking-toolbox
    restart: unless-stopped
    environment:
      - NODE_ENV=production
      - PORT=3000
      - HOST=0.0.0.0
    ports:
      - 3100:3000
    healthcheck:
      test: ["CMD", "wget", "-qO-", "http://127.0.0.1:3000/health"]
      start_period: 40s
      interval: 30s
      timeout: 10s
      retries: 3
```

### Web Check

[Web Check](https://github.com/Lissy93/web-check) - универсальный инструмент OSINT для анализа любого веб-сайта.

🔗 [Web Check Demo](https://web-check.xyz) ↗

```yaml
services:
  web-check:
    image: lissy93/web-check:latest
    container_name: web-check
    restart: unless-stopped
    ports:
      - 3101:3000
```

### IP Check

[IP Check / MyIP](https://github.com/jason5ng32/MyIP) - набор инструментов для проверки IP-адресов. Включаем в себя проверки DNS, соединения WebRTC, speedtest, ICMP, MTR, доступность веб-сайтов и другие возможности.

🔗 [IP Check Demo](https://ipcheck.ing/#/) ↗

```yaml
services:
  ip-check:
    container_name: ip-check
    image: jason5ng32/myip:latest
    restart: unless-stopped
    stdin_open: true
    tty: true
    ports:
      - 3102:18966
```

### ZoneMaster

[ZoneMaster](https://github.com/zonemaster/zonemaster) - веб-интерфейс, API и инструмент командной строки для проверки DNS.

`docker run -t --rm zonemaster/cli zonemaster.net`

🔗 [ZoneMaster Test Domains Demo](https://zonemaster.net/en/run-test) ↗

[Check Host](https://check-host.net/?lang=ru) - бесплатный онлайн инструмент и API для ICMP, HTTP/HTTPS, TCP, UDP и DNS проверок доступности узлов из разных стран.

[Looking.House](https://looking.house/looking-glass) - инструмент для проверки скорости загрузки и выгрузки (а также проверок ping, traceroute и mtr) из множества точек [Looking Glass](https://github.com/gnif/LookingGlass), расположенных в ДЦ по всему миру.

### NetAlertX

[NetAlertX](https://github.com/jokob-sk/NetAlertX) - сканер присутствия и обнаружения в локальной или WiFi сети с отправкой оповещений, например, в Telegram.

```yaml
services:
  netalertx:
    image: ghcr.io/jokob-sk/netalertx:latest
    container_name: netalertx
    restart: unless-stopped
    environment:
      - PUID=200
      - PGID=300
      - TZ=Etc/GMT+3
      - PORT=20211
    network_mode: host
    volumes:
      - ./netalertx_config:/app/config
      - ./netalertx_db:/app/db
    tmpfs:
      - /app/api
```

### Apprise

[Apprise](https://github.com/caronc/apprise) - система для отправки уведомления более чем в 100+ служб, с поддержкой веб интерфейса для настройки конфигураций (используется в NetAlertX для отправки уведомлений в Telegram).

```yaml
services:
  apprise:
    image: caronc/apprise:latest
    container_name: apprise
    restart: unless-stopped
    ports:
      - 8000:8000
    volumes:
      - ./apprise_config:/config
```

### RTSP to Web

[RTSP to Web](https://github.com/deepch/RTSPtoWeb) - RTSP клиент в браузере.

```yaml
services:
  rtsptoweb:
    image: ghcr.io/deepch/rtsptoweb:latest
    container_name: rtsp-to-web
    restart: unless-stopped
    # volumes:
    #   - ./rtsp_config/config.json:/config/config.json
    ports:
      - 8083:8083
```

## Dev Stack

### IT Tools

IT Tools - огромная коллекция утилит (криптография, конверторы, веб инструменты и многое другое).

🔗 [IT Tools Demo](https://it-tools.tech) ↗

```yaml
services:
  it-tools:
    image: corentinth/it-tools:latest
    container_name: it-tools
    restart: unless-stopped
    ports:
      - 6990:80
```

### Transform

[Transforms](https://github.com/ritz078/transform) - универсальный веб-конвертер.

🔗 [Transforms Demo](https://transform.tools) ↗

```yaml
services:
  transform:
    image: lifailon/transform:amd64
    # build:
    #   context: .
    #   dockerfile: Dockerfile
    container_name: transform
    restart: unless-stopped
    ports:
      - 3090:3000
```

### NexTerm

[NexTerm](https://github.com/gnmyt/Nexterm) - управление сервером в браузере с поддержкой 2FA для SSH (с поддержкой файлового браузера через SFTP), VNC и RDP, контейнерами Proxmox LXC, QEMU и развертывание приложений через Docker.

```yaml
services:
  nexterm:
    image: germannewsmaker/nexterm:latest
    restart: unless-stopped
    container_name: nexterm
    environment:
      # head -c 32 /dev/urandom | base64 || openssl rand -base64 32
      # head -c 32 /dev/urandom | xxd -p -c 32 || openssl rand -hex 32
      - ENCRYPTION_KEY=9dbde894647845ab33e13a9334cdbadc5f8d22abe42df0b3daff431eec0df870
    ports:
      - 6989:6989
    volumes:
      - ./nexterm_data:/app/data
```

### Code Server

[Code Server](https://github.com/coder/code-server) - VSCode сервер в браузере.

```yaml
services:
  code-server:
    image: linuxserver/code-server:latest
    container_name: code-server
    restart: unless-stopped
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/GMT+3
      - PASSWORD=CodeServerAdmin
    volumes:
      - ./vscode_config:/config
      - $HOME:/home
    ports:
      - 9443:8443
```

### Go Playground

[Better Go Playground](https://github.com/x1unix/go-playground) - улучшенная [Go Playground](https://go.dev/play) на базе [Monaco Editor](https://github.com/microsoft/monaco-editor) и React.

🔗 [Go Playground Demo](https://goplay.tools) ↗

```yaml
services:
  go-playground:
    image: x1unix/go-playground:latest
    container_name: go-playground
    restart: unless-stopped
    environment:
      - APP_CLEAN_INTERVAL=30m
    ports:
      - 9444:8000
```

### Go Template Playground

[Repeatit](https://github.com/rytsh/repeatit) (Go Template Playground) - игровая площадка для проверки шаблонов GoLang. Поддерживает рендиринг текста и html шаблонов, функции spting и heml, а также ввод параметров шаблона в форматах yaml, json и toml.

🔗 [Repeatit Demo](https://repeatit.io) ↗

```yaml
services:
  go-template-playground:
    image: ghcr.io/rytsh/repeatit:latest
    # image: lifailon/go-template-playground:latest # 0.5.5-amd64
    # build:
    #   context: .
    #   dockerfile: Dockerfile
    container_name: go-template-playground
    restart: unless-stopped
    stdin_open: true
    tty: true
    ports:
      - 9445:8080
```

## Diagram Stack

### D2 Playground

[D2 Playground](https://github.com/terrastruct/d2-playground) - игровая площадка для современного языка сценариев диаграмм, преобразующий текст в диаграммы.

🔗 [D2 Playground Demo](https://play.d2lang.com) ↗

🔗 [VSCode Extension](https://github.com/terrastruct/d2-vscode) ↗

```yaml
services:
  d2-playground:
    image: lifailon/d2-playground:latest
    # build:
    #   context: .
    #   dockerfile: Dockerfile
    container_name: d2-playground
    restart: unless-stopped
    ports:
      - 9089:9090
```

### DrawIO

[Draw.io](https://github.com/jgraph/drawio) - веб-версия бесплатного приложения для создания различных диаграмм (like MS Visio), блок-схем и т.п.

🔗 [Draw.io Demo](https://app.diagrams.net) ↗

```yaml
services:
  draw.io:
    image: jgraph/drawio:latest
    container_name: draw.io
    restart: unless-stopped
    stdin_open: true
    tty: true
    ports:
      - 9447:8080
```

## Backup Stack

### Duplicati

[Duplicati](https://github.com/duplicati/duplicati) - клиент резервного копирования, который безопасно хранит зашифрованные, инкрементальные и сжатые резервные копии в облачных хранилищах и на удаленных файловых серверах (поддерживает SFTP, WebDAV, S3-совместимые, Google Cloud и другие системы хранения). Поддерживает плагины, например, отправку оповещений в [Telegram](https://docs.duplicati.com/detailed-descriptions/sending-reports-via-email/sending-telegram-notifications).

```yaml
services:
  duplicati:
    image: lscr.io/linuxserver/duplicati:latest
    container_name: duplicati
    restart: unless-stopped
    environment:
      - PUID=0
      - PGID=0
      - TZ=Etc/UTC+3
      - SETTINGS_ENCRYPTION_KEY=DuplicatiKey
      - DUPLICATI__WEBSERVICE_PASSWORD=DuplicatiAdmin
      - CLI_ARGS=
    volumes:
      - ./duplicati_config:/config
      - ./duplicati_backup:/backups
      - /home/lifailon/docker:/source:ro
      - ./duplicati_restore:/restore
    ports:
      - 8200:8200
```

### Kopia

[Kopia](https://github.com/kopia/kopia) - кроссплатформенный инструмент резервного копирования для Windows, macOS и Linux с быстрым инкрементным резервным копированием, сквозным шифрованием на стороне клиента, сжатием и дедупликацией данных. Поддерживается Веб-интерфейс поверх cli в стиле отображения флагов для исполняемого файла.

```yaml
services:
  kopia:
    image: kopia/kopia:latest
    container_name: kopia
    restart: unless-stopped
    ports:
      - 51515:51515
    command:
      - server
      - start
      - --disable-csrf-token-checks
      - --insecure
      - --address=0.0.0.0:51515
      - --server-username=admin
      - --server-password=KopiaAdmin
    environment:
      - KOPIA_PASSWORD=KopiaAdmin
      - USER=User
    volumes:
        - ./kopia_config:/app/config
        - ./kopia_cache:/app/cache
        - ./kopia_logs:/app/logs
        - ./kopia_backup:/repository
        - /home/lifailon/docker:/data:ro
```

### Restic

[Restic](https://github.com/restic/restic) — это быстрая, эффективная и безопасная программа для резервного копирования, которая поддерживает хранение резервных копий на S3, SFTP, [REST Server](https://github.com/restic/rest-server), Rclone как backend и других хранилищах.

[Backrest](https://github.com/garethgeorge/backrest) — это веб-интерфейс для резервного копирования, построенное на основе Restic.

```yaml
services:
  backrest:
    image: garethgeorge/backrest:latest
    container_name: backrest
    restart: unless-stopped
    hostname: backrest
    volumes:
      - ./backrest/data:/data
      - ./backrest/config:/config
      - ./backrest/cache:/cache
      - ./backrest/tmp:/tmp
      - ./backrest/rclone:/root/.config/rclone  # Mount for rclone config (needed when using rclone remotes)
      - /path/to/backup/data:/userdata          # Mount local paths to backup
      - /path/to/local/repos:/repos             # Mount local repos (optional for remote storage)
    environment:
      - BACKREST_DATA=/data
      - BACKREST_CONFIG=/config/config.json
      - XDG_CACHE_HOME=/cache
      - TMPDIR=/tmp
      - TZ=Etc/UTC+3
    ports:
      - 9898:9898
```

## FS Stack

### Samba

[Samba](https://github.com/dperson/samba/) - SMB/CIFS сервер для запуска в контейнере Docker.

```yaml
services:
  samba:
    image: dperson/samba
    container_name: samba
    restart: always
    volumes:
      - /home/lifailon/docker:/share
    ports:
      - 139:139
      - 445:445
    environment:
      - USERID=1000
      - GROUPID=1000
      - SAMBA_USER=admin
      - SAMBA_PASS=admin
    command: |
      -u "$${SAMBA_USER};$${SAMBA_PASS}"
      -s "docker;/share;yes;no;no;$${SAMBA_USER};$${SAMBA_USER}"
      -p
```

### FileBrowser

[FileBrowser](https://github.com/filebrowser/filebrowser) - веб-интерфейс для управления файлами в указанном каталоге. Поддерживает управление пользователями, загрузку, удаление, просмотр и редактирование файлов.

```yaml
services:
  # mkdir filebrowser_data filebrowser_conf && chown -R 1000:1000 filebrowser_data filebrowser_conf
  file-browser:
    image: filebrowser/filebrowser
    container_name: file-browser
    restart: unless-stopped
    user: 0:0
    volumes:
      - $HOME:/srv                    # root directory
      - ./filebrowser_data:/database  # filebrowser.db
      - ./filebrowser_conf:/config    # settings.json
    ports:
      - 8300:80
```

### DuFS

[DuFS](https://github.com/sigoden/dufs) - уникальный служебный файловый сервер, который поддерживает статическое обслуживание, загрузку, поиск и удаленное управление через API.

```yaml
services:
  dufs:
    image: sigoden/dufs
    container_name: dufs
    restart: unless-stopped
    ports:
    - 5000:5000
    volumes:
    - $HOME:/data
    - ./config.yaml:/config.yaml
    command: /data -A # --config /config.yaml
```

### Syncthing

[Syncthing](https://github.com/syncthing/syncthing) - программа для непрерывной синхронизации файлов между двумя или более компьютерами. Работает на основе Block Exchange Protocol (BEP) для обмена данными, который использует TLS-шифрование для безопасной передачи данных по протоколу TCP.

```yaml
services:
  file-syncthing:
    image: syncthing/syncthing
    container_name: file-syncthing
    restart: unless-stopped
    network_mode: host
    # ports:
    #   - 8384:8384         # Web UI
    #   - 22000:22000/tcp   # TCP file transfers
    #   - 22000:22000/udp   # QUIC file transfers
    #   - 21027:21027/udp   # Receive local discovery broadcasts
    environment:
      - PUID=0
      - PGID=0
    volumes:
      - ./syncthing_data:/var/syncthing   # configs
      - $HOME/docker:/sync_data           # src sync data on server
      # - ./backup:/sync_data             # dst sync data on client (mkdir backup && chown -R 1000:1000 backup)
    healthcheck:
      test: curl -fkLsS -m 2 127.0.0.1:8384/rest/noauth/health | grep -o --color=never OK || exit 1
      interval: 1m
      timeout: 10s
      retries: 3
```

### h5ai

[h5ai](https://github.com/lrsjng/h5ai) - современный интерфейс веб-сервера для файлового индексера. Визуально напоминается FTP сервер для удобного отображения и загрузки (например, его использует [Libretro/RetroArch](https://buildbot.libretro.com) для публикации релизов).

```yaml
services:
  h5ai:
    image: awesometic/h5ai
    container_name: h5ai
    restart: unless-stopped
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/GMT+3
      - HTPASSWD=false
      - HTPASSWD_USER=admin
      - HTPASSWD_PW=admin
    volumes:
      - $HOME/docker:/h5ai    # public data
      - ./h5ai_conf:/config
    ports:
      - 8889:80
```

### SFTPGo

[SFTPGo](https://github.com/drakkan/sftpgo) - сервер SFTP, HTTP/S, FTP/S и WebDAV, с поддержкой объектное-совместимого S3 хранилища, Google Cloud Storage, файловой системы хранкения и другие SFTP-серверы.

```yaml
services:
  sftpgo:
    image: drakkan/sftpgo:edge
    container_name: sftpgo
    restart: unless-stopped
    ports:
      - 2022:2022
      - 8088:8080
```

## S3 Stack

### MinIO

[MinIO](https://github.com/minio/minio) - высокопроизводительное, совместимое S3 решение для хранения объектов с встроенной системой высокой доступности (например, используется в [Velero](https://github.com/vmware-tanzu/velero) для хранения данных резервного копирования Kubernetes).

```yaml
services:
  minio1:
    image: minio/minio
    container_name: minio1
    restart: unless-stopped
    hostname: minio1
    command: server http://minio1:9000/data http://minio2:9000/data --console-address ":9001"
    environment:
      - MINIO_ROOT_USER=admin
      - MINIO_ROOT_PASSWORD=MinioAdmin
    volumes:
      - ./minio1_data:/data
    ports:
      - 9000:9000 # API
      - 9001:9001 # WebUI

  minio2:
    image: minio/minio
    container_name: minio2
    restart: unless-stopped
    hostname: minio2  
    command: server http://minio1:9000/data http://minio2:9000/data --console-address ":9001"
    environment:
      MINIO_ROOT_USER: admin
      MINIO_ROOT_PASSWORD: MinioAdmin
    volumes:
      - ./minio2_data:/data
    ports:
      - 9002:9000
      - 9003:9001
```

### s3fs

[s3fs](https://github.com/s3fs-fuse/s3fs-fuse) - инструмент для монтирования S3 совместимого хранилища на базе [FUSE](https://github.com/libfuse/libfuse), позволяя управлять файлами и каталогами в локальной файловой системе.

```yaml
services:
  s3fs:
    image: efrecon/s3fs:1.95
    container_name: velero_data
    restart: unless-stopped
    privileged: true
    stdin_open: true
    tty: true
    devices:
      - /dev/fuse
    cap_add:
      - SYS_ADMIN
    security_opt:
      - apparmor=unconfined
    environment:
      - AWS_S3_URL=http://minio1:9000
      - AWS_S3_BUCKET=velero
      - AWS_S3_ACCESS_KEY_ID=admin
      - AWS_S3_SECRET_ACCESS_KEY=MinioAdmin
      - S3FS_ARGS=use_path_request_style,allow_other
    volumes:
      - ./velero_data:/opt/s3fs/bucket:rshared 
```

## Cloud Stack

### NextCloud

[NextCloud](https://github.com/nextcloud) - кросплатфоренная и self-hosted облачная система хранения (fork ownCloud от 2016 года) с возможностью расширения за счет плагинов (поддерживает ВКС на базе [Talk](https://github.com/nextcloud/talk-desktop), Kanban на базе [Deck](https://github.com/nextcloud/deck) и ряд других возможностей).

```yaml
services:
  nextcloud:
    image: nextcloud
    container_name: nextcloud
    restart: unless-stopped
    environment:
      - POSTGRES_HOST=nextcloud-db
      - POSTGRES_DB=nextcloud
      - POSTGRES_USER=nextcloud
      # - POSTGRES_PASSWORD=NextCloudAdmin
      - POSTGRES_PASSWORD_FILE=/run/secrets/postgres_password
      # - MYSQL_HOST=nextcloud-db
      # - MYSQL_DATABASE=nextcloud
      # - MYSQL_USER=nextcloud
      # - MYSQL_PASSWORD=NextCloudAdmin
    volumes:
      # - smb_volume_web:/var/www/html
      - ./nextcloud_data/web:/var/www/html
    ports:
      - 8866:80
    depends_on:
      - nextcloud-db

  nextcloud-db:
    image: postgres:15
    container_name: nextcloud-db
    restart: unless-stopped
    environment:
      - POSTGRES_DB=nextcloud
      - POSTGRES_USER=nextcloud
      # - POSTGRES_PASSWORD=NextCloudAdmin
      - POSTGRES_PASSWORD_FILE=/run/secrets/postgres_password
    volumes:
      # - smb_volume_db:/var/lib/postgresql/data
      - ./nextcloud_data/db:/var/lib/postgresql/data
    secrets:
      - postgres_password

  # nextcloud-db:
  #   image: mariadb:10.6
  #   container_name: nextcloud-db
  #   restart: unless-stopped
  #   command: --transaction-isolation=READ-COMMITTED --log-bin=binlog --binlog-format=ROW
  #   environment:
  #     - MYSQL_DATABASE=nextcloud
  #     - MYSQL_USER=nextcloud
  #     - MYSQL_PASSWORD=NextCloudAdmin
  #     - MYSQL_ROOT_PASSWORD=NextCloudAdmin
  #   volumes:
  #     - smb_volume_db:/var/lib/mysql

secrets:
  postgres_password:
    file: ./postgres_password

# volumes:
#   smb_volume_web:
#     driver_opts:
#       type: cifs
#       o: username=guest,password=,uid=1000,gid=1000
#       device: //192.168.3.100/docker-data/nextcloud/web

#   smb_volume_db:
#     driver_opts:
#       type: cifs
#       o: username=guest,password=,uid=1000,gid=1000
#       device: //192.168.3.100/docker-data/nextcloud/db
```

postgres_password:

```
NextCloudAdmin
```

### ownCloud

[ownCloud](https://github.com/owncloud) - прародитель NextCloud, основанный в 2010 году.

```yaml
services:
  owncloud:
    image: owncloud/server:${OWNCLOUD_VERSION}
    container_name: owncloud_server
    restart: always
    ports:
      - ${HTTP_PORT}:8080
    depends_on:
      - mariadb
      - redis
    environment:
      - OWNCLOUD_DOMAIN=${OWNCLOUD_DOMAIN}
      - OWNCLOUD_TRUSTED_DOMAINS=${OWNCLOUD_TRUSTED_DOMAINS}
      - OWNCLOUD_DB_TYPE=mysql
      - OWNCLOUD_DB_NAME=owncloud
      - OWNCLOUD_DB_USERNAME=owncloud
      - OWNCLOUD_DB_PASSWORD=owncloud
      - OWNCLOUD_DB_HOST=mariadb
      - OWNCLOUD_ADMIN_USERNAME=${ADMIN_USERNAME}
      - OWNCLOUD_ADMIN_PASSWORD=${ADMIN_PASSWORD}
      - OWNCLOUD_MYSQL_UTF8MB4=true
      - OWNCLOUD_REDIS_ENABLED=true
      - OWNCLOUD_REDIS_HOST=redis
    healthcheck:
      test: ["CMD", "/usr/bin/healthcheck"]
      interval: 30s
      timeout: 10s
      retries: 5
    volumes:
      - files:/mnt/data

  mariadb:
    image: mariadb:10.11
    container_name: owncloud_mariadb
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=owncloud
      - MYSQL_USER=owncloud
      - MYSQL_PASSWORD=owncloud
      - MYSQL_DATABASE=owncloud
      - MARIADB_AUTO_UPGRADE=1
    command: ["--max-allowed-packet=128M", "--innodb-log-file-size=64M"]
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-u", "root", "--password=owncloud"]
      interval: 10s
      timeout: 5s
      retries: 5
    volumes:
      - mysql:/var/lib/mysql

  redis:
    image: redis:6
    container_name: owncloud_redis
    restart: always
    command: ["--databases", "1"]
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
    volumes:
      - redis:/data

volumes:
  files:
    driver: local
  mysql:
    driver: local
  redis:
    driver: local
```

env:

```env
OWNCLOUD_VERSION=10.15
OWNCLOUD_DOMAIN=localhost:8080
OWNCLOUD_TRUSTED_DOMAINS=localhost
ADMIN_USERNAME=admin
ADMIN_PASSWORD=admin
HTTP_PORT=8080
```

## DNS Stack

### Technitium DNS Server

[Technitium DNS Server](https://github.com/TechnitiumSoftware/DnsServer) - авторитетный, рекурсивный и кэширующий DNS-сервер, который можно использовать для самостоятельного хостинга DNS. Поддерживает записи в формате wildcard для субдоменов, черные списки с автоматически обновлением из файлов и url (с поддержкой regex), браузер для управления кешем, [API](https://github.com/TechnitiumSoftware/DnsServer/blob/master/APIDOCS.md), встроенный DNS-клиент, магазин приложение и многое другое.

```yaml
services:
  tech-dns-srv:
    image: technitium/dns-server:latest
    container_name: tech-dns-srv
    restart: always
    hostname: dns-server
    # В режиме DHCP используется сеть хоста
    # network_mode: host
    ports:
      - 5380:5380/tcp       # Web UI HTTP
      # - "53443:53443/tcp" # Web UI HTTPS
      - 53:53/udp           # DNS UDP
      - 53:53/tcp           # DNS TCP
      # - 853:853/udp       # DNS-over-QUIC service
      # - 853:853/tcp       # DNS-over-TLS service
      # - 443:443/udp       # DNS-over-HTTPS service (HTTP/3)
      # - 443:443/tcp       # DNS-over-HTTPS service (HTTP/1.1, HTTP/2)
      # - 80:80/tcp         # DNS-over-HTTP service (use with reverse proxy or certbot certificate renewal)
      # - 8053:8053/tcp     # DNS-over-HTTP service (use with reverse proxy)
      # - 67:67/udp         # DHCP service
    environment:
      - DNS_SERVER_DOMAIN=dns-server                        # Основное доменное имя, используемое этим DNS-сервером для своей идентификации.
      - DNS_SERVER_FORWARDERS=1.1.1.1,8.8.8.8               # Список адресов пересылки, разделённых запятыми.
      - DNS_SERVER_BLOCK_LIST_URLS=https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
      # - DNS_SERVER_ADMIN_PASSWORD=password                # Пароль администратора веб-консоли DNS.
      # - DNS_SERVER_ADMIN_PASSWORD_FILE=password.txt       # Путь к файлу, содержащему текстовый пароль администратора веб-консоли DNS.
      # - DNS_SERVER_PREFER_IPV6=false                      # DNS-сервер будет использовать IPv6 для запросов, когда это возможно, если эта опция включена.
      # - DNS_SERVER_WEB_SERVICE_LOCAL_ADDRESSES=172.17.0.1,127.0.0.1 # Список IP-адресов сетевых интерфейсов, разделённых запятыми, запросы на которых должен прослушивать веб-сервис. Адрес «172.17.0.1» — это встроенный мост Docker. Если не указано иное, «[::]» используется по умолчанию. Примечание! Этот параметр следует использовать только в сетевом режиме «host».
      # - DNS_SERVER_WEB_SERVICE_HTTP_PORT=5380             # Номер порта TCP для веб-консоли DNS по протоколу HTTP.
      # - DNS_SERVER_WEB_SERVICE_HTTPS_PORT=53443           # Номер порта TCP для веб-консоли DNS по протоколу HTTPS.
      # - DNS_SERVER_WEB_SERVICE_ENABLE_HTTPS=false         # Включает HTTPS для веб-консоли DNS.
      # - DNS_SERVER_WEB_SERVICE_USE_SELF_SIGNED_CERT=false # Включает самоподписанный TLS-сертификат для веб-консоли DNS.
      # - DNS_SERVER_OPTIONAL_PROTOCOL_DNS_OVER_HTTP=false  # Включает использование дополнительного протокола DNS-сервера DNS-over-HTTP на TCP-порту 8053 с обратным прокси-сервером, завершающим TLS, например, nginx.
      # - DNS_SERVER_RECURSION=AllowOnlyForPrivateNetworks  # Параметры рекурсии: Allow, Deny, AllowOnlyForPrivateNetworks, UseSpecifiedNetworkACL.
      # - DNS_SERVER_RECURSION_NETWORK_ACL=192.168.10.0/24  # Список IP-адресов или сетевых адресов, разделенных запятыми, для разрешения доступа. Добавьте символ «!» в начале, чтобы запретить доступ, например, «!192.168.10.0/24» запретит всю подсеть. Список ACL обрабатывается в том же порядке, в котором он указан. Если ни одна сеть не совпадает, политика по умолчанию запрещает все, кроме петлевой. Действительно только для параметра рекурсии `UseSpecifiedNetworkACL`.
      # - DNS_SERVER_RECURSION_DENIED_NETWORKS=1.1.1.0/24   # Список IP-адресов или сетевых адресов, разделенных запятыми, для запрета рекурсии. Действительно только для параметра рекурсии `UseSpecifiedNetworkACL`. Этот параметр устарел, вместо него следует использовать DNS_SERVER_RECURSION_NETWORK_ACL.
      # - DNS_SERVER_ENABLE_BLOCKING=false                  # Настраивает DNS-сервер на блокировку доменных имён с использованием заблокированной зоны и зоны списка заблокированных доменов.
      # - DNS_SERVER_ALLOW_TXT_BLOCKING_REPORT=false        # Указывает, должен ли DNS-сервер отвечать TXT-записями, содержащими отчёт о заблокированном домене, на запросы типа TXT.
      # - DNS_SERVER_FORWARDER_PROTOCOL=Tcp                 # Параметры протокола пересылки: Udp, TCP, Tls, HTTPS, HttpsJson.
      # - DNS_SERVER_LOG_USING_LOCAL_TIME=true              # Включите этот параметр, чтобы использовать локальное время вместо UTC для ведения журнала.
    volumes:
      - ./dns_data:/etc/dns
    sysctls:
      - net.ipv4.ip_local_port_range=1024 65000
```

### Pi-hole

[Pi-hole](https://github.com/pi-hole/pi-hole) - популярное и легковесное решение для блокировки рекламы (отображает график блокировок, автоматически обновляет списки и поддерживает простое API).

[Pi-hole Exporter](https://github.com/eko/pihole-exporter) - экспортер метрик для Prometheus.

```yaml
services:
  # DNS Server + AdBlock
  pihole-server:
    container_name: pihole-server
    image: pihole/pihole:latest
    restart: unless-stopped
    ports:
      # DNS
      - 53:53/tcp
      - 53:53/udp
      # HTTP
      - 8000:8000/tcp
      # HTTPS
      # - 4443:4443/tcp
      # DHCP
      # - 67:67/udp
    environment:
      - TZ=Etc/GMT+3
      - FTLCONF_webserver_api_password=PiHoleAdmin # или docker logs pihole-server | grep random
      - FTLCONF_dns_upstreams=8.8.8.8;1.1.1.1      # корневые DNS-сервера верхнего уровн (TLD), на которые пересылаются запросы
    volumes:
      - ./pihole_data:/etc/pihole
      # - ./pihole.toml:/etc/pihole/pihole.toml
      # - ./custom.list:/etc/pihole/hosts/custom.list
      # - ./hosts:/etc/hosts
    # Для использования DHCP сервера
    # cap_add:
    #   - NET_ADMIN
    # Пробросить хостовую сеть и использовать режим listeningMode = "LOCAL"
    network_mode: host

  # Prometheus metrics from pi-hole
  pihole-exporter:
    container_name: pihole-exporter
    image: ekofr/pihole-exporter:latest
    restart: unless-stopped
    environment:
      # - PIHOLE_HOSTNAME=pihole-server
      - PIHOLE_HOSTNAME=192.168.3.105 # если pihole-server в режиме network_mode: host, указать ip-адрес хоста (или localhost и тоже использовать network_mode: host)
      - PIHOLE_PROTOCOL=http
      - PIHOLE_PORT=8000
      - PIHOLE_PASSWORD=PiHoleAdmin
      - INTERVAL=90s
      - PORT=9617
    ports:
      - 9617:9617
    depends_on:
      - pihole-server
```

### AdGuard Home

[AdGuard Home](https://github.com/AdguardTeam/AdGuardHome) - более современный блокировщик рекламы и отслеживания.

[AdGuard Home Sync](https://github.com/bakito/adguardhome-sync) - синхронизирует конфигурацию AdGuardHome (DNS записи, клиенты, фильтры и общие настройки) с экземплярами реплик.

```yaml
services:
  adguardhome-server:
    image: adguard/adguardhome
    container_name: adguardhome-server
    restart: unless-stopped
    volumes:
      - ./adguardhome_server_data:/opt/adguardhome/work
      - ./adguardhome_server_conf:/opt/adguardhome/conf
    ports:
      # DNS
      - "53:53/tcp"
      - "53:53/udp"
      # DHCP
      # - "67:67/udp"
      # - "68:68/udp"
      # Web
      - "80:80/tcp"
      - "443:443/tcp"
      - "443:443/udp"
      # Prometheus exporter
      - "3000:3000/tcp"
      # DNS over TLS
      # - "853:853/tcp"
      # DNS over QUIC⁠
      # - "784:784/udp"
      # - "853:853/udp"
      # - "8853:8853/udp"
      #  DNSCrypt⁠
      # - "5443:5443/tcp"
      # - "5443:5443/udp"

# Reset password by hash:
# sudo apt-get install apache2
# htpasswd -B -C 10 -n -b admin AdHuardHome
# sudo nano adguard_conf/AdGuardHome.yaml

  adguardhome-sync:
    image: ghcr.io/bakito/adguardhome-sync
    container_name: adguardhome-sync
    restart: unless-stopped
    command: run --config /config/adguardhome-sync.yaml
    volumes:
      - ./adguardhome-sync.yaml:/config/adguardhome-sync.yaml
    ports:
      - 8080:8080 # api + prometheus metrics

  # adguardhome-sync:
  #   image: lscr.io/linuxserver/adguardhome-sync:latest
  #   container_name: adguardhome-sync
  #   restart: unless-stopped
  #   environment:
  #     - PUID=1000
  #     - PGID=1000
  #     - TZ=Etc/UTC+3
  #     - CONFIGFILE=/config/adguardhome-sync.yaml
  #   volumes:
  #     - ./adguardhome-sync.yaml:/config/adguardhome-sync.yaml
  #   ports:
  #     - 8080:8080
```

[AdGuardian-Term](https://github.com/Lissy93/AdGuardian-Term) - TUI интерфейс для управления AdGuard.

`docker run -it lissy93/adguardian`

### CoreDNS

[CoreDNS](https://github.com/coredns/coredns) сервер с встроенным плагином [blocklist](https://github.com/relekang/coredns-blocklist).

```yaml
services:
  coredns-blocklist:
    container_name: coredns-blocklist
    image: lifailon/coredns-blocklist:latest
    build:
      context: .
      dockerfile: coredns/Dockerfile
    command: -conf /etc/coredns/Corefile
    user: 1000:1000
    volumes:
      - ./coredns:/etc/coredns
    environment:
      - GOMAXPROCS=1
    ports:
      - 53:53/udp # DNS listener
      - 9153:9153 # Prometheus metrics
```

### PowerDNS

[PowerDNS/PDNS](https://github.com/PowerDNS/pdns) - DNS сервер.

[PowerDNS-Admin](https://github.com/PowerDNS-Admin/PowerDNS-Admin) - веб-интерфейс для PowerDNS с расширенными функциями. Поддерживает управление прямыми и обратными зонами, контроль доступа в определенной зоне, управление пользователями (а также LDAP, OAuth и 2FA), ведение журнала активности, конфигурация службы PDNS и мониторинг статистики, предоставляет API для управления зонами и записями, а также другие функции.

```yaml
services:
  powerdns-server:
    image: powerdns/pdns-auth-49:latest
    container_name: powerdns-server
    restart: unless-stopped
    environment:
      POWERDNS_launch: gsqlite3
      POWERDNS_gsqlite3_database: /var/lib/powerdns/pdns.sqlite
      POWERDNS_api: yes
      POWERDNS_api_key: power-dns-api-key
      POWERDNS_webserver: yes
      POWERDNS_webserver_address: 0.0.0.0
      POWERDNS_webserver_port: 8081
      POWERDNS_webserver_allow_from: 0.0.0.0/0,::/0
    ports:
      - 53:53/udp
      - 53:53/tcp
      - 8081:8081
    volumes:
      - ./powerdns_db_data:/var/lib/powerdns
    networks:
      - powerdns-network

  powerdns-admin:
    image: ngoduykhanh/powerdns-admin:latest
    container_name: powerdns-admin
    restart: unless-stopped
    environment:
      - PDNS_API_URL=http://powerdns-server:8081
      - PDNS_API_KEY=power-dns-api-key
      - PDNS_VERSION=4.9.0
    ports:
      - 9191:80
    volumes:
      - ./powerdns_admin_data:/var/lib/powerdns-admin
    networks:
      - powerdns-network
    depends_on:
      - powerdns-server

networks:
  powerdns-network:
```

### Blocky

[Blocky](https://github.com/0xERR0R/blocky) - быстрый и легкий DNS-прокси как блокировщик рекламы для локальной сети с множеством функций, поддерживает управление через встроенный [RapiDoc](https://github.com/rapi-doc/RapiDoc).

```yaml
services:
  blocky:
    image: spx01/blocky
    container_name: blocky
    restart: unless-stopped
    hostname: blocky-01
    ports:
      - 53:53/tcp
      - 53:53/udp
      - 4000:4000/tcp # RapiDoc
    environment:
      - TZ=Etc/GMT+3
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - ./config.yml:/app/config.yml:ro # Custom config

  blocky-swagger:
    image: docker.swagger.io/swaggerapi/swagger-ui
    container_name: blocky-swagger
    restart: unless-stopped
    ports:
      - 4001:8080
    environment:
      - SWAGGER_JSON_URL=blocky:4000/docs/openapi.yaml
    depends_on:
      - blocky
```

### Gravity

[Gravity](https://github.com/BeryJu/gravity) - легковесное решение DNS, DHCP и TFTP сервера, использующее `etcd` для полной репликации, подходящее для малых и средних сетей. Поддерживает встроенную кластеризацию (HA), кеширование DNS, блокировку рекламы и метрики Prometheus, а также современный интерфейс с графиками.

```yaml
services:
  gravity:
    image: ghcr.io/beryju/gravity:stable
    container_name: gravity
    restart: unless-stopped
    # Important for this to be static and unique
    hostname: gravity-01
    network_mode: host
    user: root
    volumes:
      - ./gravity_data:/data
    logging:
      driver: json-file
      options:
        max-size: "10m"
        max-file: "3"
```

### GoAway

[GoAway](https://github.com/pommee/goaway) - легкий DNS-сервер, с блокировкой рекрамы и современным интерфейсом панели управления (like Pi-hole).

```yaml
services:
  goaway:
    image: pommee/goaway:latest
    container_name: goaway
    restart: unless-stopped
    cap_add:
      - NET_BIND_SERVICE
      - NET_RAW
    volumes:
     - ./goaway_config:/app/config  # Custom settings.yaml configuration
     - ./goaway_data:/app/data      # Database
    environment:
      - DNS_PORT=53
      - WEBSITE_PORT=8080
      # - DOT_PORT=853
    ports:
      - 53/udp
      - 53/tcp
      - 8053:8080
```

## Proxy Stack

### Traefik

[Traefik](https://github.com/traefik/traefik) - обратный прокси сервер с поддержкой автоматического опредиления сервисов Docker, встроенным веб интерфейсом, метриками Prometheus и трассировкой OTLP.

```yaml
services:
  traefik:
    image: traefik:v3
    container_name: traefik
    restart: always
    # Используем режим хоста для доступа к сети всех контейнеров 
    network_mode: host
    # ports:
    #   - 8080:8080   # Web UI
    #   - 80:80       # HTTP Proxy
    #   - 443:443     # HTTPS Proxy
    #   - 4318:4318   # Prometheus Metrics
    dns:
      - 127.0.0.1
    volumes:
      - ./traefik.yml:/etc/traefik/traefik.yml
      - ./rules:/rules
      - /var/run/docker.sock:/var/run/docker.sock:ro
    healthcheck:
      test: wget -qO- http://127.0.0.1:8080/ping
      start_period: 10s
      interval: 30s
      timeout: 5s
      retries: 5
    labels:
      # Включаем маршрутизацию и определяем имя хоста
      - traefik.enable=true
      - traefik.http.routers.traefik.rule=Host(`traefik.docker.local`)
      # Указываем порт назначения в контейнере (если используется несколько портов)
      - traefik.http.services.traefik.loadbalancer.server.port=8080
      # Создаем базовую авторизацию
      - traefik.http.middlewares.basic-auth-traefik.basicauth.users=admin:$$2y$$05$$c0r5A6SCKX4R6FjuCgRqrufbIE5tmXw2sDPq1vZ8zNrrwNZIH9jgW # htpasswd -nbB admin admin
      # Включаем базовую авторизацию в маршрутизацию текущего сервиса
      - traefik.http.routers.traefik.middlewares=basic-auth-traefik
      # Настраиваем подключение к Authentik
      # - traefik.http.middlewares.authentik.forwardauth.address=http://192.168.3.101:9000/outpost.goauthentik.io/auth/traefik
      # - traefik.http.middlewares.authentik.forwardauth.trustForwardHeader=true
      # - traefik.http.middlewares.authentik.forwardauth.authResponseHeaders=X-authentik-username,X-authentik-groups,X-authentik-entitlements,X-authentik-email,X-authentik-name,X-authentik-uid,X-authentik-jwt,X-authentik-meta-jwks,X-authentik-meta-outpost,X-authentik-meta-provider,X-authentik-meta-app,X-authentik-meta-version
      # Включаем авторизацию через Authentik из провайдера Docker
      # - traefik.http.routers.traefik.middlewares=authentik@docker
      # Включаем авторизацию через Authentik из провайдера file
      # - traefik.http.routers.traefik.middlewares=authentik@file

  jaeger:
    image: jaegertracing/all-in-one:1.55
    container_name: jaeger
    restart: always
    ports:
      - 16686:16686 # UI
      - 4317:4317   # Collector

  tech-dns-srv:
    image: technitium/dns-server:latest
    container_name: tech-dns-srv
    restart: always
    ports:
      - 5380:5380/tcp
      - 53:53/udp
      - 53:53/tcp
    environment:
      - DNS_SERVER_DOMAIN=dns-server
      - DNS_SERVER_FORWARDERS=1.1.1.1,8.8.8.8
      - DNS_SERVER_BLOCK_LIST_URLS=https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
    volumes:
      - ./dns_data:/etc/dns
    sysctls:
      - net.ipv4.ip_local_port_range=1024 65000
    labels:
      - traefik.enable=true
      - traefik.http.routers.tech-dns-srv.rule=Host(`dns.docker.local`)
      - traefik.http.services.tech-dns-srv.loadbalancer.server.port=5380
```

### Nginx Proxy & Docker Gen

[Nginx Proxy](https://github.com/nginx-proxy/nginx-proxy) - настраивает контейнер, работающий под управлением nginx и docker-gen (docker-gen генерирует конфигурации обратного прокси-сервера для nginx и перезагружает nginx при запуске и остановке контейнеров).

[Docker Gen](https://github.com/nginx-proxy/docker-gen) - генератор файлов, который визуализирует шаблоны с использованием метаданных контейнера Docker.

[ACME Companion](https://github.com/nginx-proxy/acme-companion) - используется для автоматической генерации сертификатов letsencrypt, для хостов, использующих переменную `LETSENCRYPT_HOST`.

[Nginx Exporter](https://github.com/nginx/nginx-prometheus-exporter) - экспортер метрик для Prometheus.

```yaml
services:
  # Proxy Server + docker-gen
  nginx-proxy:
    container_name: nginx-proxy
    image: nginxproxy/nginx-proxy
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock:ro
      - ./nginx-status.conf:/etc/nginx/conf.d/status.conf # конфигурация для получения статуса с помощью nginx-exporter 
    ports:
      - 80:80
      - 443:443
    # Apply config to any container on the host (not limited to the current stack in compose)
    network_mode: host
    # labels:
    #   - "com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy=true"

  # Prometheus metrics from nginx
  nginx-exporter:
    image: nginx/nginx-prometheus-exporter:latest
    container_name: nginx-exporter
    restart: unless-stopped
    command:
      - "--nginx.scrape-uri=http://localhost:80/status"
    ports:
      - "9113:9113"
    network_mode: host
    depends_on:
      - nginx-proxy

  # Автоматическая генерация сертификатов letsencrypt, для хостов, использующих переменную LETSENCRYPT_HOST
  # acme-companion:
  #   image: nginxproxy/acme-companion
  #   container_name: nginx-proxy-acme
  #   depends_on:
  #     - nginx-proxy
  #   volumes:
  #     - /var/run/docker.sock:/var/run/docker.sock:ro
  #     - ./certs:/etc/nginx/certs
  #     - ./html:/usr/share/nginx/html
  #     - ./acme.sh:/etc/acme.sh
  #   environment:
  #     - DEFAULT_EMAIL=mail@yourdomain.tld
```

### Nginx Proxy Manager

[Nginx Proxy Manager](https://github.com/NginxProxyManager/nginx-proxy-manager) - веб-интерфейс для управления Nginx сервером в роли Proxy сервера.


```yaml
services:
  nginx-proxy-db:
    image: postgres:latest
    container_name: nginx-proxy-db
    restart: unless-stopped
    environment:
      POSTGRES_USER: "npm"
      POSTGRES_PASSWORD: "npm_password"
      POSTGRES_DB: "npm"
    volumes:
      - ./postgres:/var/lib/postgresql/data
    networks:
      - nginx-network

  nginx-proxy-manager:
    image: docker.io/jc21/nginx-proxy-manager:latest
    container_name: nginx-proxy-manager
    restart: unless-stopped
    ports:
      - 81:81         # Web interface
      - 80:80         # Forward HTTP
      - 443:443       # Forward HTTPS
    environment:
      - DB_POSTGRES_HOST=nginx-proxy-db
      - DB_POSTGRES_PORT=5432
      - DB_POSTGRES_USER=npm
      - DB_POSTGRES_PASSWORD=npm_password
      - DB_POSTGRES_NAME=npm
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
    depends_on:
      - nginx-proxy-db
    networks:
      - nginx-network
    # Auth default for Web interface:
    # login: admin@example.com
    # pass: changeme

  nginx-exporter:
    image: nginx/nginx-prometheus-exporter:latest
    container_name: nginx-exporter
    restart: unless-stopped
    ports:
      - "9113:9113"
    command:
      - "--nginx.scrape-uri=http://nginx-proxy-manager:80/status"
    depends_on:
      - nginx-proxy-manager
    networks:
      - nginx-network

networks:
  nginx-network:
    driver: bridge
```

### HAProxy

[HAProxy](https://github.com/haproxy/haproxy) - обратный прокси сервер и "умный" балансировщик нагрузки (поддерживает healthcheck для проверки доступности).

```yaml
services:
  httpbin-proxy:
    image: haproxy:3.2.4-alpine
    container_name: httpbin-proxy
    restart: unless-stopped
    ports:
      - 8089:8080
      - 2376:2376
    volumes:
      - ./haproxy.cfg:/haproxy.cfg
    command:
      - haproxy
      - -f
      - /haproxy.cfg
      - -d
    environment:
      - STATS_USER=admin
      - STATS_PASS=admin
      - STATS_URI=/
      - METRICS_URI=/metrics

  httpbin-go:
    image: ghcr.io/mccutchen/go-httpbin
    container_name: httpbin-go
    restart: unless-stopped
```

### Pangolin

[Pangolin](https://github.com/fosrl/pangolin) — это обратный прокси-сервер с туннелированием, размещаемый на собственном сервере, с контролем доступа на основе личности и контекста, разработанный для лёгкого раскрытия и защиты приложений, работающих где угодно. Pangolin выступает в роли центрального узла и соединяет изолированные сети, даже находящиеся за строгими брандмауэрами, через зашифрованные туннели, обеспечивая лёгкий доступ к удалённым сервисам без открытия портов и использования VPN.

```yaml
services:
  pangolin:
    image: fosrl/pangolin:1.4.0
    container_name: pangolin
    restart: unless-stopped
    volumes:
      - ./config:/app/config
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3001/api/v1/"]
      interval: "3s"
      timeout: "3s"
      retries: 15
 
  gerbil:
    image: fosrl/gerbil:1.0.0
    container_name: gerbil
    restart: unless-stopped
    command:
      - --reachableAt=http://gerbil:3003
      - --generateAndSaveKeyTo=/var/config/key
      - --remoteConfig=http://pangolin:3001/api/v1/gerbil/get-config
      - --reportBandwidthTo=http://pangolin:3001/api/v1/gerbil/receive-bandwidth
    volumes:
      - ./config/:/var/config
    ports:
      - 51820:51820/udp
      # Порты из traefik через network_mode
      - 443:443
      - 80:80
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    depends_on:
      pangolin:
        condition: service_healthy
 
  traefik:
    image: traefik:v3.3.3
    container_name: traefik
    restart: unless-stopped
    # Порты для сервиса gerbil
    network_mode: service:gerbil
    command:
      - --configFile=/etc/traefik/traefik_config.yml
    volumes:
      - ./traefik.yml:/etc/traefik/traefik.yml
      - /var/run/docker.sock:/var/run/docker.sock:ro
      # - ./letsencrypt:/letsencrypt
    depends_on:
      pangolin:
        condition: service_healthy

networks:
  default:
    driver: bridge
    name: pangolin
```

### Tiny Proxy

[tinyproxy](https://github.com/tinyproxy/tinyproxy) — легковесный прямой (forward) HTTP/HTTPS-прокси-сервер.


```yaml
services:
  tinyproxy:
    image: vimagick/tinyproxy
    container_name: tinyproxy
    restart: unless-stopped
    ports:
      - 1080:8888
    volumes:
      - ./tinyproxy.conf:/etc/tinyproxy/tinyproxy.conf
```

### Proxyfor

[Proxyfor](https://github.com/sigoden/proxyfor) - прямой (forward) и обратный прокси сервер с TUI и Веб-интерфейсом от создателя [dufs](https://github.com/sigoden/dufs) для отображения и фильтрации запросов и ответов.

```yaml
services:
  proxyfor:
    image: sigoden/proxyfor
    container_name: proxyfor
    restart: unless-stopped
    volumes:
      - ~/.proxyfor:/.proxyfor
    # ports:
    #   - 1080:8080
    network_mode: host
    command: --listen 1080 --web

# Install Certificate Authority
# Linux
# sudo curl http://localhost:1080/__proxyfor__/certificate/proxyfor-ca-cert.pem -o /usr/local/share/ca-certificates/proxyfor.crt
# sudo update-ca-certificates
# Windows
# Invoke-RestMethod http://192.168.3.101:1080/__proxyfor__/certificate/proxyfor-ca-cert.cer -OutFile $HOME/Downloads/proxyfor-ca-cert.cer
# certutil -addstore root $HOME/Downloads/proxyfor-ca-cert.cer
```

## VRRP

### KeepAlived

[KeepAlived](https://github.com/acassen/keepalived) - используется для обеспечения высокой доступности (HA) за счет протокола [VRRP](https://ru.wikipedia.org/wiki/VRRP) (Virtual Router Redundancy Protocol), который поднимает один виртуальный IP-адрес для нескольких хостов с проверкой доступности и переключением адреса на другой хост в случае провального healthcheck. Чаще всего используется для отказоустойчивости балансировщиков нагрузки.

Образа контейнера на базе легковесного Alpine с использованием команд для установки и запуска keepalived.

```yaml
services:
  keepalived:
    image: alpine:3.18
    container_name: keepalived
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
      - NET_BROADCAST
      - NET_RAW
    volumes:
      - ./keepalived.conf:/etc/keepalived/keepalived.conf:ro
    network_mode: host
    command: |
      sh -c "
        apk add --no-cache keepalived curl &&
        keepalived --dont-fork --log-console
      "
```

## SSO

### Authentik

[Authentik](https://github.com/goauthentik/authentik) - IDP (поставщик идентификации) и SSO (единая точка входа), который построен с безопасностью в центре каждого фрагмента кода, каждой функции, с акцентом на гибкость и универсальность.

```yaml
services:
  authentik-postgres:
    image: docker.io/library/postgres:16-alpine
    container_name: authentik-postgres
    restart: unless-stopped
    env_file:
    - .env
    # ports:
    #   - 5432:5432
    volumes:
    - ./authentik_database:/var/lib/postgresql/data
    healthcheck:
      test:
      - CMD-SHELL
      - pg_isready -d $${POSTGRES_DB} -U $${POSTGRES_USER}
      interval: 30s
      retries: 5
      start_period: 20s
      timeout: 5s

  authentik-redis:
    image: docker.io/library/redis:alpine
    restart: unless-stopped
    container_name: authentik-redis
    command: --save 60 1 --loglevel warning
    # ports:
    #   - 6379:6379
    volumes:
    - ./redis_data:/data
    healthcheck:
      test:
      - CMD-SHELL
      - redis-cli ping | grep PONG
      interval: 30s
      retries: 5
      start_period: 20s
      timeout: 3s

  authentik-server:
    image: ghcr.io/goauthentik/server:2025.8.4
    restart: unless-stopped
    container_name: authentik-server
    command: server
    env_file:
    - .env
    ports:
    - 9000:9000
    - 9443:9443
    volumes:
    - ./authentik_media:/media
    - ./authentik_custom-templates:/templates
    depends_on:
      authentik-postgres:
        condition: service_healthy
      authentik-redis:
        condition: service_healthy

  authentik-worker:
    image: ghcr.io/goauthentik/server:2025.8.4
    restart: unless-stopped
    container_name: authentik-worker
    command: worker
    env_file:
    - .env
    user: root
    volumes:
    - ./authentik_media:/media
    - ./authentik_certs:/certs
    - ./authentik_custom-templates:/templates
    - /var/run/docker.sock:/var/run/docker.sock
    depends_on:
      authentik-postgres:
        condition: service_healthy
      authentik-redis:
        condition: service_healthy

# Go on http://authentik-server:9000/if/flow/initial-setup
```

env:

```env
POSTGRES_DB=authentik
POSTGRES_USER=authentik
POSTGRES_PASSWORD=AuthentikAdmin

AUTHENTIK_POSTGRESQL__HOST=authentik-postgres
AUTHENTIK_POSTGRESQL__NAME=authentik
AUTHENTIK_POSTGRESQL__USER=authentik
AUTHENTIK_POSTGRESQL__PASSWORD=AuthentikAdmin
AUTHENTIK_REDIS__HOST=authentik-redis
AUTHENTIK_SECRET_KEY=J+fcRg0PtPRrILSeahxEtZwKGKM7irzJU15qp3ImG4XYoHyzsId5tnZjVoPs9XTnH5NwYaviRCVQZKSQ # openssl rand 60 | base64 -w 80
```

## LDAP

### LLDAP

[LLDAP](https://github.com/lldap/lldap) - облегчённый сервер аутентификации (Light LDAP), предоставляющий продуманный и упрощённый интерфейс LDAP для аутентификации и современный интерфейс управления (интегрируется со многими бэкендами, от KeyCloak до Authelia, Nextcloud и другими).

```yaml
services:
  lldap:
    image: lldap/lldap:stable
    ports:
      - 3890:3890   # LDAP
      - 6360:6360   # LDAPS (LDAP Over SSL)
      - 17170:17170 # Web front-end
    volumes:
      - ./lldap_data:/data
    environment:
      - UID=1000
      - GID=1000
      - TZ=Etc/UTC+3
      - LLDAP_JWT_SECRET=REPLACE_WITH_RANDOM
      - LLDAP_KEY_SEED=REPLACE_WITH_RANDOM
      - LLDAP_LDAP_BASE_DN=dc=docker,dc=local
      - LLDAP_LDAP_USER_PASS=LdapAdmin
      # If using LDAPS, set enabled true and configure cert and key path
      - LLDAP_LDAPS_OPTIONS__ENABLED=false
      # - LLDAP_LDAPS_OPTIONS__CERT_FILE=/path/to/certfile.crt
      # - LLDAP_LDAPS_OPTIONS__KEY_FILE=/path/to/keyfile.key
      # Database
      # - LLDAP_DATABASE_URL=mysql://mysql-user:password@mysql-server/my-database
      # - LLDAP_DATABASE_URL=postgres://postgres-user:password@postgres-server/my-database
      # SMTP
      # - LLDAP_SMTP_OPTIONS__ENABLE_PASSWORD_RESET=true
      # - LLDAP_SMTP_OPTIONS__SERVER=smtp.example.com
      # - LLDAP_SMTP_OPTIONS__PORT=465
      # - LLDAP_SMTP_OPTIONS__SMTP_ENCRYPTION=TLS
      # - LLDAP_SMTP_OPTIONS__USER=no-reply@example.com
      # - LLDAP_SMTP_OPTIONS__PASSWORD=PasswordGoesHere
      # - LLDAP_SMTP_OPTIONS__FROM=no-reply <no-reply@example.com>
      # - LLDAP_SMTP_OPTIONS__TO=admin <admin@example.com>
```

### Glauth

[Glauth](https://github.com/glauth/glauth) - современный и молодой сервер аутентификации (Go-lang LDAP Authentication) с управлением через конфигурацию и поддержкой метрик Prometheus.

```yaml
services:
  glauth:
    image: glauth/glauth:latest
    container_name: glauth
    restart: unless-stopped
    environment:
      - TZ=UTC
    ports:
      - 3893:3893    # LDAP port
      # - 3894:3894  # LDAPS port
      - 5555:5555    # API (Web UI and metrics for Prometheus)
    volumes:
      - ./glauth.cfg:/app/config/config.cfg

# sudo apt install ldap-utils
# ldapsearch -LLL -H ldap://localhost:3893 -D "cn=admin1,ou=admins,dc=docker,dc=local" -w LdapAdmin -b "dc=docker,dc=local" cn=admin2
```

### OpenLDAP & phpLDAPadmin

[OpenLDAP](https://github.com/osixia/docker-openldap) - реализация протокола Lightweight Directory Access Protocol с открытым исходным кодом. В состав входят LDAP-демон сервера (slapd) и автономный демон балансировки нагрузки LDAP (lloadd).

[phpLDAPadmin](https://github.com/osixia/docker-phpLDAPadmin) - универсальный Веб-интерфейс для LDAP.

```yaml
services:
  ldap-backend:
    image: osixia/openldap:latest
    container_name: openldap
    restart: unless-stopped
    environment:
      - LDAP_ORGANISATION=Docker Local
      - LDAP_DOMAIN=docker.local
      - LDAP_ADMIN_PASSWORD=LdapAdmin
    ports:
      - 1389:389
      - 1636:636
    volumes:
      - ./ldap_data:/var/lib/ldap
      - ./ldap_config:/etc/ldap/slapd.d
    # healthcheck:
    #   test: ["CMD", "ldapsearch", "-H", "ldap://localhost:1389", "-D", "cn=admin,dc=docker,dc=local", "-w", "LdapAdmin", "-b", "dc=docker,dc=local"]
    #   interval: 30s
    #   timeout: 10s
    #   retries: 3

  ldap-frontend:
    image: osixia/phpldapadmin:latest
    container_name: phpldapadmin
    restart: unless-stopped
    links:
      - ldap-backend:ldap-host
    environment:
      - PHPLDAPADMIN_LDAP_HOSTS=ldap-host
      - PHPLDAPADMIN_HTTPS=false
    ports:
      - 1443:443
    depends_on:
      - ldap-backend

  # ldap-ui:
  #   image: dnknth/ldap-ui
  #   container_name: ldap-ui
  #   restart: unless-stopped
  #   ports:
  #     - 5000:5000
  #   environment:
  #     - LDAP_URL=ldap://ldap-backend/
  #     - BASE_DN=dc=docker,dc=local
  #     - BIND_DN=cn=admin,dc=docker,dc=local
  #     - BIND_PASSWORD=LdapAdmin
  #   depends_on:
  #     - ldap-backend

# Web UI: https://localhost:6443
# Login DN: cn=admin,dc=docker,dc=local
# Password: LdapAdmin

# sudo apt install ldap-utils
# ldapsearch -LLL -H ldap://localhost:1389 -D "cn=admin,dc=docker,dc=local" -w LdapAdmin -b "dc=docker,dc=local"

# TUI LDAP Client: https://github.com/Macmod/godap
# brew install godap
# godap localhost -P 1389 -u "cn=admin,dc=docker,dc=local" -p "LdapAdmin" -r "dc=docker,dc=local"
```

### OpenDJ & LDAP UI

[OpenDJ](https://github.com/OpenIdentityPlatform/OpenDJ) - совместимая служба каталогов, разработанная для платформы Java и обеспечивающая высокопроизводительное, высокодоступное и безопасное хранилище для идентификационных данных.

[LDAP UI](https://github.com/dnknth/ldap-ui) - минималистичный Веб-интерфейс для каталогов LDAP.

```yaml
services:
  ldap-server:
    image: openidentityplatform/opendj:latest
    container_name: opendj
    restart: unless-stopped
    hostname: ldap.docker.local
    stdin_open: true
    tty: true
    ports:
      - 1389:1389
      - 1636:1636
      - 4444:4444
    environment:
      - PORT=1389
      - LDAPS_PORT=1636
      - BASE_DN=dc=docker,dc=local
      - ROOT_USER_DN=cn=admin
      - ROOT_PASSWORD=LdapAdmin

  # ldap-admin:
  #   image: osixia/phpldapadmin:latest
  #   container_name: phpldapadmin
  #   restart: unless-stopped
  #   environment:
  #     - PHPLDAPADMIN_LDAP_HOSTS=ldap-server
  #     - PHPLDAPADMIN_HTTPS=false
  #   ports:
  #     - 1443:443
  #   depends_on:
  #     - ldap-server

  ldap-ui:
    image: dnknth/ldap-ui
    container_name: ldap-ui
    restart: unless-stopped
    ports:
      - 5000:5000
    environment:
      - LDAP_URL=ldap://ldap-server/
      - BASE_DN=dc=docker,dc=local
      - BIND_DN=cn=admin,dc=docker,dc=local
      - BIND_PASSWORD=LdapAdmin
    depends_on:
      - ldap-server

# sudo apt install ldap-utils
# ldapsearch -LLL -H ldap://localhost:1389 -D "cn=admin,dc=docker,dc=local" -w LdapAdmin -b "dc=docker,dc=local"
```

## Docker Stack

### Dockge

[Dockge](https://github.com/louislam/dockge) - веб-интерфейс для управления стеками Docker Compose от создателя [Uptime-Kuma](https://github.com/louislam/uptime-kuma).

```yaml
services:
  # Web interface for Docker Compose
  dockge:
    image: louislam/dockge:1
    container_name: dockge
    restart: always
    volumes:
      - ./dockge_data:/app/data
      - /var/run/docker.sock:/var/run/docker.sock
      # Docker stacks directory on host:container
      - /home/lifailon/docker:/home/lifailon/docker
    # Enable routing for traffic
    # labels:
    #   - traefik.enable=true
    environment:
      # Enable routing for docker-gen
      # - VIRTUAL_HOST=dockge.local
      - DOCKGE_STACKS_DIR=/home/lifailon/docker
      # Доступ к консоли dockge
      - DOCKGE_ENABLE_CONSOLE=true
    ports:
      - 5001:5001
```

### Komodo

[Komodo](https://github.com/moghtech/komodo) - система для управления и мониторинга контейнеров и мониторинга Docker Compose.

🔗 [Komodo Demo](https://demo.komo.do) ↗

```yaml
services:
  mongo:
    image: mongo
    container_name: komodo-db
    restart: unless-stopped
    command: --quiet --wiredTigerCacheSizeGB 0.25
    labels:
      komodo.skip: StopAllContainers
    # ports:
    #   - 27017:27017
    volumes:
      - ./mongo_data:/data/db
      - ./mongo_config:/data/configdb
    environment:
      MONGO_INITDB_ROOT_USERNAME: ${KOMODO_DB_USERNAME}
      MONGO_INITDB_ROOT_PASSWORD: ${KOMODO_DB_PASSWORD}
  
  core:
    image: ghcr.io/moghtech/komodo-core:latest
    container_name: komodo-core
    restart: unless-stopped
    labels:
      komodo.skip: StopAllContainers
    ports:
      - 9120:9120
    env_file: .env
    environment:
      KOMODO_DATABASE_ADDRESS: mongo:27017
      KOMODO_DATABASE_USERNAME: ${KOMODO_DB_USERNAME}
      KOMODO_DATABASE_PASSWORD: ${KOMODO_DB_PASSWORD}
    volumes:
      - ./backups:/backups
      ## Store sync files on server
      # - /path/to/syncs:/syncs
      ## Optionally mount a custom core.config.toml
      # - /path/to/core.config.toml:/config/config.toml
    depends_on:
      - mongo

  ## Deploy Periphery container using this block,
  ## or deploy the Periphery binary with systemd using 
  ## https://github.com/moghtech/komodo/tree/main/scripts
  periphery:
    image: ghcr.io/moghtech/komodo-periphery:latest
    container_name: komodo-periphery
    restart: unless-stopped
    labels:
      komodo.skip: StopAllContainers
    env_file: .env
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /proc:/proc
      - /home/lifailon/docker:/etc/komodo/stacks
```

env:

```env
KOMODO_DB_USERNAME=admin
KOMODO_DB_PASSWORD=admin

TZ=Etc/UTC+3

# Используется для Oauth / предложения URL-адреса Webhook / обратного прокси-сервера Caddy
KOMODO_HOST=https://demo.komo.do
# Отображается во вкладке браузера
KOMODO_TITLE=Komodo
KOMODO_FIRST_SERVER=https://periphery:8120
# Дайте первому серверу индивидуальное имя
KOMODO_FIRST_SERVER_NAME=Local
# Сделать так, чтобы все кнопки вызывали только двойной щелчок, а не полное диалоговое окно подтверждения
KOMODO_DISABLE_CONFIRM_DIALOG=false

# Оценить, как Komodo опрашивает ваши серверы на предмет статуса / статуса контейнера / системной статистики / оповещений
# Параметры: 1-sec, 5-sec, 15-sec, 1-min, 5-min, 15-min (default: 15-sec)
KOMODO_MONITORING_INTERVAL="15-sec"
# Интервал опроса ресурсов на предмет обновлений / автоматизированных действий
# Параметры: 15-min, 1-hr, 2-hr, 6-hr, 12-hr, 1-day (default: 1-hr)
KOMODO_RESOURCE_POLL_INTERVAL="1-hr"

# Used to auth incoming webhooks. Alt: KOMODO_WEBHOOK_SECRET_FILE
KOMODO_WEBHOOK_SECRET=a_random_secret
# Used to generate jwt. Alt: KOMODO_JWT_SECRET_FILE
KOMODO_JWT_SECRET=a_random_jwt_secret
# Time to live for jwt tokens (options: 1-hr, 12-hr, 1-day, 3-day, 1-wk, 2-wk)
KOMODO_JWT_TTL="1-day"

# Включить вход с именем пользователя и паролем
KOMODO_LOCAL_AUTH=true
KOMODO_INIT_ADMIN_USERNAME=admin
KOMODO_INIT_ADMIN_PASSWORD=admin
# Отключить регистрацию новых пользователей
KOMODO_DISABLE_USER_REGISTRATION=false
# Все новые логины включаются автоматически
KOMODO_ENABLE_NEW_USERS=false
# Запретить НЕ администраторам создавать новые ресурсы
KOMODO_DISABLE_NON_ADMIN_CREATE=false
# Позволяет всем пользователям иметь доступ на чтение ко всем ресурсам
KOMODO_TRANSPARENT_MODE=false

# Более красивое ведение журнала с пустыми строками между журналами
KOMODO_LOGGING_PRETTY=false
# Более удобное для восприятия человеком протоколирование конфигурации запуска (многострочное)
KOMODO_PRETTY_STARTUP_CONFIG=false

KOMODO_OIDC_ENABLED=false
KOMODO_GITHUB_OAUTH_ENABLED=false
KOMODO_GOOGLE_OAUTH_ENABLED=false
KOMODO_AWS_ACCESS_KEY_ID=
KOMODO_AWS_SECRET_ACCESS_KEY=

PERIPHERY_ROOT_DIRECTORY=/etc/komodo
# Путь к корневой директории стеков compose (default: ${PERIPHERY_ROOT_DIRECTORY}/stacks)
PERIPHERY_STACK_DIR=/etc/komodo/stacks
KOMODO_PASSKEY=a_random_passkey
PERIPHERY_PASSKEYS=${KOMODO_PASSKEY}
PERIPHERY_SSL_ENABLED=true
PERIPHERY_DISABLE_TERMINALS=false
PERIPHERY_INCLUDE_DISK_MOUNTS=/etc/hostname
PERIPHERY_LOGGING_PRETTY=false
PERIPHERY_PRETTY_STARTUP_CONFIG=false
```

### 1panel

[1panel](https://github.com/1Panel-dev/1Panel) - веб-интерфейс для управления сервером на базе Linux, файлами, базами данных, контейнерами Docker и стеками Docker Compose.

```yaml
services:
  1panel:
    image: moelin/1panel:latest
    container_name: 1panel
    restart: always
    ports:
      - 10086:10086 # http://1panel.docker.local/entrance 1panel:1panel_password
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/lib/docker/volumes:/var/lib/docker/volumes
      # - /home/lifailon/docker:/etc/docker  # Docker Compose root directroy
      - /home/lifailon/docker:/opt/1panel/docker/compose  # Docker Compose root directroy
      - /opt:/opt
      # - /root:/root
    labels:
      createdBy: Apps
```

### DockMan

[DockMan](https://github.com/RA341/dockman) - веб-интерфейс для управления контейнерами и файлами в стеках Docker Compose (like Dockge, но без форматирования).

```yaml
services:
  dockman:
    container_name: dockman
    image: ghcr.io/ra341/dockman:latest
    restart: always
    environment:
      - DOCKMAN_MACHINE_ADDR=192.168.3.101
      - DOCKMAN_PORT=8866
      - DOCKMAN_COMPOSE_ROOT=/home/lifailon/docker
      - DOCKMAN_AUTH_ENABLE=true
      - DOCKMAN_AUTH_USERNAME=admin
      - DOCKMAN_AUTH_PASSWORD=admin
      - DOCKMAN_LOG_LEVEL=debug
      - DOCKMAN_LOG_VERBOSE=true
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      # Stack directory
      - /home/lifailon/docker:/home/lifailon/docker
      - ./dockman_config:/config
    ports:
      - 8866:8866
```

### Docker Web Manager

[Docker Web Manager](https://hub.docker.com/r/lifailon/docker-web-manager) - менеджер управления контекстами Docker (context manager) на базе [fzf](https://github.com/junegunn/fzf) и веб-интерфейс для [lazydocker](https://github.com/jesseduffield/lazydocker) и [ctop](https://github.com/bcicen/ctop) на базе [ttyd](https://github.com/tsl0922/ttyd) с поддержкой авторизации.

```yaml
services:
  docker-web-manager:
    image: lifailon/docker-web-manager:latest
    container_name: docker-web-manager
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - $HOME/.ssh/id_rsa:/root/.ssh/id_rsa
    environment:
      - WEB_USERNAME=admin
      - WEB_PASSWORD=admin
      - SSH_HOSTS=localhost,192.168.3.105,192.168.3.106
      - SSH_USER=lifailon
      - SSH_PORT=2121
      - DOCKER_CLIENT=lazydocker
    ports:
      - 3333:3333
```

### isaiah

[isaiah](https://github.com/will-moss/isaiah) - самостоятельный клон LazyDocker для веб-браузера.

```yaml
services:
  isaiah:
    image: mosswill/isaiah:latest
    container_name: isaiah
    restart: unless-stopped
    ports:
      - "4444:80"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      # - ./isaiah_hosts_list:/docker_hosts
      # local unix:///var/run/docker.sock
      # agent tcp://192.168.3.106:4382
    environment:
      SERVER_PORT: "80"
      AUTHENTICATION_SECRET: "secret"
      MULTI_HOST_ENABLED: "TRUE"

  isaiah-agent:
    image: mosswill/isaiah:latest
    container_name: isaiah-agent
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
    environment:
      SERVER_ROLE: "Agent"
      AUTHENTICATION_SECRET: "secret"
      MASTER_HOST: "192.168.3.105:4444"
      MASTER_SECRET: "secret"
      AGENT_NAME: "rpi-106"
```

### DweebUI

[DweebUI](https://github.com/lllllllillllllillll/DweebUI) - веб-интерфейс для мониторинга ресурсов и управления контейнерамм, образами, томами и сетями, а также имеет встроенный магазин приложений (не работают логи и нет доступа к терминалу).

```yaml
services:
  dweebui:
    image: lllllllillllllillll/dweebui:latest
    container_name: dweebui
    restart: always
    environment:
      - PORT=8000
      - SECRET=AdminSecret # for registration
    volumes:
      - ./dweebui_data:/app/config
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - 8000:8000
```

### Dockpeek

[Dockpeek](https://github.com/dockpeek/dockpeek) — это веб-интерфейс для отображения статистики и обновления образов контейнеров Docker.

```yaml
services:
  dockpeek:
    image: ghcr.io/dockpeek/dockpeek:latest
    container_name: dockpeek
    restart: always
    environment:
      - SECRET_KEY=AdminSecret
      - USERNAME=admin
      - PASSWORD=admin
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - 3420:8000
```

### Watchtower

[Watchtower](https://github.com/containrrr/watchtower) - система для обнаружения новых образов в реестре Docker, а также их автоматического обновления и перезапуска контейнера с отправкой уведомлений.

```yaml
services:
  watchtower:
    image: containrrr/watchtower
    container_name: watchtower
    restart: always
    command: --interval 600 --http-api-metrics --http-api-update
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - WATCHTOWER_NOTIFICATIONS=shoutrrr
      - WATCHTOWER_NOTIFICATIONS_HOSTNAME=<HOST_NAME>
      - WATCHTOWER_NOTIFICATION_URL=telegram://<BOT_API_KEY>@telegram/?channels=<CHAT/CHANNEL_ID>
      - WATCHTOWER_HTTP_API_TOKEN=demotoken
    ports:
      - 8088:8080 # api
```

### DIUN

[DIUN](https://github.com/crazy-max/diun) (Docker Image Update Notifier) - система для получения уведомлений об обновлении образа Docker в реестре Docker.

```yaml
services:
  diun:
    image: crazymax/diun:latest
    container_name: diun
    restart: always
    command: serve
    volumes:
      - ./diun_data:/data
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - TZ=Etc/GMT+3
      - LOG_LEVEL=info
      - LOG_JSON=false
      - DIUN_WATCH_WORKERS=20
      - DIUN_WATCH_SCHEDULE=0 */6 * * *
      - DIUN_WATCH_JITTER=30s
      - DIUN_PROVIDERS_DOCKER=true
      - DIUN_PROVIDERS_DOCKER_WATCHBYDEFAULT=true
      - DIUN_NOTIF_TELEGRAM_TOKEN=
      - DIUN_NOTIF_TELEGRAM_CHATIDS=
      # https://crazymax.dev/diun/faq/?h=entry#notification-template
      - DIUN_NOTIF_TELEGRAM_TEMPLATEBODY=Image {{ .Entry.Image }} in `{{ .Entry.Status }}` status
    labels:
      - diun.enable=true
    healthcheck:
      test: ["CMD", "diun", "notif", "test"]
      interval: 24h
      timeout: 10s
      retries: 1
      start_period: 30s
```

### WUD

[WUD](https://github.com/getwud/wud) (What's up Docker) - веб-интерфейс для поиска обновлений и автоматизации выполнения действий (отправки оповещений, запуска обновления и т.п.).

```yaml
services:
  wud:
    image: getwud/wud
    container_name: wud
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - 5002:3000
```

### Dozzle

[Dozzle](https://github.com/amir20/dozzle) - веб интерфейс для просмотра, анализа и фильтрации (по stream, level, а также поиск с помощью regex и sql-запросов) логов контейнеров Docker или Kubernetes. Поддерживает подключение удаленных хостов с помощью агентов или сокета Docker (например, через прокси в ограниченном режиме доступа) и файловым журналам хостовой системы с помощью кастомного контейнера, а также управление контейнерами (запуск, остановка и доступ к терминалу).

```yaml
services:
  dozzle:
    image: amir20/dozzle:latest
    container_name: dozzle
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./dozzle_data:/data
    environment:
      # Отключить сбор и отправку аналитики
      - DOZZLE_NO_ANALYTICS=true
      # Включить действия (start/stop/restart)
      - DOZZLE_ENABLE_ACTIONS=true
      # Включить доступ к терминалу работающих контейнеров
      - DOZZLE_ENABLE_SHELL=true
      # Включить базовую авторизацию из файла /data/users.yml
      - DOZZLE_AUTH_PROVIDER=simple
      # Подключиться к удаленному хосту через Docker Socket API
      # - DOZZLE_REMOTE_HOST=tcp://192.168.3.105:2375|rpi-105,tcp://192.168.3.106:2375|rpi-106
      # Подключиться к удаленному хосту через Dozzle Agent
      # - DOZZLE_REMOTE_AGENT=192.168.3.105:7007,192.168.3.106:7007
    ports:
      - 9090:8080

  # dozzle-agent:
  #   image: amir20/dozzle:latest
  #   container_name: dozzle-agent
  #   restart: always
  #   command: agent
  #   volumes:
  #     - /var/run/docker.sock:/var/run/docker.sock:ro
  #   # environment:
  #   #   - DOZZLE_HOSTNAME=hv-us-101
  #   ports:
  #     - 7007:7007

  # Container for monitoring syslog file on host
  # dozzle-syslog:
  #   image: alpine
  #   container_name: dozzle-syslog
  #   restart: always
  #   volumes:
  #     - /var/log/syslog:/var/log/custom.log
  #   command:
  #     - tail
  #     - -f
  #     - /var/log/custom.log

  # Container for monitoring files from /var/log on host
  dozzle-varlog:
    image: lifailon/dozzle-varlog:latest
    container_name: dozzle-varlog
    restart: always
    volumes:
      - /var/log:/logs
```

### Beszel

[Beszel](https://github.com/henrygd/beszel) - клиент-серверная система мониторинга не требующая настройки для контейнеров Docker и хостов, на которых они запущены. Использует [PocketBase](https://github.com/pocketbase/pocketbase) для backend, а также поддерживает оповещения в Telegram с помощью Webhook через [Shoutrrr](https://github.com/containrrr/shoutrrr).

```yaml
services:
  # Web interface for monitoring hosts and containers metrics + webhook via shoutrrr
  beszel-server:
    image: henrygd/beszel:latest
    container_name: beszel-server
    restart: always
    extra_hosts:
      - host.docker.internal:host-gateway
    volumes:
      - ./beszel_server_data:/beszel_data
    ports:
      - 8090:8090

  # Agent for monitoring
  beszel-agent:
    image: henrygd/beszel-agent:latest
    container_name: beszel-agent
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./beszel_agent_data:/var/lib/beszel-agent
      # - /mnt/disk/.beszel:/extra-filesystems/sda1:ro
    environment:
      - KEY=Копируем публичный ключ из интерфейса и перезапускаем docker compose
      - HUB_URL=http://beszel-server:8090
      - LISTEN=45876
    # ports:
    #   - 45876:45876
```

### Docker Socket Proxy

[Docker Socket Proxy](https://hub.docker.com/r/lifailon/docker-socket-proxy) - прокси сервер для локального сокета Docker на основе HAProxy (не требуется внесение изменений в системные файлы демона или службы), который поддерживает ограничение доступа к конечным точкам с использованием переменных окружения, отображение статистики соединений и метрики Prometheus.

```yaml
services:
  docker-socket-proxy:
    image: lifailon/docker-socket-proxy:amd64
    container_name: docker-socket-proxy
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - 2375:2375 # Docker API
      - 2376:2376 # HAProxy stats and Prometheus metrics
    environment:
      - SOCKET_PATH=/var/run/docker.sock
      - LOG_LEVEL=info
      - INFO=1
      - PING=1
      - VERSION=1
      - POST=1
      - GRPC=1
      - EXEC=1
      - ALLOW_RESTARTS=1
      - ALLOW_START=1
      - ALLOW_STOP=1
      - AUTH=1
      - CONTAINERS=1
      - IMAGES=1
      - NETWORKS=1
      - BUILD=1
      - COMMIT=1
      - DISTRIBUTION=1
      - EVENTS=1
      - PLUGINS=1
      - VOLUMES=1
      - SESSION=1
      # Swarm
      - SWARM=0             
      - NODES=0             
      - CONFIGS=0           
      - SECRETS=0           
      - SERVICES=0          
      - SYSTEM=0            
      - TASKS=0             
      # HAProxy stats and Prometheus metrics
      - STATS_USER=admin
      - STATS_PASS=admin
      - STATS_URI=/
      - METRICS_URI=/metrics
```

### Docker Registry

```yaml
# sudo apt install apache2-utils -y && htpasswd -Bbn admin admin > ./creds
# mkdir certs && \
# openssl req -x509 -new -nodes -days 365 \
#   -out ./certs/public.pem \
#   -keyout ./certs/private.key \
#   -subj "/C=RU/ST=MSK/L=MSK/O=Registry/OU=Registry/CN=registry.docker.local"

services:
  docker-registry:
    image: registry:latest
    container_name: docker-registry
    ports:
      - 5000:5000
    restart: unless-stopped
    volumes:
      - ./regrepo:/var/lib/registry
      - ./certs:/certs
      - ./creds:/creds
    environment:
      - REGISTRY_HTTP_TLS_CERTIFICATE=/certs/public.pem
      - REGISTRY_HTTP_TLS_KEY=/certs/private.key
      - REGISTRY_AUTH=htpasswd
      - REGISTRY_AUTH_HTPASSWD_REALM=docker-registry
      - REGISTRY_AUTH_HTPASSWD_PATH=/creds
```

### Nexus

[Nexus](https://github.com/sonatype/nexus-public) - единый репозиторий для хранения Docker образов (Docker Registry), двоичных файлов, пакетов (например, npm или nuget) и других артефактов.

```yaml
# mkdir nexus-data && chown -R 200:200 ./nexus-data && chmod -R u+rw ./nexus-data
# sudo cat nexus-data/admin.password

services:
  nexus:
    image: sonatype/nexus3:latest
    container_name: nexus
    restart: unless-stopped
    ports:
      - "8881:8081"
      - "8882:8082" # Settings => Repositories => Create repository => docker-hosted => HTTP
    volumes:
      - ./nexus_data:/nexus-data
    environment:
      - INSTALL4J_ADD_VM_PARAMS=-Xms1g -Xmx2g -XX:MaxDirectMemorySize=2g
```

## k8s Stack

### Kompose UI

[Kompose UI](https://github.com/HaddadJoe/komposeui) - веб-интерфейс для [kompose](https://github.com/kubernetes/kompose) (конвертирует docker-compose файлы в манифесты Kubernetes).

```yaml
services:
  kompose-ui:
    image: jadcham/komposeui
    container_name: kompose-ui
    restart: unless-stopped
    ports:
      - 3500:8000
```

### Web kubectl

[Web kubectl](https://github.com/1Panel-dev/webkubectl) - веб-интерфейс для `kubectl` и [k9s](https://github.com/derailed/k9s) на базе [gotty](https://github.com/yudai/gotty) от создателей [1panel](https://github.com/1Panel-dev/1Panel). Загружаете собственные конфигурации и переключаетесь между ними в интерфейсе.

```yaml
services:
  webkubectl:
    image: kubeoperator/webkubectl
    container_name: webkubectl
    restart: unless-stopped
    privileged: true
    ports:
      - 3501:8080
    environment:
      - SESSION_STORAGE_SIZE=10M
      - KUBECTL_INSECURE_SKIP_TLS_VERIFY=true
      - GOTTY_OPTIONS=--port 8080 --permit-write --permit-arguments
```

### Helm Dashboard

[Helm Dashboard](https://github.com/komodorio/helm-dashboard) - веб-интерфейс для просмотра установленных Helm чартов, истории их изменений и соответствующих ресурсов Kubernetes.

```yaml
services:
  helm-dashboard:
    image: komodorio/helm-dashboard:latest
    container_name: helm-dashboard
    restart: unless-stopped
    volumes:
      - ~/.kube/config:/root/.kube/config:ro
    ports:
      - 3502:8080
```

### Kube Ops View

[Kube Ops View](https://codeberg.org/hjacobs/kube-ops-view) (Kubernetes Operational View) - read-only системная панель, которая позволяет удобно перемещаться между кластерами, отслеживать ноды и состояние подов (визуализирует ряд процессов, таких как создание и уничтожение подов).

```yaml
services:
  kube-ops-view:
    image: hjacobs/kube-ops-view:latest
    container_name: kube-ops-view
    restart: unless-stopped
    ports:
      - 3503:3503
    environment:
      - SERVER_PORT=3503
      - CLUSTERS=http://192.168.3.101:6443
      - KUBECONFIG_PATH=/root/.kube/config
    volumes:
      - ~/.kube/config:/root/.kube/config:ro
```

### Velero UI

[Velero UI](https://github.com/otwld/velero-ui) - веб-интерфейс для управления [Velero](https://github.com/vmware-tanzu/velero) и маниторинга резервного копирования ресурсов в кластерах Kubernetes.

```yaml
services:
  velero-ui:
    image: otwld/velero-ui:latest
    container_name: velero-ui
    restart: unless-stopped
    volumes:
      - ~/.kube/config:/app/.kube/config:ro
      # - /etc/rancher/k3s/k3s.yaml:/app/.kube/config:ro
    environment:
      - PORT=3504
      - KUBE_CONFIG_PATH=/app/.kube/config
    # network_mode: host # use for k3s cluster config on localhost
    ports:
      - 3504:3504 # admin:admin
```

### Headlamp

[Headlamp](https://github.com/kubernetes-sigs/headlamp) - интерфейс для управления и мониторинга кластеров Kubernetes (like [Kubernetes/Dashboard](https://github.com/kubernetes/dashboard)) от команды сообщества Special Interest Groups.

```yaml
services:
  headlamp:
    image: ghcr.io/headlamp-k8s/headlamp:v0.33.0
    container_name: headlamp
    restart: unless-stopped
    command: [
      "--kubeconfig", "/headlamp/.kube/config",
      "--port","64446",
      "--enable-dynamic-clusters"
    ]
    volumes:
      - ~/.kube/config:/headlamp/.kube/config:ro
    ports:
      - 64446:64446
```

### Rancher

[Rancher](https://github.com/rancher/rancher) - упрощает запуск и управление Kubernetes через Веб-интерфейс.

```yaml
services:
  rancher:
    image: rancher/rancher:latest
    container_name: rancher
    restart: unless-stopped
    privileged: true
    volumes:
    - ./rancher_data:/var/lib/rancher
    ports:
    - 3080:80
    - 3443:443
    # Password:
    # docker logs rancher 2>&1 | grep "Bootstrap Password:" | sed -E "s/.+\: //"
```

### Kubetail Dashboard

[Kubetail Dashboard](https://github.com/kubetail-org/kubetail) - веб-интерфейс и инструмент командной строки для отображения логов из разных подов в одном потоке.

```yaml
services:
  kubetail-dashboard:
    # image: lifailon/kubetail-dashboard:0.10.0-amd64
    # build:
    #   context: .
    #   dockerfile: Dockerfile
    image: kubetail/kubetail-dashboard:0.8.2
    container_name: kubetail-dashboard
    restart: unless-stopped
    ports:
      - 7500:7500
    volumes:
      - ~/.kube/config:/kubetail/.kube/config:ro
    command:
      [
        "-a", ":7500",
        "-p", "dashboard.environment:desktop",
        "-p", "kubeconfig:/kubetail/.kube/config",
      ]
```

## CI/CD Stack

### Jenkins

[Jenkins](https://github.com/jenkinsci/jenkins) - CI/CD платформа на базе Java, которая использует свой декларативный синтаксис описания конвееров с поддержкой скриптового языка Groovy, гибкой параметрорезацией и большого числа плагинов.

```yaml
# Предварительно создать директории и предоставить права
# mkdir -p jenkins_home && sudo chown -R 1000:1000 jenkins_home
# mkdir -p jenkins_agent && sudo chown -R 1000:1000 jenkins_agent

services:
  jenkins-server:
    image: jenkins/jenkins:latest
    container_name: jenkins-server
    restart: unless-stopped
    user: "1000:1000"
    volumes:
      - ./jenkins_home:/var/jenkins_home
    ports:
      - "8080:8080"   # Веб-интерфейс и регистрации агентов
      - "50000:50000" # Передача данных и выполнение сборок между Jenkins Controller и агентами

  jenkins-agent:
    # image: jenkins/inbound-agent:latest
    build:
      context: .
      dockerfile: Dockerfile
    container_name: jenkins-agent
    restart: unless-stopped
    depends_on:
      - jenkins-server
    environment:
      # Указать в способе запуска подключение агента к контроллеру, каталог корневой директории /home/jenkins и выбрать количество исполнений ~= количеству ядер
      - JENKINS_URL=${JENKINS_SERVER_URL}
      - JENKINS_AGENT_NAME=${JENKINS_AGENT_NAME}
      # Получить ключ доступа: http://192.168.3.101:8080/manage/computer
      - JENKINS_SECRET=${JENKINS_SECRET}
    user: "1000:1000"
    volumes:
      - ./jenkins_agent:/home/jenkins
    labels:
      # Отключаем автоматическое обновление образа через Watchtower (не поддерживается при использовании build из dockerfile)
      - "com.centurylinklabs.watchtower.enable=false"
```

Dockerfile:

```Dockerfile
FROM jenkins/inbound-agent:latest

USER root

# Обновление и установка дополнительных пакетов
RUN apt-get update && apt-get install -y \
    git \
    curl \
    iputils-ping \
    netcat-openbsd \
    make \
    tmux

# Устанавливаем Ansible
RUN apt-get -y install \
    python3-pip && \
    pip3 install --break-system-packages ansible && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем Go последней версии
RUN ARCH=$(uname -m) && \
    case "$ARCH" in \
        "aarch64" | "arm64") ARCH="arm64" ;; \
        "x86_64"  | "amd64") ARCH="amd64" ;; \
    esac && \
    LATEST_GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -1) && \
    curl -L "https://go.dev/dl/${LATEST_GO_VERSION}.linux-${ARCH}.tar.gz" | tar -xz -C /usr/local

# Добавляем Go в PATH
ENV PATH="/usr/local/go/bin:${PATH}"

# Предоставление права доступа группе jenkins на директорию для сборки
# RUN chown -R jenkins:jenkins /home/jenkins/workspace
RUN chown -R jenkins:jenkins /home/jenkins

USER jenkins

# Check versions
RUN ansible --version && \
    python3 --version && \
    go version

# Переменные для запуска передаются через environment (.env файл) при запуске в docker compose
# /opt/java/openjdk/bin/java -jar /usr/share/jenkins/agent.jar -secret $JENKINS_SECRET -name $JENKINS_AGENT_NAME -url $JENKINS_URL
ENTRYPOINT ["/usr/local/bin/jenkins-agent"]
```

env:

```env
JENKINS_SERVER_URL=http://jenkins-server:8080
JENKINS_AGENT_NAME=local-agent
JENKINS_SECRET=b040ab8fa1de3e64e77ed57d4ce45f42c843950f981f8db18a97091a94395f32
```

### GitLab

```yaml
services:
  gitlab:
    image: gitlab/gitlab-ce:latest
    container_name: gitlab
    restart: unless-stopped
    hostname: gitlab.local
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://localhost'
        nginx['listen_port'] = 80
        nginx['listen_https'] = false
        gitlab_rails['gitlab_shell_ssh_port'] = 2222
    ports:
      - 8888:80 # Web
      - 2222:22 # SSH
    volumes:
      - ./gitlab/config:/etc/gitlab
      - ./gitlab/logs:/var/log/gitlab
      - ./gitlab/data:/var/opt/gitlab
    depends_on:
      - postgres
      - redis

  postgres:
    image: postgres:13
    container_name: gitlab_postgres
    restart: unless-stopped
    environment:
      POSTGRES_USER: gitlab
      POSTGRES_PASSWORD: gitlab
      POSTGRES_DB: gitlabhq_production
    volumes:
      - ./postgres/data:/var/lib/postgresql/data

  redis:
    image: redis:latest
    container_name: gitlab_redis
    restart: unless-stopped
    command: redis-server --appendonly yes
    volumes:
      - ./redis/data:/data

# Login: root
# Password:
# docker exec -it gitlab cat /etc/gitlab/initial_root_password | grep -E ^Pass | sed "s/Password:\s//g"
```

### Gitea

[Gitea](https://github.com/go-gitea/gitea) - легковесный локальный аналог GitLab/GitHub (самостоятельный хостинг Git), API (с поддержкой Swagger Docs) и системой CI/CD на базе GitHub Actions (поддерживает обратную совместимость) с использованием [act](https://github.com/nektos/act).

```yaml
services:
  gitea:
    image: gitea/gitea:latest
    container_name: gitea
    restart: unless-stopped
    environment:
      - USER=git
      - USER_UID=1000
      - USER_GID=1000
      - GITEA__server__DOMAIN=localhost
      - GITEA__server__SSH_PORT=222
      - GITEA__server__HTTP_PORT=3000
      # SQLite
      - GITEA__database__DB_TYPE=sqlite3
      - GITEA__database__PATH=/data/gitea/gitea.db
      # PostgreSQL
      # - GITEA__database__DB_TYPE=postgres
      # - GITEA__database__HOST=gitea-db:5432
      # - GITEA__database__NAME=gitea
      # - GITEA__database__USER=gitea
      # - GITEA__database__PASSWD=gitea
    volumes:
      - ./gitea_data/server:/data
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - 222:222   # SSH
      - 3000:3000 # HTTP
    labels:
      - traefik.enable=true
      - traefik.http.routers.gitea.rule=Host(`git.docker.local`)
      - traefik.http.services.gitea.loadbalancer.server.port=3000
    # depends_on:
    #   - gitea-db

  # gitea-db:
  #   image: docker.io/library/postgres:14
  #   container_name: gitea-db
  #   restart: unless-stopped
  #   environment:
  #     - POSTGRES_USER=gitea
  #     - POSTGRES_PASSWORD=gitea
  #     - POSTGRES_DB=gitea
  #   networks:
  #     - gitea
  #   volumes:
  #     - ./gitea_postgres_data:/var/lib/postgresql/data

  gitea-act-runner:
    image: docker.io/gitea/act_runner:nightly
    container_name: gitea-act-runner
    restart: unless-stopped
    environment:
      CONFIG_FILE: /config.yaml
      GITEA_INSTANCE_URL: http://192.168.3.101:3000
      # http://192.168.3.101:3000/-/admin/actions/runners
      # or
      # docker exec -it gitea gitea --config /data/gitea/conf/app.ini actions generate-runner-token
      GITEA_RUNNER_REGISTRATION_TOKEN: JY1uWsuNiexmvdleG0cbftgOvuHesKlnpZeCxbQA
    volumes:
      - ./config.yaml:/config.yaml
      - ./gitea_data/runner:/data
      - /var/run/docker.sock:/var/run/docker.sock
    network_mode: host
    depends_on:
      - gitea
```

### GoCD

[GoCD](https://github.com/gocd/gocd) - система CI/CD с поддержкой настройки всех этапов (stage, jobs, tasks, exec commands, artifacts, env и params) через пользовательский интерфейс или в формате `XML`.

```yaml
services:
  gocd-server:
    image: gocd/gocd-server:v24.3.0
    container_name: gocd-server
    restart: unless-stopped
    ports:
      - 8153:8153
    user: 0:0
    volumes:
      - ./godata_server:/godata
      - ./godata_server_home:/home/go

  gocd-agent:
    image: gocd/gocd-agent-alpine:v25.3.0
    container_name: gocd-agent
    restart: unless-stopped
    environment:
      - GO_SERVER_URL=http://gocd-server:8153/go
      - AGENT_AUTO_REGISTER_KEY=d4a80630-99de-4bc4-a89b-95a9884d43a3 # cat ./godata_server/config/cruise-config.xml
      - AGENT_AUTO_REGISTER_HOSTNAME=hv-us-101
    user: 0:0
    volumes:
      - ./godata_agent:/godata
      - ./godata_agent_home:/home/go
    depends_on:
      - gocd-server
```

### Drone CI

[Drone CI](https://github.com/drone) - CI/CD платформа, построенная на технологии DinD (Docker in Docker)

```yaml
services:
  drone-server:
    image: drone/drone:2
    container_name: drone-server
    restart: unless-stopped
    volumes:
      - /var/lib/drone:/data
    environment:
      - DRONE_GITEA_SERVER=http://gitea.docker.local
      - DRONE_GITEA_CLIENT_ID=
      - DRONE_GITEA_CLIENT_SECRET=
      - DRONE_RPC_SECRET=droneRpcSecret
      - DRONE_SERVER_HOST=drone.docker.local
      - DRONE_SERVER_PROTO=http
    ports:
      - 80:80
      - 443:443

  drone-runner:
    image: drone/drone-runner-docker:1
    container_name: runner-runner
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - DRONE_RPC_PROTO=http
      - DRONE_RPC_HOST=drone.docker.local
      - DRONE_RPC_SECRET=droneRpcSecret
      - DRONE_RUNNER_CAPACITY=2
      - DRONE_RUNNER_NAME=runner-local
    ports:
      - 3000:3000
```

### Harness

[Harness](https://github.com/harness/harness) - система CI/CD на базе Drone, хостинг исходного кода (gitness) и реестр артефактов с открытым исходным кодом.

```yaml
services:
  harness:
    image: harness/harness
    container_name: harness
    restart: unless-stopped
    ports:
      - 3021:3000
      - 3022:3022
    volumes:
      - ./harness_data:/data
      - /var/run/docker.sock:/var/run/docker.sock
```

### Woodpecker

[Woodpecker](https://github.com/woodpecker-ci/woodpecker) - еще одна платформа CI/CD на базе Drone.

```yaml
services:
  woodpecker-server:
    image: woodpeckerci/woodpecker-server:v3
    container_name: woodpecker-server
    restart: unless-stopped
    ports:
      - 8000:8000
    environment:
      - WOODPECKER_OPEN=true
      - WOODPECKER_HOST=${WOODPECKER_HOST}
      - WOODPECKER_GITHUB=true
      - WOODPECKER_GITHUB_CLIENT=${WOODPECKER_GITHUB_CLIENT}
      - WOODPECKER_GITHUB_SECRET=${WOODPECKER_GITHUB_SECRET}
      - WOODPECKER_AGENT_SECRET=${WOODPECKER_AGENT_SECRET}
    volumes:
      - ./woodpecker_server_data:/var/lib/woodpecker/

  woodpecker-agent:
    image: woodpeckerci/woodpecker-agent:v3
    container_name: woodpecker-agent
    restart: unless-stopped
    command: agent
    environment:
      - WOODPECKER_SERVER=woodpecker-server:9000
      - WOODPECKER_AGENT_SECRET=${WOODPECKER_AGENT_SECRET}
    volumes:
      - ./woodpecker_agent_config:/etc/woodpecker
      - /var/run/docker.sock:/var/run/docker.sock
    depends_on:
      - woodpecker-server
```

### Semaphore

Semaphore - графический интерфейс для Ansible, Terraform, OpenTofu, Bash, Pulumi, Docker и PowerShell, с поддержкой [API](https://semaphoreui.com/api-docs) и [LDAP](https://docs.semaphoreui.com/administration-guide/ldap) авторизацией.

```yaml
services:
  semaphore:
    image: public.ecr.aws/semaphore/pro/server:v2.13.12
    container_name: semaphore
    restart: unless-stopped
    environment:
      - SEMAPHORE_ADMIN=admin
      - SEMAPHORE_ADMIN_NAME=admin
      - SEMAPHORE_ADMIN_EMAIL=admin@localhost
      - SEMAPHORE_ADMIN_PASSWORD=admin
      # Database
      - SEMAPHORE_DB_DIALECT=postgres
      - SEMAPHORE_DB_HOST=semaphore-db
      - SEMAPHORE_DB_NAME=semaphore_db
      - SEMAPHORE_DB_USER=semaphore
      - SEMAPHORE_DB_PASS=semaphore
      - SEMAPHORE_DB_OPTIONS={"sslmode":"disable"}
      # Telegram
      - SEMAPHORE_TELEGRAM_CHAT=
      - SEMAPHORE_TELEGRAM_TOKEN=
      # LDAP
      # - SEMAPHORE_LDAP_ENABLE=yes
      # - SEMAPHORE_LDAP_SERVER=semaphore-ldap:1389
      # - SEMAPHORE_LDAP_BIND_DN=cn=semaphore,dc=docker,dc=local
      # - SEMAPHORE_LDAP_BIND_PASSWORD=semaphore
      # - SEMAPHORE_LDAP_SEARCH_DN=dc=docker,dc=local
      # - SEMAPHORE_LDAP_SEARCH_FILTER=(&(objectClass=inetOrgPerson)(uid=%s))
      # - SEMAPHORE_LDAP_MAPPING_MAIL={{ .cn }}@docker.local
      # - SEMAPHORE_LDAP_MAPPING_UID=|
      # - SEMAPHORE_LDAP_MAPPING_CN=cn
    volumes:
      - ./semaphore/app_data:/var/lib/semaphore
      - ./semaphore/app_conf:/etc/semaphore
    ports:
      - 3030:3000

  semaphore-db:
    image: postgres
    container_name: semaphore-db
    restart: unless-stopped
    environment:
      - POSTGRES_USER=semaphore
      - POSTGRES_PASSWORD=semaphore
      - POSTGRES_DB=semaphore_db
    volumes:
      - ./semaphore/db_data:/var/lib/postgresql/data

  # semaphore-ldap:
  #   image: bitnami/openldap:latest
  #   container_name: semaphore-ldap
  #   environment:
  #     - LDAP_ADMIN_USERNAME=admin
  #     - LDAP_ADMIN_PASSWORD=LdapAdmin
  #     - LDAP_USERS=semaphore
  #     - LDAP_PASSWORDS=semaphore
  #     - LDAP_ROOT=dc=docker,dc=local
  #     - LDAP_ADMIN_DN=cn=semaphore,dc=docker,dc=local
  #   volumes:
  #     - ./semaphore/ldap_data:/var/lib/ldap
  #   ports:
  #     - 1389:1389
  #     - 1636:1636
```

## Monitoring Stack

### Zabbix

```yaml
services:
  zabbix-database:
    image: postgres:15
    restart: unless-stopped
    environment:
      POSTGRES_DB: zabbix_dn
      POSTGRES_USER: zabbix_user
      POSTGRES_PASSWORD: ZabbixAdmin
    volumes:
      - ./zabbix/database:/var/lib/postgresql/data
    healthcheck:
      test: [ "CMD", "pg_isready", "-q", "-d", "zabbix_dn", "-U", "zabbix_user" ]
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 60s

  zabbix-server:
    image: zabbix/zabbix-server-pgsql:6.4.6-ubuntu
    restart: unless-stopped
    environment:
      DB_SERVER_HOST: zabbix-database
      DB_SERVER_PORT: 5432
      POSTGRES_DB: zabbix_dn
      POSTGRES_USER: zabbix_user
      POSTGRES_PASSWORD: ZabbixAdmin
      ZBX_CACHESIZE: 1G
    ports:
      - 10051:10051
    healthcheck:
      test: grep -qr "zabbix_server" /proc/*/status || exit 1
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 90s
    depends_on:
      zabbix-database:
        condition: service_healthy

  zabbix-dashboard:
    image: zabbix/zabbix-web-nginx-pgsql:6.4.6-ubuntu
    restart: unless-stopped
    environment:
      DB_SERVER_HOST: zabbix-database
      DB_SERVER_PORT: 5432
      POSTGRES_DB: zabbix_dn
      POSTGRES_USER: zabbix_user
      POSTGRES_PASSWORD: ZabbixAdmin
      ZBX_SERVER_HOST: zabbix-server
      PHP_TZ: Etc/UTC+3
    ports:
      - 80:8080
      - 443:8443
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/"]
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 90s
    depends_on:
      zabbix-database:
        condition: service_healthy
      zabbix-server:
        condition: service_healthy

  zabbix-agent:
    image: zabbix/zabbix-agent2:6.4.6-ubuntu
    restart: unless-stopped
    environment:
      ZBX_HOSTNAME: Zabbix server
      ZBX_SERVER_HOST: zabbix-server
    depends_on:
      - zabbix-database
      - zabbix-server
```

### ELK

[Elasticsearch](https://github.com/elastic/elasticsearch) - распределенная поисковая и аналитическая система, основанная на библиотеке Apache Lucene. Она используется для быстрого поиска и анализа больших объемов данных в реальном времени, например, для полнотекстового поиска.

[Logstash](https://github.com/elastic/logstash) - система для сбора логов из различных источников, преобразования их в нужный формат и отправляет в Elasticsearch.

[Kibana](https://github.com/elastic/kibana) - веб интерфейс для отображения данных.

[Beats](https://github.com/elastic/beats) - агенты для сбора операционных метрик и логов.

```yaml
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.13.4
    container_name: elasticsearch
    restart: unless-stopped
    environment:
      - node.name=elasticsearch
      - cluster.initial_master_nodes=elasticsearch
      - discovery.type=single-node
      - bootstrap.memory_lock=true
      - ES_JAVA_OPTS=-Xms512m -Xmx512m
      - ELASTIC_PASSWORD=ElasticSearchAdmin
    volumes:
      - ./es_data:/usr/share/elasticsearch/data
      # - ./elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml:ro,Z
    ports:
      - 9200:9200
      - 9300:9300
    ulimits:
      memlock:
        soft: -1
        hard: -1

  logstash:
    image: docker.elastic.co/logstash/logstash:8.13.4
    container_name: logstash
    restart: unless-stopped
    environment:
      - LS_JAVA_OPTS=-Xms256m -Xmx256m
      - LOGSTASH_INTERNAL_PASSWORD=logStashPassword
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
      - ELASTIC_PASSWORD=ElasticSearchAdmin
    volumes:
      - ./logstash.conf:/usr/share/logstash/pipeline/logstash.conf
      # - ./logstash.yml:/usr/share/logstash/config/logstash.yml:ro,Z
      # - ./logstash_pipeline:/usr/share/logstash/pipeline:ro,Z
    ports:
      - 5044:5044
      - 5000:5000/tcp
      - 5000:5000/udp
      - 9600:9600
    depends_on:
      - elasticsearch

  kibana:
    image: docker.elastic.co/kibana/kibana:8.13.4
    container_name: kibana
    restart: unless-stopped
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
      - ELASTICSEARCH_USERNAME=kibana
      - ELASTICSEARCH_PASSWORD=ElasticSearchAdmin
    volumes:
      - ./kibana.yml:/usr/share/kibana/config/kibana.yml:ro,Z
    ports:
      - 5601:5601
    depends_on:
      - elasticsearch

# curl -u elastic:ElasticSearchAdmin http://localhost:9200/_cat/indices
# echo '{"message":"Test log"}' | nc localhost 5000
```

## Game Stack

### Sunshine

[Sunshine](https://github.com/LizardByte/Sunshine) - самостоятельный хостинг-сервер игровых трансляций (like NVIDIA GameStream и Parsec) для клиента [Moonlight](https://github.com/moonlight-stream/moonlight-qt).

```yaml
services:
  sunshine:
    image: lizardbyte/sunshine:latest-ubuntu-24.04
    container_name: sunshine
    restart: unless-stopped
    volumes:
      - ./sunshine_config:/config
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=Etc/GMT+3
    ports:
      - 47984-47990:47984-47990/tcp
      - 47998-48000:47998-48000/udp
      - 48010:48010
    ipc: host
```

### Dolphin

[Dolphin](https://github.com/dolphin-emu/dolphin) - эмулятор GameCube и Wii собранный в [Docker образе](https://github.com/linuxserver/docker-dolphin) для запуска в браузере на базе [Selkies](https://github.com/selkies-project/selkies).

```yaml
services:
  dolphin:
    image: lscr.io/linuxserver/dolphin:latest
    container_name: dolphin
    restart: unless-stopped
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/GMT+3
    volumes:
      - ./dolphin_config:/config
      - ./dolphin_games:/games
    ports:
      - 3001:3001
      - 3002:3000
    shm_size: 1gb
```

### Emulator.js

[Emulator.js](https://github.com/EmulatorJS/EmulatorJS) - веб-интерфейс для [RetroArch](https://github.com/libretro/RetroArch).

🔗 [Emulator.js Demo](https://demo.emulatorjs.org) ↗

```yaml
services:
  emulator.js:
    image: lscr.io/linuxserver/emulatorjs:latest
    container_name: emulator.js
    restart: unless-stopped
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC+3
      - SUBFOLDER=/
    volumes:
      - ./emulatorjs_config:/config
      - ./roms:/data
    ports:
      - 80:80
      - 3000:3000
      # - 4001:4001
```

### Junie

[Junie](https://github.com/Namaneo/Junie) - интерфейс Libretro, работающий в браузере.

🔗 [Junie Demo](https://namaneo.github.io/Junie) ↗

```yaml
services:
  junie:
    image: namaneo/junie
    container_name: junie
    restart: unless-stopped
    volumes:
      - ./games:/junie/games
    ports:
      - 8008:8000
```

## Homelab Stack

### Memos

[Memos](https://github.com/usememos/memos) - сервис заметок (like Google Keep) с поддержкой синтаксиса Merkdown и интеграцией с Telegram (запись теста и файлов через бота).

🔗 [Memos Demo](https://demo.usememos.com/explore) ↗

```yaml
services:
  memos:
    image: neosmemo/memos:stable
    container_name: memos
    restart: unless-stopped
    ports:
      - 5230:5230
    volumes:
      - ./memos_data:/var/opt/memos

  memogram:
    image: lifailon/memogram:0.3.0-amd64
    # build:
    #   context: .
    #   dockerfile: Dockerfile
    container_name: memogram
    restart: unless-stopped
    environment:
      - SERVER_ADDR=memos:5230
      - BOT_TOKEN=
      - ALLOWED_USERNAMES=
```

### Immich

[Immich](https://github.com/immich-app/immich) - система хранения и просмотра фото и видео (клон Google Photo).

🔗 [Immich Demo](https://demo.immich.app) ↗

```yaml
services:
  immich-server:
    image: ghcr.io/immich-app/immich-server:release
    container_name: immich-server
    restart: unless-stopped
    volumes:
      - ./upload_data:/data
      - /etc/localtime:/etc/localtime:ro
    environment:
      - UPLOAD_LOCATION=./data
      - DB_DATA_LOCATION=./postgres
      - TZ=Etc/UTC+3
      - IMMICH_VERSION=v2
      - DB_DATABASE_NAME=immich
      - DB_USERNAME=immich
      - DB_PASSWORD=immich
    ports:
      - 2283:2283
    healthcheck:
      disable: false
    depends_on:
      - redis
      - database

  immich-machine-learning:
    image: ghcr.io/immich-app/immich-machine-learning:release
    container_name: immich-machine-learning
    restart: unless-stopped
    volumes:
      - ./model_cache:/cache
    environment:
      - UPLOAD_LOCATION=./data
      - DB_DATA_LOCATION=./postgres
      - TZ=Etc/UTC+3
      - IMMICH_VERSION=v2
      - DB_DATABASE_NAME=immich
      - DB_USERNAME=immich
      - DB_PASSWORD=immich
    healthcheck:
      disable: false

  redis:
    image: docker.io/valkey/valkey:8-bookworm@sha256:fea8b3e67b15729d4bb70589eb03367bab9ad1ee89c876f54327fc7c6e618571
    container_name: immich-redis
    restart: unless-stopped
    healthcheck:
      test: redis-cli ping || exit 1

  database:
    image: ghcr.io/immich-app/postgres:14-vectorchord0.4.3-pgvectors0.2.0@sha256:41eacbe83eca995561fe43814fd4891e16e39632806253848efaf04d3c8a8b84
    container_name: immich-database
    restart: unless-stopped
    environment:
      POSTGRES_DB: immich
      POSTGRES_USER: immich
      POSTGRES_PASSWORD: immich
      POSTGRES_INITDB_ARGS: '--data-checksums'
    volumes:
      - ./db_data:/var/lib/postgresql/data
    shm_size: 128mb
```

### Invidious

[Invidious](https://github.com/iv-org/invidious) - альтернативный интерфейс YouTube с открытым исходным кодом.

```yaml
services:
  invidious:
    # docker run quay.io/invidious/youtube-trusted-session-generator
    image: quay.io/invidious/invidious:latest
    build:
      context: .
      dockerfile: docker/Dockerfile
    container_name: invidious
    restart: unless-stopped
    ports:
      - 3000:3000
    environment:
      # Gen password for hmac_key: pwgen 20 1
      INVIDIOUS_CONFIG: |
        db:
          dbname: invidious
          user: kemal
          password: kemal
          host: invidious-db
          port: 5432
        check_tables: true
        # external_port:
        # domain:
        # https_only: false
        # statistics_enabled: false
        hmac_key: "aiph2EeShu6ohng0ohqu"
    healthcheck:
      test: wget -nv --tries=1 --spider http://127.0.0.1:3000/api/v1/trending || exit 1
      interval: 30s
      timeout: 5s
      retries: 2

  invidious-db:
    image: docker.io/library/postgres:14
    container_name: invidious-db
    restart: unless-stopped
    volumes:
      - ./invidious_db:/var/lib/postgresql/data
      - ./invidious_data/config/sql:/config/sql
      - ./invidious_data/docker/init-invidious-db.sh:/docker-entrypoint-initdb.d/init-invidious-db.sh
    environment:
      POSTGRES_DB: invidious
      POSTGRES_USER: kemal
      POSTGRES_PASSWORD: kemal
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U $$POSTGRES_USER -d $$POSTGRES_DB"]
```

### MeTube

MeTube - Веб-интерфейс для загрузки видео из YouTube с помощь [yt-dlp](https://github.com/yt-dlp/yt-dlp).

```yaml
services:
  metube:
    image: ghcr.io/alexta69/metube
    container_name: metube
    restart: unless-stopped
    ports:
      - "8090:8081"
    volumes:
      # Директория для хранения видео в хостовой системе : контейнере
      - ./downloads:/downloads
```