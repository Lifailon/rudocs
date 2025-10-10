An online runner to play, learn, and create with [D2](https://github.com/terrastruct/d2), the modern diagram scripting language that turns text to diagrams.

The official [d2-playgournd](https://github.com/terrastruct/d2-playground) is build using a `Dockerfile`:

```Dockerfile
FROM golang:1.21-alpine
RUN apk add --no-cache \
    git \
    nodejs \
    npm

WORKDIR /app
RUN git clone https://github.com/terrastruct/d2-playground.git .
RUN git submodule update --init --recursive

RUN npm install -g esbuild yarn
WORKDIR /app/src/js
RUN yarn

WORKDIR /app
RUN go mod download

ENTRYPOINT ["go", "run", "main.go"]
```

Use the following command to run (this will download a pre-built image from [Docker Hub](https://hub.docker.com/repository/docker/lifailon/d2-playground)):

`docker run -d -p 9090:9090 --name d2-playground lifailon/d2-playground:latest`

Use the following command to build the container locally from the `Dockerfile` (this will update the application version to the latest):

`docker build -t lifailon/d2-playground:latest .`