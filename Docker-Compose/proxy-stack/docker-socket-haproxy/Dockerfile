FROM haproxy:3.2.4-alpine

RUN mkdir -p /var/lib/haproxy

WORKDIR /proxy
COPY haproxy.cfg /proxy/haproxy.cfg 

EXPOSE 2375
USER root

ENV LOG_LEVEL=info \
    SOCKET_PATH=/var/run/docker.sock \
    ALLOW_RESTARTS=0 \
    ALLOW_START=0 \
    ALLOW_STOP=0 \
    AUTH=0 \
    BUILD=0 \
    COMMIT=0 \
    CONFIGS=0 \
    CONTAINERS=0 \
    DISTRIBUTION=0 \
    EVENTS=1 \
    EXEC=0 \
    GRPC=0 \
    IMAGES=0 \
    INFO=0 \
    NETWORKS=0 \
    NODES=0 \
    PING=1 \
    PLUGINS=0 \
    POST=0 \
    SECRETS=0 \
    SERVICES=0 \
    SESSION=0 \
    SWARM=0 \
    SYSTEM=0 \
    TASKS=0 \
    VERSION=1 \
    VOLUMES=0

ENTRYPOINT ["haproxy", "-f", "/proxy/haproxy.cfg"]
