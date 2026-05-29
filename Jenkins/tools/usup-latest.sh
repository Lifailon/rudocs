GITHUB_URL="https://github.com/Lifailon/usup"

ARCH=$(uname -m)
case $ARCH in
    x86_64|amd64) ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
esac

mkdir -p ./bin
BIN_NAME=$(echo $GITHUB_URL | sed -E "s/.+\///g")
GITHUB_LATEST_VERSION=$(curl -L -sS -H "Accept: application/json" "$GITHUB_URL/releases/latest" | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
BIN_URL="$GITHUB_URL/releases/download/$GITHUB_LATEST_VERSION/$BIN_NAME-$GITHUB_LATEST_VERSION-linux-$ARCH"
curl -sSL "$BIN_URL" -o ./bin/$BIN_NAME

chmod +x ./bin/$BIN_NAME