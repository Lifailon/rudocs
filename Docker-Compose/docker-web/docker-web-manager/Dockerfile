# Image for lazydocker build
FROM golang:1.21-alpine3.20 AS build-lazydocker
RUN apk add --no-cache git
RUN git clone https://github.com/jesseduffield/lazydocker /lazydocker
WORKDIR /lazydocker
RUN go mod download
ARG TARGETARCH TARGETOS
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /bin/lazydocker

# Image for ctop build
FROM golang:1.21-alpine3.20 AS build-ctop
RUN apk add --no-cache git
RUN git clone https://github.com/bcicen/ctop /ctop
WORKDIR /ctop
RUN go mod download
ARG TARGETARCH TARGETOS
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /bin/ctop

# Final image
FROM alpine:3.20
COPY --from=build-lazydocker /bin/lazydocker /bin/lazydocker
COPY --from=build-ctop /bin/ctop /bin/ctop
COPY entrypoint /entrypoint.sh
RUN chmod 755 /entrypoint.sh
RUN apk add --no-cache \
    bash \
    openssh \
    docker-cli \
    fzf \
    ttyd

ENTRYPOINT ["bash", "-c", "/entrypoint.sh"]