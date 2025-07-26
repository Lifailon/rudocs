# Использовать локальное файловое хранилище
# storage "file" {
#   path = "/vault/file"
# }

# Использование Consul в качестве backend для хранения данных
storage "consul" {
  address = "consul:8500"
  path    = "vault/"
  token   = "382834da-28b6-c72c-7ffb-11acf9bf20bc" # использовать новый токен доступа или созданный при инициализации ACL (consul acl bootstrap)
}

# Отключение режим dev (не будет выгружать данные в память)
disable_mlock = false

# Настройка слушателя для REST API
listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1  # Отключить TLS
}

# Включение интерфейс
ui = true

# Включение аутентификации в API по токену
api_addr = "http://localhost:8200"
auth "token" {}

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
