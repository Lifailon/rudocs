FROM flant/shell-operator:latest

ARG TARGETARCH
ARG SHOUTRRR_VERSION=v0.8.0

COPY event-notify-operator.sh /hooks/handler.sh
RUN apk add --no-cache curl tar && \
    curl -Lf "https://github.com/containrrr/shoutrrr/releases/download/${SHOUTRRR_VERSION}/shoutrrr_linux_${TARGETARCH}.tar.gz" \
    -o /tmp/shoutrrr.tar.gz && \
    tar -xzf /tmp/shoutrrr.tar.gz -C /usr/local/bin shoutrrr && \
    chmod +x /usr/local/bin/shoutrrr /hooks/handler.sh && \
    rm /tmp/shoutrrr.tar.gz && \
    apk del curl tar