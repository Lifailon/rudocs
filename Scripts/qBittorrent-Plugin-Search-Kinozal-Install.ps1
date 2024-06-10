### Укажите адрес до Web сервера qBittorrent а также свой логин и пароль в Kinozal.tv
$qBittorrentAddress = "http://localhost:8888"
$UserName = "user"
$Password = "pass"

$check = $(Invoke-RestMethod "$qBittorrentAddress/api/v2/search/plugins") | Where-Object fullName -Match "Kinozal"
if ($null -ne $check) {
    Write-Host "Module already installed" -ForegroundColor Green
    Write-Host
}
else {
    Write-Host "Install module Kinozal from GitHub" -ForegroundColor Green
    $url = "https://raw.githubusercontent.com/imDMG/qBt_SE/master/engines/kinozal.py"
    $body = @{
        sources = "$url"
    }
    Invoke-RestMethod -Method POST "$qBittorrentAddress/api/v2/search/installPlugin" -Body $body
    while ($true) {
        if ($null -ne $check) {
            break
        } else {
            $check = $(Invoke-RestMethod "$qBittorrentAddress/api/v2/search/plugins") | Where-Object fullName -Match "Kinozal"
        }
    }
    Write-Host "Module installed" -ForegroundColor Green
    Write-Host
    Write-Host "Update credential..." -ForegroundColor Green
    Write-Host
    $conf = Get-Content "$home\AppData\Local\qBittorrent\nova3\engines\kinozal.json"
    $conf = $conf -replace '(")USERNAME(",)','$1!$2'
    $conf = $conf -replace "!","$UserName"
    $conf = $conf -replace '(")PASSWORD(",)','$1@$2'
    $conf = $conf -replace "@","$Password"
    $conf | Out-File "$home\AppData\Local\qBittorrent\nova3\engines\kinozal.json"
    Write-Host "Complated" -ForegroundColor Green
    Write-Host
}

Write-Host "Module list:" -ForegroundColor Green
$(Invoke-RestMethod "$qBittorrentAddress/api/v2/search/plugins") | Select-Object Name,url,enabled,version