function Get-KinozalTorrentHash {
    param (
        [Parameter(Mandatory = $True)][string]$id,
        [Parameter(Mandatory = $True)][string]$cookies
    )
    $url = "https://kinozal.tv/get_srv_details.php?id=$($id)&action=2"
    $cookies = "uid=...+"
    $headers = @{
        "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"
        "Cookie" = $cookies
    }
    $result = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
    $result -match "Инфо хеш: (.+)</li><li>Размер" | Out-Null
    return $Matches[1]
}

# Example:
# $id = 1656552
# $cookies = "uid=..." # получить cookie в браузере на вкладке сеть из загловка запросов после авторизации на сайте
# Get-KinozalTorrentHash $id $cookies