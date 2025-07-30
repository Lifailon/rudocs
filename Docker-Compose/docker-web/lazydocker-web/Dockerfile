# Build image
FROM golang:1.21-alpine3.20 AS build
RUN apk add --no-cache git
RUN git clone https://github.com/jesseduffield/lazydocker /lazydocker
WORKDIR /lazydocker
RUN go mod download
ARG TARGETARCH TARGETOS
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /bin/lazydocker

# Final image
FROM alpine:3.20
RUN apk add --no-cache \
    docker-cli \
    ttyd
COPY --from=build /bin/lazydocker /bin/lazydocker

ENTRYPOINT ["sh", "-c", "ttyd -W -p ${PORT:-3333} $( [ -n \"${USERNAME}\" ] && [ -n \"${PASSWORD}\" ] && echo \"-c ${USERNAME}:${PASSWORD}\" ) lazydocker"]