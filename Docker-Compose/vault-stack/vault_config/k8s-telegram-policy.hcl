path "k8s/data/app/telegram-bot" {
  capabilities = ["read"]
}

path "k8s/metadata/app/*" {
  capabilities = ["list"]
}