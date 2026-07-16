FROM golang:latest

RUN apt update -y && apt upgrade -y
RUN apt install ffmpeg wget tar -y

ADD "https://github.com/tobychui/arozos/releases/latest/download/arozos_linux_amd64" /arozos/arozos
ADD "https://github.com/aroz-online/launcher/releases/latest/download/launcher_linux_amd64" /arozos/launcher
ADD "https://github.com/tobychui/arozos/releases/latest/download/web.tar.gz" /arozos/web.tar.gz

COPY entrypoint.sh /arozos/entrypoint.sh

WORKDIR /arozos

RUN chmod 744 /arozos/arozos && \
    chmod 744 /arozos/launcher && \
    chmod 644 /arozos/web.tar.gz && \
    chmod 744 /arozos/entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
