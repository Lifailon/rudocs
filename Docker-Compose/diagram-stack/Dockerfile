FROM golang:1.21-alpine
RUN apk add --no-cache \
    git \
    nodejs \
    npm

WORKDIR /app
RUN git clone https://github.com/terrastruct/d2-playground.git .
RUN git submodule update --init --recursive

RUN npm install -g esbuild yarn
WORKDIR /app/src/js
RUN yarn

WORKDIR /app
RUN go mod download

ENTRYPOINT ["go", "run", "main.go"]