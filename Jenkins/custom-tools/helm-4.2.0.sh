mkdir -p ./bin

VERSION=v4.2.0

ARCH=$(uname -m)
case $ARCH in
    x86_64|amd64) ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
esac

curl -sSL https://get.helm.sh/helm-$VERSION-linux-$ARCH.tar.gz -o helm.tar.gz
tar -zxvf helm.tar.gz
mv linux-$ARCH/helm ./bin/helm
chmod +x ./bin/helm
rm -rf linux-$ARCH helm.tar.gz