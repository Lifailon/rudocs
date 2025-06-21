$url = "http://ip:port"
$login = "login"
$token = "API Token or Password"

$exportPath = "${home}/Documents/Backup/jenkins-jobs"
if (-not (Test-Path $exportPath)) {
    New-Item -ItemType Directory $exportPath | Out-Null
}

$cred = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${login}:${token}"))
$headers = @{
    "Authorization" = "Basic $cred"
}

$jobsList = Invoke-RestMethod "$url/api/json?tree=jobs[name]" -Headers $headers
$jobsListName = $jobsList.jobs.name

foreach ($jobName in $jobsListName) {
    $jobEndpoint = "$url/job/$jobName/config.xml"
    $exportFile = "$exportPath\$jobName.xml"
    Invoke-RestMethod $jobEndpoint -Headers $headers -OutFile $exportFile
    Write-Host "Export $jobName  =>  $exportFile"
}