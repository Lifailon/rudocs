### Укажите адрес до Web сервера qBittorrent
$qBittorrentAddress = "http://localhost:8888"

$check = $(Invoke-RestMethod "$qBittorrentAddress/api/v2/search/plugins") | Where-Object fullName -Match "NoNaMe-Club"
if ($null -ne $check) {
    Write-Host "Module already installed" -ForegroundColor Green
    Write-Host
}
else {
    Write-Host "Install module NoNaMe-Club from GitHub" -ForegroundColor Green
    $url = "https://raw.githubusercontent.com/imDMG/qBt_SE/master/engines/nnmclub.py"
    $body = @{
        sources = "$url"
    }
    Invoke-RestMethod -Method POST "$qBittorrentAddress/api/v2/search/installPlugin" -Body $body
    while ($true) {
        if ($null -ne $check) {
            break
        } else {
            $check = $(Invoke-RestMethod "$qBittorrentAddress/api/v2/search/plugins") | Where-Object fullName -Match "NoNaMe-Club"
        }
    }
    Write-Host "Module installed" -ForegroundColor Green
    Write-Host
}

Write-Host "Module list:" -ForegroundColor Green
$(Invoke-RestMethod "$qBittorrentAddress/api/v2/search/plugins") | Select-Object Name,url,enabled,version