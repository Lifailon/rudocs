FROM python:3.11-alpine
RUN apk add --no-cache ttyd
RUN pip install --no-cache-dir toolong

ENTRYPOINT ["sh", "-c", "ttyd -W -p ${PORT} $( [ -n \"${USERNAME}\" ] && [ -n \"${PASSWORD}\" ] && echo \"-c ${USERNAME}:${PASSWORD}\" ) tl ${LOGPATH}"]