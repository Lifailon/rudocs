$vaultUrl = "http://192.168.3.101:8200/v1/kv/data/$path"
$TOKEN = "hvs.rxlYkJujkX6Fdxq2XAP3cd3a"
$Headers = @{
    "X-Vault-Token" = $TOKEN
}
# Путь до секретов (создается в корне kv)
$path = "main-path"
$data = Invoke-RestMethod -Uri $vaultUrl -Method GET -Headers $Headers
# Получить содержимое ключа по его названию (key_name)
$data.data.data.key_name # secret_value

# Перезаписать все секреты
$Headers = @{
    "X-Vault-Token" = $TOKEN
}
$Body = @{
    data = @{
        key_name_1 = "key_value_1"
        key_name_2 = "key_value_2"
    }
    options = @{}
    version = 0
} | ConvertTo-Json

$updateUrl = "http://192.168.3.101:8200/v1/kv/data/main-path"
Invoke-RestMethod -Uri $updateUrl -Method POST -Headers $Headers -Body $Body

# Удалить все секреты
Invoke-RestMethod -Uri "http://192.168.3.101:8200/v1/kv/data/main-path" -Method DELETE -Headers $Headers