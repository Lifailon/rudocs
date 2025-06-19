# OpenRouter Telegram Bot

This is an updated Docker image for quickly launching Telegram Bot to interact with OpenRouter from [Docker Hub](https://hub.docker.com/r/lifailon/openrouter-telegram-bot).

No need to copy the [source repository](https://github.com/deinfinite/openrouter-gpt-telegram-bot) to the host machine, fixed the error of missing configuration file, excluded storing variables in the image, support for `amd64` and `arm64` architectures and reduced the size of the final image.

## Launch

- Create a working directory:

```bash
mkdir openrouter-telegram-bot
cd openrouter-telegram-bot
```

- Fill in the required variables in the [.env](https://github.com/Lifailon/PS-Commands/blob/rsa/Docker-Compose/openrouter-telegram-bot/.env) file:

```bash
nano .env

# OpenRouter api key from https://openrouter.ai/settings/keys
API_KEY=
# Telegram api key from https://telegram.me/BotFather
TELEGRAM_BOT_TOKEN=
# Telegram id from https://t.me/getmyid_bot
ADMIN_IDS=
ALLOWED_USER_IDS=
# Free modeles: https://openrouter.ai/models?max_price=0
MODEL=deepseek/deepseek-r1:free
```

- Run the container:

```bash
docker run -d --name OpenRouter-Telegram-Bot \
    -v ./.env:/bot/.env \
    --restart unless-stopped \
    lifailon/openrouter-telegram-bot:latest
```

Or use [docker-compose](https://github.com/Lifailon/PS-Commands/blob/rsa/Docker-Compose/openrouter-telegram-bot/docker-compose.yml):

```bash
curl -sSL https://raw.githubusercontent.com/Lifailon/PS-Commands/refs/heads/rsa/Docker-Compose/openrouter-telegram-bot/docker-compose.yml -o docker-compose.yml
docker-compose up -d
```

## Build

You can build the image yourself (example, if you don't have access to Docker Hub):

```bash
curl -sSL https://raw.githubusercontent.com/Lifailon/PS-Commands/refs/heads/rsa/Docker-Compose/openrouter-telegram-bot/dockerfile -o dockerfile
docker-compose up -d --build
# or build for different architectures
docker buildx build --platform linux/amd64,linux/arm64 .
```