mkdir -p ~/.local/bin/docker-compose
curl https://github.com/docker/compose/releases/download/v5.1.0/docker-compose-linux-x86_64 -sSLo ~/.local/bin/docker-compose
cp ~/.local/bin/docker-compose ~/.docker/cli-plugins/docker-compose
chmod +x ~/.local/bin/docker-compose