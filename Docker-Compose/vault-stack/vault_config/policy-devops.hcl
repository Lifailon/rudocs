# Разрешить чтение секретов в конкретном пути
path "configs/db/*" {
  capabilities = ["read", "list"]
}

# Разрешить создание и обновление секретов
path "configs/apps/*" {
  capabilities = ["create", "update", "read"]
}

# Запретить доступ
path "creds/db" {
  capabilities = ["deny"]
}