Function Get-PortCheck {
    <#
.SYNOPSIS
Module for port check
Using ThreadJob (Install-Module ThreadJob -Repository PSGallery)
Using Class .NET: System.Net.Sockets.TcpClient
Method: BeginConnect
.DESCRIPTION
Example:
Get-PortCheck 192.168.1.10 443
Get-PortCheck 192.168.1.10 22,3389
Get-PortCheck 192.168.1.10 20-70
Get-PortCheck 192.168.1.0 80 # check to network
Get-PortCheck 192.168.1.0 80 100 # fast mode
Get-PortCheck 192.168.1.0 80 100 -open # show only open ports
.LINK
https://github.com/Lifailon/Get-PortCheck
#>
    Param (
        $srv, $port,
        $ms = 500,
        [switch]$open
    )
    if (!$port) {
        Write-Host (Get-Help Get-PortCheck).DESCRIPTION.Text -ForegroundColor Cyan
        return
    }
    if ($srv -match "\.0$") {
        $replace = $srv -replace "0$"
        $srv = 1..254 | foreach { $replace + $_ }
    }
    if ($port -match "-") {
        $port = $port -split "-"
        $start = $port[0]
        $end = $port[1]
        $port = $start..$end
    }
    #$start_time = Get-Date
    foreach ($s in [array]$srv) {
        foreach ($p in [array]$port) {
(Start-ThreadJob {
                $Socket = New-Object System.Net.Sockets.TcpClient
                $Connect = $Socket.BeginConnect($using:s, $using:p, $null, $null)
                sleep -Milliseconds $using:ms
                if ($Socket.Connected -like "True") {
                    Write-Host "$using:s $using:p Opened"
                }
                elseif ($Socket.Connected -like "False") {
                    Write-Host "$using:s $using:p Closed"
                }
                $socket.Close()
            }) | Out-Null
        }
    }
    while ($True) {
        $status = @((Get-Job).State)[-1]
        if ($status -like "Completed") {
            #Get-Job | Receive-Job
            $arr = (Get-Job).Information
            Get-Job | Remove-Job -Force
            break
        }
    }
    $Collections = New-Object System.Collections.Generic.List[System.Object]
    foreach ($a in $arr) {
        $sa = $a -split " "
        $Collections.Add([PSCustomObject]@{
                IP     = $sa[0];
                Port   = $sa[1];
                Status = $sa[2]
            })
    }
    if ($open) {
        $Collections | ? status -match "Opened"
    }
    else {
        $Collections
    }
    #$end_time = Get-Date
    #$run_time = $end_time - $start_time
    #$run_min = $run_time.Minutes
    #$run_sec = $run_time.Seconds
    #Write-Host "Run time: $run_min min $run_sec sec"
}