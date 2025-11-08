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

[MeshCentral](https://github.com/Ylianst/MeshCentral) - это сервер для управления множеством компьютеров в локальной сети через веб-интерфейс.

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

## API Stack

### Scalar

[Scalar](https://github.com/scalar/scalar) - это интерактивный справочник для документации OpenAPI (like Swagger UI) и REST API клиент в одном веб-приложение.

```yaml
services:
  # REST API Reference & Client
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

```yaml
services:
  step-ci:
    image: ghcr.io/stepci/stepci
    container_name: step-ci
    volumes:
      - ./step-ci-tests:/tests
    command: tests/httpbin.yml
```

## Backup

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

## Bot Stack

### SSH Bot

[SSH Bot](https://github.com/Lifailon/ssh-bot) - это Telegram бот, который позволяет запускать заданные команды на выбранном хосте в домашней сети и возвращать результат их выполнения. Бот не устанавливает постоянное соединение с удаленным хостом, что позволяет выполнять команды асинхронно.

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

[OpenRouter Bot](https://github.com/Lifailon/openrouter-bot) - это Telegram бота для общения с бесплатными и платными моделями ИИ через [OpenRouter](https://openrouter.ai), или локальными LLM, например, через [LM Studio](https://lmstudio.ai).

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

[Harness](https://github.com/harness/harness) - это система CI/CD на базе Drone, хостинг исходного кода (gitness) и реестр артефактов с открытым исходным кодом.

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

## Cloud

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

## Diagram Stack

### D2 Playground

[D2 Playground](https://github.com/terrastruct/d2-playground) - игровая площадка для современного языка сценариев диаграмм, преобразующий текст в диаграммы.

🔗 [Demo](https://play.d2lang.com) ↗

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

### Draw.io

[Draw.io](https://github.com/jgraph/drawio) - это веб-версия бесплатного приложения для создания различных диаграмм (like MS Visio), блок-схем и т.п.

🔗 [Demo](https://app.diagrams.net) ↗

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

## Dev Stack

### IT Tools

IT Tools - огромная коллекция утилит (криптография, конверторы, веб инструменты и многое другое).

🔗 [Demo](https://it-tools.tech) ↗

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

🔗 [Demo](https://transform.tools) ↗

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

[Code Server](https://github.com/coder/code-server) - это VSCode сервер в браузере.

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

🔗 [Demo](https://goplay.tools) ↗

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

### Repeatit (Go Template Playground)

[Repeatit](https://github.com/rytsh/repeatit) - игровая площадка для проверки шаблонов GoLang. Поддерживает рендиринг текста и html шаблонов, функции spting и heml, а также ввод параметров шаблона в форматах yaml, json и toml.

🔗 [Demo](https://repeatit.io) ↗

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
    labels:
      - traefik.enable=true
      - traefik.http.routers.tech-dns-srv.rule=Host(`dns.docker.local`)
      - traefik.http.services.tech-dns-srv.loadbalancer.server.port=5380
```

### Pi-hole

[Pi-hole](https://github.com/pi-hole/pi-hole) - популярное и легковесное решение для блокировки рекламы (отображает график блокировок, автоматически обновляет списки и поддерживает простое API).

[Pi-hole Exporter](https://github.com/eko/pihole-exporter) - экспортер для Prometheus.

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

### OpenLDAP

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
