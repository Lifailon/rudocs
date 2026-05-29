mkdir -p ./bin
curl -sSL https://get.helm.sh/helm-v4.2.0-linux-amd64.tar.gz -o helm-v4.2.0-linux-amd64.tar.gz
tar -zxvf helm-v4.2.0-linux-amd64.tar.gz
sudo mv linux-amd64/helm ./bin/helm
chmod +x ./bin/helm
rm -rf linux-amd64 helm-v4.2.0-linux-amd64.tar.gz