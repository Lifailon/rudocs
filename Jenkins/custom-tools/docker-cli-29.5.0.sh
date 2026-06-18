mkdir -p ./bin

VERSION=29.5.0

curl -sSL https://download.docker.com/linux/static/stable/$(uname -m)/docker-$VERSION.tgz -o docker.tgz
tar -xzf docker.tgz -C ./bin --strip-components=1 docker/docker
chmod +x ./bin/docker
rm docker.tgz