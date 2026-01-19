# LazyDocker-Web

This image is a Web interface for the [lazydocker](https://github.com/jesseduffield/lazydocker?tab=readme-ov-file) (TUI to manage everything Docker) based on [ttyd](https://github.com/tsl0922/ttyd). The image is built from a very simple [Dockerfile](https://github.com/Lifailon/rudocs/blob/main/Docker-Compose/lazydocker-web/Dockerfile) without changing the source code.

## Launch

To run the container, create a `docker-compose.yml` and use the image from [Docker Hub](https://hub.docker.com/r/lifailon/lazydocker-web):

```yml
services:
  lazydocker-web:
    image: lifailon/lazydocker-web:latest
    container_name: lazydocker-web
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    env_file:
      - .env
    ports:
      - "${PORT:-3333}:${PORT:-3333}"
```

To add basic authorization in the web interface or change the port, create a `.env` file next to it with the following contents:

```bash
PORT=3333
USERNAME=admin
PASSWORD=admin
```

## Alternatives

[isaiah](https://github.com/will-moss/isaiah) - independent development clone of lazydocker for the Web based on Go and JavaScript.