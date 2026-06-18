mkdir -p ./bin

VERSION=v24.17.0

ARCH=$(uname -m)
case $ARCH in
    x86_64|amd64) ARCH="x64" ;;
    aarch64) ARCH="arm64" ;;
esac

curl -sSL https://nodejs.org/dist/$VERSION/node-$VERSION-linux-$ARCH.tar.gz -o node.tar.gz
tar -zxf node.tar.gz --strip-components=1
rm node.tar.gz