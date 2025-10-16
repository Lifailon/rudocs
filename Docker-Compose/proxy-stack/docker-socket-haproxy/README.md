# Docker Socket HAProxy

Proxying a local docker socket based on HAProxy (no daemon or service system file modifications required) with endpoints access control using environment variables.

```yaml
services:
  docker-socket-haproxy:
    image: lifailon/docker-socket-haproxy:latest
    build:
      context: .
      dockerfile: Dockerfile
    container_name: docker-socket-haproxy
    restart: unless-stopped
    environment:
      - INFO=1
      - CONTAINERS=1
      - IMAGES=1
      - PING=1
      - POST=1
      - VERSION=1
      # Required for container updates
      - ALLOW_RESTARTS=1
      - ALLOW_START=1
      - ALLOW_STOP=1
      - NETWORKS=1
      # Optionals (default values)
      - LOG_LEVEL=info
      - SOCKET_PATH=/var/run/docker.sock
      - AUTH=0
      - BUILD=0
      - COMMIT=0
      - CONFIGS=0
      - DISTRIBUTION=0
      - EVENTS=1
      - EXEC=0
      - GRPC=0
      - NODES=0
      - PLUGINS=0
      - SECRETS=0
      - SERVICES=0
      - SESSION=0
      - SWARM=0
      - SYSTEM=0
      - TASKS=0
      - VOLUMES=0
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - 2375:2375
```