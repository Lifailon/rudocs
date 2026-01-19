# Docker Web Manager

Switch between hosts to remotely manage Docker containers in your browser.

This project was made possible by combining the capabilities of popular utilities. Realizing that this is mostly a hack, I don't see the point in isolating it into a separate repository, the source code for launching and building the image is available in the [repository](https://github.com/Lifailon/rudocs/tree/main/Docker-Compose/docker-web/docker-web-manager) with notes.

## Demo

![](demo.gif)

## How does it work?

The [fzf](https://github.com/junegunn/fzf) interface is used to select and filter the host list, remote machines are accessed via Docker socket forwarding via the `ssh` protocol, containers and other Docker entities are managed using the [lazydocker](https://github.com/jesseduffield/lazydocker) or [ctop](https://github.com/bcicen/ctop) interfaces. All this runs in the browser, thanks to [ttyd](https://github.com/tsl0922/ttyd), with support for basic authorization (it is also possible to configure `SSL` or authorization via a Proxy server to secure the connection). The final image includes the `docker-cli` client, to be able to connect to the terminal of the selected container via the `exec` method.

## How is this better than other solutions?

- Quick start, without the need for complex settings.
- Ability to use any familiar terminal interface for management (you can add the build process or installation of any tool to the `Dockerfile` yourself).
- Centralized access to remote hosts, without the need to install agents (client part) or configure a socket (publish Docker API).

## Start

To start the container, create a `docker-compose.yaml` file and use the image from [Docker Hub](https://hub.docker.com/r/lifailon/docker-web-manager):

```yml
services:
docker-web-manager:
image: lifailon/docker-web-manager:latest
container_name: docker-web-manager
restart: unless-stopped
volumes:
- /var/run/docker.sock:/var/run/docker.sock
- $HOME/.ssh/id_rsa:/root/.ssh/id_rsa
env_file:
- .env
ports:
- "${WEB_PORT:-3333}:${WEB_PORT:-3333}"
```

Create a `.env` file and update the parameters to connect to remote hosts with Docker installed:

```bash
WEB_PORT=3333
WEB_USERNAME=
WEB_PASSWORD=

SSH_HOSTS=localhost,192.168.3.105,192.168.3.106
SSH_USER=lifailon
SSH_PORT=2121

DOCKER_CLIENT=lazydocker
# DOCKER_CLIENT=ctop
```

## Alternatives

[isaiah](https://github.com/will-moss/isaiah) - independent and self-developed clone of `lazydocker` based on Go and JavaScript for the browser (therefore, some functions may not be available or work differently than in the original project). To manage containers on remote hosts, you need to install agents on the endpoints.