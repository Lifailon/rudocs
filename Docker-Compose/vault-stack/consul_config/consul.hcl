# Включаем веб-интерфейс
ui = true

# Режим логирования
log_level = "INFO"

acl {
  # Включить управление доступом
  enabled = true
  # Запрещено все, что не разрешено
  default_policy = "deny"
  # Сохранять токены для повторного использования
  enable_token_persistence = true
}

# Настройки для репликации и работы в режиме кластере
ports {
  grpc = 8502
}

# Чтобы сервера доверяли друг другу при выборе лидера
performance {
  raft_multiplier = 1
}
