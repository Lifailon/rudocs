# Toolong Web

This is a simple image to run [toolong](https://github.com/Textualize/toolong) in a web interface via [ttyd](https://github.com/tsl0922/ttyd) to remotely view and filter all `syslog` files.

## Launch

To run the container, create a `docker-compose.yml` and use the image from [Docker Hub](https://hub.docker.com/r/lifailon/toolong-web):

```yml
services:
  toolong-web:
    image: lifailon/toolong-web:latest
    build:
      context: .
      dockerfile: Dockerfile
    container_name: toolong-web
    restart: unless-stopped
    environment:
      - PORT=4444
      - USERNAME=
      - PASSWORD=
      # - LOGPATH=/var/log/syslog*
      - LOGPATH=/var/log/*log*
    ports:
      - 4444:4444
    volumes:
      - /var/log:/var/log:ro
```

`docker-compose up -d`

## Build

```dockerfile
FROM python:3.11-alpine
RUN apk add --no-cache ttyd
RUN pip install --no-cache-dir toolong

ENTRYPOINT ["sh", "-c", "ttyd -W -p ${PORT} $( [ -n \"${USERNAME}\" ] && [ -n \"${PASSWORD}\" ] && echo \"-c ${USERNAME}:${PASSWORD}\" ) tl ${LOGPATH}"]
```

`docker-compose up -d --build`