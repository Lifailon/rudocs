### Укажите адрес до Web сервера qBittorrent
$qBittorrentAddress = "http://localhost:8888"

$check = $(Invoke-RestMethod "$qBittorrentAddress/api/v2/search/plugins") | Where-Object fullName -Match "RuTor"
if ($null -ne $check) {
    Write-Host "Module already installed" -ForegroundColor Green
    Write-Host
}
else {
    Write-Host "Install module RuTor from GitHub" -ForegroundColor Green
    $url = "https://raw.githubusercontent.com/imDMG/qBt_SE/master/engines/rutor.py"
    $body = @{
        sources = "$url"
    }
    Invoke-RestMethod -Method POST "$qBittorrentAddress/api/v2/search/installPlugin" -Body $body
    while ($true) {
        if ($null -ne $check) {
            break
        } else {
            $check = $(Invoke-RestMethod "$qBittorrentAddress/api/v2/search/plugins") | Where-Object fullName -Match "RuTor"
        }
    }
    Write-Host "Module installed" -ForegroundColor Green
    Write-Host
}

Write-Host "Module list:" -ForegroundColor Green
$(Invoke-RestMethod "$qBittorrentAddress/api/v2/search/plugins") | Select-Object Name,url,enabled,version