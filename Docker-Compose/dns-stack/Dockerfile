FROM alpine:latest
RUN apk add --no-cache bash curl jq docker-cli

WORKDIR /hosts-get
COPY hosts-gen hosts-gen.sh
RUN chmod 755 hosts-gen.sh

ENTRYPOINT ["bash","/hosts-get/hosts-gen.sh"]