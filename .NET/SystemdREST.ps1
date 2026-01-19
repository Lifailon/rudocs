#!/snap/bin/pwsh
# © 2023 Lifailon (https://github.com/Lifailon)
<# Client
# Login and password default:
$user = "rest"
$pass = "api"
# Example 1:
$SecureString = ConvertTo-SecureString $pass -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($user, $SecureString)
#$Credential = Get-Credential
Invoke-RestMethod -Credential $Credential -AllowUnencryptedAuthentication -Uri http://192.168.3.104:8080/api/service/cron
# Example 2:
$EncodingCred = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("${user}:${pass}"))
$Headers = @{"Authorization" = "Basic ${EncodingCred}"}
Invoke-RestMethod -Headers $Headers -Uri http://192.168.3.104:8080/api/service/cron
# GET Request:
Invoke-RestMethod -Credential $Credential -AllowUnencryptedAuthentication -Uri http://192.168.3.104:8080/api/service/cron
Invoke-RestMethod -Credential $Credential -AllowUnencryptedAuthentication -Uri http://192.168.3.104:8080/api/service
Invoke-RestMethod -Credential $Credential -AllowUnencryptedAuthentication -Uri http://192.168.3.104:8080/api/service-status
# POST Request:
Invoke-RestMethod -Credential $Credential -AllowUnencryptedAuthentication -Uri http://192.168.3.104:8080/api/service/cron -Method Post -Headers @{"Status" = "Stop"}
Invoke-RestMethod -Credential $Credential -AllowUnencryptedAuthentication -Uri http://192.168.3.104:8080/api/service/cron -Method Post -Headers @{"Status" = "Start"}
Invoke-RestMethod -Credential $Credential -AllowUnencryptedAuthentication -Uri http://192.168.3.104:8080/api/service/cron -Method Post -Headers @{"Status" = "Restart"}
# Other endpoints:
Invoke-RestMethod -Credential $Credential -AllowUnencryptedAuthentication -Uri http://192.168.3.104:8080/process
Invoke-RestMethod -Credential $Credential -AllowUnencryptedAuthentication -Uri http://192.168.3.104:8080/api/process
Invoke-RestMethod -Credential $Credential -AllowUnencryptedAuthentication -Uri http://192.168.3.104:8080/api/uptime
Invoke-RestMethod -Credential $Credential -AllowUnencryptedAuthentication -Uri http://192.168.3.104:8080/api/disk
#>

### Variables
$ip   = "192.168.3.104"
$port = "8080"
$path = "/var/log/systemctl-api.log"
$cred = "cmVzdDphcGk="

function Get-Log {
    # Debug (Get all Request and Response param):
    # $context.Request | Out-Default
    # $context.Request.Headers | Out-Default
    # $context.Response | Out-Default
    # Output log to console
    Write-Host "$($context.Request.RemoteEndPoint) ($($context.Request.UserAgent))" -f Blue -NoNewline
    Write-Host " => " -NoNewline
    Write-Host "$($context.Request.HttpMethod) $($context.Request.RawUrl)" -f Green -NoNewline
    Write-Host " => " -NoNewline
    Write-Host "$($context.Response.StatusCode)" -f Green
    # Output log to file
    $date = Get-Date -Format "dd.MM.yyyy hh:mm"
    "$date $($context.Request.RemoteEndPoint) ($($context.Request.UserAgent)) => $(
    $context.Request.HttpMethod) $($context.Request.RawUrl) => $($context.Response.StatusCode)" >> $path
}

function Send-Response {
    param (
        $Data,
        $Code
    )
    $context.Response.StatusCode = $Code
    Get-Log
    $buffer = [System.Text.Encoding]::UTF8.GetBytes($Data)
    $context.Response.ContentLength64 = $buffer.Length
    $context.Response.OutputStream.Write($buffer, 0, $buffer.Length)
    $context.Response.OutputStream.Close()
}

