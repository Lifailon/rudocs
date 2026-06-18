mkdir -p ./bin

VERSION=v1.36.0

ARCH=$(uname -m)
case $ARCH in
    x86_64|amd64) ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
esac

curl -sSL https://dl.k8s.io/release/$VERSION/bin/linux/$ARCH/kubectl -o ./bin/kubectl
chmod +x ./bin/kubectl