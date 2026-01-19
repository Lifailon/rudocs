$url = "http://ip:port"
$login = "login"
$token = "API Token only"

$sourcePath = "${home}/Documents/Backup/jenkins-jobs"
$sourceJobName = "Remote Parallel Commands Run"
$newJobName = "Remote Parallel Commands Run Copy"
$importFile = "${sourcePath}/${sourceJobName}.xml"

$cred = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${login}:${token}"))
$headers = @{
    "Authorization" = "Basic $cred"
    "Content-Type" = "application/xml"
}

if (Test-Path $importFile) {
    $jobConfig = Get-Content $importFile -Raw -Encoding Byte
    $createJobUrl = "$url/createItem?name=$newJobName"
    try {
        Invoke-RestMethod -Uri $createJobUrl -Method Post -Headers $headers -Body $jobConfig
        Write-Host "Job successfully created: $newJobName" -ForegroundColor Green
    } catch {
        Write-Host "Error creating job: $_" -ForegroundColor Red
    }
} else {
    Write-Host "Job not found: $importFile" -ForegroundColor Red
}