function Get-ServiceJson {
    param (
        $ServiceName
    )
    systemctl status $ServiceName 2>&1 | grep -E "not be found|Loaded:|Active:|Tasks:|Memory" | awk '{
        sum=""; for(i=1;i<=NF;i++) { if (i != 1) {sum=sum" "$i}
    } print "\042"$1"\042" " : \042"sum"\042,"}' | sed '1s/^/{/; $s/$/}/; s/://; s/"\s/"/2'
}

function Get-Proc {
    Get-Process | Sort-Object -Descending CPU | Select-Object ProcessName,
    @{Name="TotalProcTime"; Expression={$_.TotalProcessorTime -replace "\.\d+$"}},
    @{Name="UserProcTime"; Expression={$_.UserProcessorTime -replace "\.\d+$"}},
    @{Name="PrivilegedProcTime"; Expression={$_.PrivilegedProcessorTime -replace "\.\d+$"}},
    @{Name="WorkingSet"; Expression={[string]([int]($_.WS / 1024kb))+"MB"}},
    @{Name="PeakWorkingSet"; Expression={[string]([int]($_.PeakWorkingSet / 1024kb))+"MB"}},
    @{Name="PageMemory"; Expression={[string]([int]($_.PM / 1024kb))+"MB"}},
    @{Name="VirtualMemory"; Expression={[string]([int]($_.VM / 1024kb))+"MB"}},
    @{Name="PrivateMemory"; Expression={[string]([int]($_.PrivateMemorySize / 1024kb))+"MB"}},
    @{Name="RunTime"; Expression={((Get-Date) - $_.StartTime) -replace "\.\d+$"}},
    @{Name="Threads"; Expression={$_.Threads.Count}},
    Handles, Path
}

