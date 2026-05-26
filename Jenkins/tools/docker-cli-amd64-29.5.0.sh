mkdir -p ./bin
curl https://download.docker.com/linux/static/stable/x86_64/docker-29.5.0.tgz -sSLo docker.tgz
tar -xzf docker.tgz -C ./bin --strip-components=1 docker/docker
chmod +x ./bin/docker
rm docker.tgz