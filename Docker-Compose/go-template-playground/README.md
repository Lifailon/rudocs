Go template engine playground. Three-pane mode: template, input yaml file, and output

The official [repeatit](https://github.com/rytsh/repeatit) is build using a `Dockerfile`:

```Dockerfile
FROM node:20-alpine AS frontend-builder
WORKDIR /app
RUN apk add --no-cache git make bash go
RUN git clone https://github.com/rytsh/repeatit.git .
RUN npm install -g pnpm
RUN make build-front-install
RUN make build-front
RUN make build  # сборка WASM

FROM node:20-alpine AS production
WORKDIR /app
RUN npm install -g serve
COPY --from=frontend-builder /app/_web/build /app/build
COPY --from=frontend-builder /app/_web/static/wasm /app/static/wasm
EXPOSE 8080

ENTRYPOINT ["serve", "-s", "build", "-l", "8080"]
```

Use the following command to run (this will download a pre-built image from [Docker Hub](https://hub.docker.com/repository/docker/lifailon/go-template-playground)):

`docker run -d -p 9090:8080 --name go-template-playground lifailon/go-template-playground:latest`