### Creat and start socket
Add-Type -AssemblyName System.Net.Http
$http = New-Object System.Net.HttpListener
$http.AuthenticationSchemes = [System.Net.AuthenticationSchemes]::Basic # Use Basic Authentication
$addr = $ip+":"+$port
$http.Prefixes.Add("http://$addr/")
$http.Start()
Write-Host Running on $http.Prefixes
try {
while ($http.IsListening) {
$contextTask = $http.GetContextAsync()
while (-not $contextTask.AsyncWaitHandle.WaitOne(200)) { }
$context = $contextTask.GetAwaiter().GetResult()

### Authorization
$CredRequest = $context.Request.Headers["Authorization"]
# Debug (Get Encoding Credential)
# Write-Host $CredRequest
$CredRequest = $CredRequest -replace "Basic\s"
if ( $CredRequest -ne $cred ) {
    $Data = "Unauthorized (login or password is invalid)"
    Send-Response -Data $Data -Code 401
}
else
{
### GET /api/service
if ($context.Request.HttpMethod -eq "GET" -and $context.Request.RawUrl -eq "/api/service") {
    # Get all service unit files (only name and startup) and convert to JSON
    $GetService = systemctl list-unit-files --type=service --all | sed "1d;$ d" | sed "$ d" | grep -v "@.service" | awk '{
        print "{\042Name\042:\042" $1 "\042,\042Startup\042:\042" $2 "\042},"
    }' | sed '1s/^/[/; $s/$/]/'
    Send-Response -Data $GetService -Code 200
}

### GET /api/service-status
elseif ($context.Request.HttpMethod -eq "GET" -and $context.Request.RawUrl -eq "/api/service-status") {
    # Get all service unit files
    $ServiceList = systemctl list-unit-files --type=service --all | sed "1d;$ d" | sed "$ d" | grep -v "@.service" | awk '{print $1,$2}'
    # Get status unit
    $Collections = New-Object System.Collections.Generic.List[System.Object]
    foreach ($sl in $ServiceList) {
        $ServiceSplit = $sl -split "\s"
        $Collections.Add([PSCustomObject]@{
            Name = $ServiceSplit[0];
            State = systemctl status $ServiceSplit[0] | grep Active: | sed -r "s/^.+: //; s/\s\(.+//; s/\).+//"
            StartType = $ServiceSplit[1]
        })
    }
    # Convert to JSON
    $GetService = $Collections | ConvertTo-Json
    Send-Response -Data $GetService -Code 200
}

### GET /api/service/*ServiceName*
elseif ($context.Request.HttpMethod -eq "GET" -and $context.Request.RawUrl -match "/api/service/.") {
    # Get service name from endpoint
    $ServiceName = ($context.Request.RawUrl) -replace ".+/"
    # Get status service and convert to JSON
    $GetService = Get-ServiceJson -ServiceName $ServiceName
    if ($GetService -match "could not be found") {
        $GetService = "Bad Request (service $ServiceName could not be found)"
        $Code = 400
    }
    else {
        $Code = 200
    }
    Send-Response -Data $GetService -Code $Code
}

### POST /api/service/*ServiceName*
elseif ($context.Request.HttpMethod -eq "POST" -and $context.Request.RawUrl -match "/api/service/.") {
    $ServiceName = ($context.Request.RawUrl) -replace ".+/"
    # Get Status from Headers Request (stop/start/restart)
    $Status = $context.Request.Headers["Status"]
    # Check Service
    $GetService = systemctl status $ServiceName 2>&1
    if ($GetService -match "could not be found") {
        $GetService = "Bad Request (service $ServiceName could not be found)"
        $Code = 400
    }
    else {
        $Code = 200
        if ($status -eq "stop") {
            systemctl stop $ServiceName
            $GetService = Get-ServiceJson -ServiceName $ServiceName
        }
        elseif ($status -eq "start") {
            systemctl start $ServiceName
            $GetService = Get-ServiceJson -ServiceName $ServiceName
        }
        elseif ($status -eq "restart") {
            systemctl restart $ServiceName
            $GetService = Get-ServiceJson -ServiceName $ServiceName
        }
        else {
            $GetService = "Bad Request (incorrect status in the header, available: stop, start, restart)"
            $Code = 400
        }
    }
    Send-Response -Data $GetService -Code $Code
}

### GET /process (html)
elseif ($context.Request.HttpMethod -eq "GET" -and $context.Request.RawUrl -eq "/process") {
    $GetProcess = Get-Proc | ConvertTo-Html
    Send-Response -Data $GetProcess -Code 200
}

### GET /api/process (json)
elseif ($context.Request.HttpMethod -eq "GET" -and $context.Request.RawUrl -eq "/api/process") {
    $GetProcess = Get-Proc | ConvertTo-Json
    Send-Response -Data $GetProcess -Code 200
}

### GET /api/uptime
elseif ($context.Request.HttpMethod -eq "GET" -and $context.Request.RawUrl -eq "/api/uptime") {
    #Send-Response $(Get-Uptime | ConvertTo-Json)
    $uptime = uptime | cut -d "," -f 1 | sed -r "s/^\s+//"
    $users  = $(uptime | cut -d "," -f 3) -replace "\D"
    $avg    = uptime | cut -d "," -f 4-6 | sed -r "s/^.+: //;s/,//g"
    $data   = " {""Uptime"":""$uptime"", ""Users"": ""$users"", ""avg"":""$avg""} "
    Send-Response $data -Code 200
}

### GET /api/disk
elseif ($context.Request.HttpMethod -eq "GET" -and $context.Request.RawUrl -eq "/api/disk") {
    Send-Response $(lsblk -e7 --json) -Code 200
}

### Response to other methods
elseif ($context.Request.HttpMethod -ne "GET") {
    $Data = "Method Not Allowed"
    Send-Response -Data $Data -Code 405
}

### Response to the lack of endpoints
else {
    $Data = "Not Found endpoint"
    Send-Response -Data $Data -Code 404
}
}
}
}
finally {
    $http.Stop()
}