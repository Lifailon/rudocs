mkdir -p ./bin

VERSION=v0.5.0

OS="$(uname | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
KREW="krew-${OS}_${ARCH}"

curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/${VERSION}/${KREW}.tar.gz"
tar zxvf $KREW.tar.gz
chmod +x $KREW
mv $KREW ./bin/krew
rm -f $KREW.tar.gz LICENSE