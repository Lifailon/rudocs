FROM alpine:latest

# Install packages
RUN apk add --no-cache tor obfs4proxy privoxy curl && \
    mkdir -p /var/log/privoxy /var/run/tor && \
    chmod 700 /var/lib/tor && \
    chown -R tor:tor /var/lib/tor /etc/tor /var/log/privoxy

# Privoxy configuration
RUN echo 'listen-address 0.0.0.0:8118' > /etc/privoxy/config && \
    echo 'forward-socks5t / 127.0.0.1:9150 .' >> /etc/privoxy/config && \
    echo 'debug 1' >> /etc/privoxy/config && \
    echo 'debug 2' >> /etc/privoxy/config && \
    echo 'debug 8' >> /etc/privoxy/config

# Create start script
RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'privoxy --no-daemon /etc/privoxy/config &' >> /entrypoint.sh && \
    echo '/usr/bin/tor -f /etc/tor/torrc' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]