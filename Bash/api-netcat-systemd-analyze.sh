#!/bin/bash
while true; do
	echo -e "HTTP/1.1 200 OK\n\n$(systemd-analyze plot)" | nc -l -w 1 -p 8888
done