$cred = "login:password"
$url = "ip:port"

$base64Auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($cred))
$headers = @{
    Authorization = "Basic $base64Auth"
}

$dashboards = Invoke-RestMethod "http://$url/api/search?type=dash-db" -Headers $headers
foreach ($dashboard in $dashboards) {
    $title = $($dashboard.title -replace '[\\/:*?"<>|]','_' -replace "\s","-") + ".json"
    $uid = $dashboard.uid
    Write-Host "Export ${title}"
    Invoke-RestMethod "http://192.168.3.105:9091/api/dashboards/uid/${uid}" -Headers $headers -OutFile $title
}