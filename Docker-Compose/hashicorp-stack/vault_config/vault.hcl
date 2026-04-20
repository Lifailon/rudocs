# Использовать локальное файловое хранилище
# storage "file" {
#   path = "/vault/file"
# }

# Использование Consul для хранения данных (backend)
storage "consul" {
  address = "consul-master:8500"
  path    = "vault/"
  # Получить токен доступа с помощью команды consul acl bootstrap
  token   = "65a0093a-b8cb-3a94-642f-fb9187265f46"
}

# Режим высокой доступности Vault (frontend)
# На второй ноде используется такая же конфигурация с пробросом порта 8201:8200
# ha_enabled = true
# api_addr     = "http://vault-01:8200" 
# cluster_addr = "https://vault-02:8201"

# Если false, запретит выгрузку данных Vault в файл подкачки на диск
disable_mlock = true

# Настройка слушателя для REST API
# Swagger UI: http://192.168.3.101:8200/ui/vault/tools/api-explorer
listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}

# Включение интерфейс
ui = true

# Включить метрики для Prometheus
telemetry {
  prometheus {
    enabled = true
    endpoint = "/metrics"
  }
}

# Логирование
log_level = "debug"
audit "file" {
  file_path = "/vault/file/logs/audit.log"
}