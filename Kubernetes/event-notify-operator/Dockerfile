FROM flant/shell-operator:latest

ARG TARGETARCH
ARG SHOUTRRR_VERSION=0.8.0

RUN apk add --no-cache curl tar && \
    curl -L "https://github.com{SHOUTRRR_VERSION}/shoutrrr-linux-${TARGETARCH}.tar.gz" \
    chmod +x /usr/local/bin/shoutrrr && \
    apk del curl tar

COPY event-notify-operator.sh /hooks/handler.sh
RUN chmod +x /hooks/handler.sh