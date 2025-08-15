FROM alpine:3.20
RUN apk add --no-cache bash
COPY entrypoint /entrypoint.sh
RUN chmod 755 /entrypoint.sh
WORKDIR /logs
ENTRYPOINT ["bash", "-c", "/entrypoint.sh"]