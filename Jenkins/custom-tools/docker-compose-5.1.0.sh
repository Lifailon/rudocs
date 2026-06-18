# set -x

VERSION=v5.1.0

mkdir -p ~/.local/bin
mkdir -p ~/.docker/cli-plugins

curl -sSL https://github.com/docker/compose/releases/download/$VERSION/docker-compose-linux-$(uname -m) -o ~/.local/bin/docker-compose
chmod +x ~/.local/bin/docker-compose
cp ~/.local/bin/docker-compose ~/.docker/cli-plugins/docker-compose