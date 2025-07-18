FROM alpine:latest
RUN apk update && apk add --no-cache iperf3
ENV PORT=5201
EXPOSE $PORT
CMD ["sh", "-c", "iperf3 -s -p $PORT"]

# docker build -t iperf-server .
# docker run -d -p 5201:5201 --name iperf-server iperf-server