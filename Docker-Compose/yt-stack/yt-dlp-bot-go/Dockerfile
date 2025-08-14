# Upgrade Go version from 22 to 24
FROM golang:1.24 AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN git clone --depth 1 --branch main --single-branch https://github.com/nonoo/yt-dlp-telegram-bot /app

WORKDIR /app
# Copy from source code
# COPY go.mod go.sum /app/
RUN go mod download
# Update dependencies
RUN go get -u ./...
RUN go mod tidy
# COPY . .

# Build for different architecture
ARG TARGETOS TARGETARCH
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v
# RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v

FROM python:alpine
RUN apk update && apk upgrade && apk add --no-cache ffmpeg

COPY --from=builder /app/yt-dlp-telegram-bot /app/yt-dlp-telegram-bot
COPY --from=builder /app/yt-dlp.conf /root/yt-dlp.conf

ENV API_ID=
ENV API_HASH=
ENV BOT_TOKEN=
ENV ALLOWED_USERIDS=
ENV ADMIN_USERIDS=
ENV ALLOWED_GROUPIDS=
ENV YTDLP_COOKIES=

ENTRYPOINT ["/app/yt-dlp-telegram-bot"]