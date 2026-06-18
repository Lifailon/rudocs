mkdir -p ~/.docker/cli-plugins

VERSION=v0.34.1

ARCH=$(uname -m)
case $ARCH in
    x86_64|amd64) ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
esac

curl -sSL https://github.com/docker/buildx/releases/download/$VERSION/buildx-$VERSION.linux-$ARCH -o ~/.docker/cli-plugins/docker-buildx
chmod +x ~/.docker/cli-plugins/docker-buildx