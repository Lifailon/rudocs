$url = "http://ip:port"
$cred = "login:password"

$exportPath = "${home}/Documents/Backup/grafana-dashboards"
if (-not (Test-Path $exportPath)) {
    New-Item -ItemType Directory $exportPath | Out-Null
}

$base64Auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($cred))
$headers = @{
    Authorization = "Basic $base64Auth"
}

$dashboards = Invoke-RestMethod "$url/api/search?type=dash-db" -Headers $headers
foreach ($dashboard in $dashboards) {
    $title = $($dashboard.title -replace '[\\/:*?"<>|]','_' -replace "\s","-") + ".json"
    $uid = $dashboard.uid
    Invoke-RestMethod "$url/api/dashboards/uid/${uid}" -Headers $headers -OutFile "$exportPath/$title"
    Write-Host "Export ${title}  =>  $exportPath/$title"
}