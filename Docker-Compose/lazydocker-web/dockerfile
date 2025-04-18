FROM golang:1.21-alpine3.20 AS build
RUN apk add --no-cache git
RUN git clone https://github.com/jesseduffield/lazydocker /lazydocker
WORKDIR /lazydocker
RUN go build -o /bin/lazydocker

FROM alpine:3.20
RUN apk add --no-cache ttyd docker-cli
COPY --from=build /bin/lazydocker /bin/lazydocker

ENTRYPOINT ["sh", "-c", "ttyd -W -p ${PORT} $( [ -n \"${USERNAME}\" ] && [ -n \"${PASSWORD}\" ] && echo \"-c ${USERNAME}:${PASSWORD}\" ) lazydocker"]