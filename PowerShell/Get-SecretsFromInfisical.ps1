# npm install -g @infisical/cli

# Авторизоваться в хранилище (cloud или Self-Hosting)
# infisical login
# Инициализировать (выбрать организацию и проект)
# infisical init
# Получить список секретов и их SECRET VALUE из добавленных групп Environments (Development, Staging, Production)
# infisical secrets

# Создать организацию и клиент в Organization Access Control - Identities и предоставить права на Projects (Secret Management)
$clientId = "<client_id>"
# В Authentication сгенерировать секрет (Create Client Secret)
$clientSecret = "<client_secret>"

$body = @{
    clientId     = $clientId
    clientSecret = $clientSecret
}
$response = Invoke-RestMethod -Uri "https://app.infisical.com/api/v1/auth/universal-auth/login" `
    -Method POST `
    -ContentType "application/x-www-form-urlencoded" `
    -Body $body
# Получить токен доступа
$TOKEN = $response.accessToken

# Получить содержимое секрета
$secretName = "FOO" # название секрета
$workspaceId = "82488c0a-6d3a-4220-9d69-19889f09c8c8" # можно взять из url проекта Secret Management
$environment = "dev" # группа
$headers = @{
    Authorization = "Bearer $TOKEN"
}
$secrets = Invoke-RestMethod -Uri "https://app.infisical.com/api/v3/secrets/raw/${secretName}?workspaceId=${workspaceId}&environment=${environment}" -Method GET -Headers $headers
$secrets.secret.secretKey
$secrets.secret.secretValue