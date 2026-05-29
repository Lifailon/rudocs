mkdir -p ./bin
curl -sSLf https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4 -o get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
mv /usr/local/bin/helm ./bin/helm
rm ./get_helm.sh