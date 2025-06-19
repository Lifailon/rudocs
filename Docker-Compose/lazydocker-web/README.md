# LazyDocker-Web

This image is a Web interface for the [lazydocker](https://github.com/jesseduffield/lazydocker?tab=readme-ov-file) (TUI to manage everything Docker) based on [ttyd](https://github.com/tsl0922/ttyd). The image is built from a very simple [Dockerfile](https://github.com/Lifailon/PS-Commands/blob/rsa/Docker-Compose/lazydocker-web/dockerfile) without changing the source code.

## Launch

To run the container, create a `docker-compose.yml` and use the image from [Docker Hub](https://hub.docker.com/r/lifailon/lazydocker-web):

```yml
services:
  lazydocker-web:
    image: lifailon/lazydocker-web:latest
    container_name: lazydocker-web
    restart: unless-stopped
    # Permissions for Docker Socket in host system
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    # TUI mode
    # stdin_open: true
    # tty: true
    # Web mode
    env_file:
      - .env
    environment:
      - PORT=${PORT}
      - USERNAME=${USERNAME}
      - PASSWORD=${PASSWORD}
    ports:
      - "${PORT}:${PORT}"
```

To add basic authorization in the web interface or change the port, create a `.env` file next to it with the following contents:

```
PORT=3333
USERNAME=admin
PASSWORD=admin
```

## Alternatives

[isaiah](https://github.com/will-moss/isaiah) - Independent and self-hosted development clone of lazydocker based on Go and JavaScript for the Web.