# Переменные:
# $subnet_vpn = "26.134." # фиксируем первый 1 или 2 октета подсети
$DISCORD_TOKEN = "MTE5NzE1NjM0NTM3NjQxMTcyOQ.XXXXXX.EzBF6RA9Kx_MSuhLW5elH1U-XXXXXXXXXXXXXX"
$DISCORD_CHANNEL_ID = "119403124XXXXXXXXXX"

# Функция получения IP-адреса
function Get-IP {
    # Если подсеть VPN доступна в подсети офиса и мы получаем динамический IP-адрес, забираем локальный адрес интерфейса:
    # $(ipconfig | Select-String IPv4) -replace ".+: " | Where-Object {$_ -match "^$subnet_vpn"}
    # Если получаем динамический белый IP-адрес от провайдера:
    curl -s https://ifconfig.me
}

# Функция отправки сообщения в канал Discord
function Send-DiscordChannel {
    param (
        $Token,
        $Channel,
        $Text
    )
    $URL = "https://discordapp.com/api/channels/$Channel/messages"
    $Body = @{
        content = $Text
    } | ConvertTo-Json
    curl -s $URL -X POST -H "Authorization: Bot $Token" -H "Content-Type: application/json" -d $Body
}

# Функция чтения сообщений из канала Discord
function Read-DiscordMessages {
    param (
        $Token,
        $Channel,
        [switch]$Last
    )
    $URL = "https://discordapp.com/api/channels/$Channel/messages"
    $Output = curl -s -X GET $URL -H "Authorization: Bot $Token" -H "Content-Type: application/json" | ConvertFrom-Json
    if ($last) {
        $Output[0].content
    }
    else {
        $Output | Select-Object @{Name="Time"; Expression={$_.timestamp}},
        @{Name="Message"; Expression={$_.content}},
        @{Name="UserName"; Expression={$_.author.username}}
    }
}

$Last_IP = Read-DiscordMessages -Token $DISCORD_TOKEN -Channel $DISCORD_CHANNEL_ID -Last
$Current_IP = Get-IP
if ($Last_IP -ne $Current_IP) {
    Send-DiscordChannel -Token $DISCORD_TOKEN -Channel $DISCORD_CHANNEL_ID -Text $Current_IP
}
