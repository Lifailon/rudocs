FROM node:20-alpine AS frontend-builder
WORKDIR /app
RUN apk add --no-cache git make bash go
RUN git clone https://github.com/rytsh/repeatit.git .
RUN npm install -g pnpm
RUN make build-front-install
RUN make build-front
RUN make build  # сборка WASM

FROM node:20-alpine AS production
WORKDIR /app
RUN npm install -g serve
COPY --from=frontend-builder /app/_web/build /app/build
COPY --from=frontend-builder /app/_web/static/wasm /app/static/wasm
EXPOSE 8080

ENTRYPOINT ["serve", "-s", "build", "-l", "8080"]