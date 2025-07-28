# Build image
FROM golang:1.23-alpine3.20 AS build
RUN apk add -U -q --progress --no-cache git
RUN git clone https://github.com/relekang/coredns-blocklist /coredns-blocklist
WORKDIR /coredns-blocklist/example
RUN go mod download
ARG TARGETOS TARGETARCH
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /coredns

# Final image
FROM alpine:3.20
WORKDIR /
COPY --from=build /coredns /coredns
RUN chmod +x /coredns
EXPOSE 53 53/udp

ENTRYPOINT ["/coredns"]