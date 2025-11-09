# Build image
# FROM cgr.dev/chainguard/go:latest AS build
# RUN git clone --depth 1 --branch v0.3.0 --single-branch https://github.com/usememos/telegram-integration /app
# WORKDIR /app
# RUN go mod download
# RUN CGO_ENABLED=0 go build -o memogram ./bin/memogram
# RUN chmod +x memogram

# Final image
# FROM cgr.dev/chainguard/static:latest-glibc
# COPY --from=build /app/memogram .

FROM debian:bookworm-slim
WORKDIR /app
RUN apt-get update && \
    apt-get install -y ca-certificates
ADD https://github.com/usememos/telegram-integration/releases/download/v0.3.0/memogram_v0.3.0_linux_amd64.tar.gz memogram_v0.3.0_linux_amd64.tar.gz
RUN tar -xzf memogram_v0.3.0_linux_amd64.tar.gz && \
    rm memogram_v0.3.0_linux_amd64.tar.gz && \
    chmod +x memogram && \
    ls -lhaR

ENTRYPOINT ["/app/memogram"]