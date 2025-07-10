# Syslog Web

This is a simple image to run [toolong](https://github.com/Textualize/toolong) in a web interface via [ttyd](https://github.com/tsl0922/ttyd) to remotely view and filter all `syslog` files.

## Launch

```bash
mkdir syslog-web
cd syslog-web
```

To run the container, create a `docker-compose.yml` and use the image from [Docker Hub](https://hub.docker.com/r/lifailon/syslog-web):

```yml
services:
  syslog-web:
    container_name: syslog-web
    image: lifailon/syslog-web:latest
    build:
      context: .
      dockerfile: dockerfile
    restart: unless-stopped
    volumes:
      - /var/log:/var/log
    env_file:
      - .env
    environment:
      - PORT=${PORT}
      - USERNAME=${USERNAME}
      - PASSWORD=${PASSWORD}
    ports:
      - "${PORT}:${PORT}"
```

`docker-compose up -d`

To add basic authorization in the web interface or change the port, create a `.env` file next to it with the following contents:

```bash
PORT=4444
USERNAME=admin
PASSWORD=admin
```

## Build

```dockerfile
FROM python:3.11-alpine
RUN apk add --no-cache ttyd
RUN pip install --no-cache-dir toolong

ENTRYPOINT ["sh", "-c", "ttyd -W -p ${PORT} $( [ -n \"${USERNAME}\" ] && [ -n \"${PASSWORD}\" ] && echo \"-c ${USERNAME}:${PASSWORD}\" ) tl /var/log/syslog*"]
```

`docker-compose up -d --build`