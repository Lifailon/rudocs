# npm install -g @bitwarden/cli

# Авторизвация в хранилище (используя client_id и client_secret) и получить токен доступа
# bw login <email> --apikey
# Получить токен сессии
# $session = bw unlock --raw
# Получение всех элементов в хранилище с использованием мастер-пароля
# $items = bw list items --session $session | ConvertFrom-Json
# Получить пароль по названию секрета
# echo "master_password" | bw get item GitHub bw get password $items[0].name
# Завершить сессию
# bw lock

# Авторизация в организации
$client_id = "organization.ClientId"
$client_secret = "client_secret"
$deviceIdentifier = [guid]::NewGuid().ToString()
$deviceName = "PowerShell-Client"
$response = Invoke-RestMethod -Uri "https://identity.bitwarden.com/connect/token" -Method POST `
    -Headers @{ "Content-Type" = "application/x-www-form-urlencoded" } `
    -Body @{
    grant_type       = "client_credentials"
    scope            = "api.organization"
    client_id        = $client_id
    client_secret    = $client_secret
    deviceIdentifier = $deviceIdentifier
    deviceName       = $deviceName
}
# Получение токена доступа
$accessToken = $response.access_token

# Название элемента в хранилище
$itemName = "GitHub"

# Поиск элемента в хранилище
$itemResponse = Invoke-RestMethod -Uri "https://api.bitwarden.com/v1/objects?search=$itemName" -Method GET `
    -Headers @{ "Authorization" = "Bearer $accessToken" }
$item = $itemResponse.data[0]

# Получение информации об элементе
$detailsResponse = Invoke-RestMethod -Uri "https://api.bitwarden.com/v1/objects/$($item.id)" -Method GET `
    -Headers @{ "Authorization" = "Bearer $accessToken" }

# Получение логина и пароля
$detailsResponse.login.username
$detailsResponse.login.password