function Get-SpeedTest {
    param (
        $Server = 3682,
        [switch]$List
    )
    $path = "$env:TEMP\speedtest.exe"
    $testPath = Test-Path "$env:TEMP\speedtest.exe"
    if ($testPath -eq $false) {
        Invoke-RestMethod https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip -OutFile "$env:TEMP\speedtest.zip"
        Expand-Archive "$env:TEMP\speedtest.zip" -DestinationPath $env:TEMP
    }
    if ($List) {
        $(& $path -L -f json | ConvertFrom-Json).servers
    } else {
        $test = & $path -s $Server -f json
        $Collections = New-Object System.Collections.Generic.List[System.Object]
        $Collections.Add(
            [PSCustomObject]@{
                Date = $($test | ConvertFrom-Json).timestamp
                Url = $($test | ConvertFrom-Json).result.url
                Download = [double]::Round($($($test | ConvertFrom-Json).download.bandwidth / 1mb * 8), 2)
                Upload = [double]::Round($($($test | ConvertFrom-Json).upload.bandwidth / 1mb * 8), 2)
                Ping = $($test | ConvertFrom-Json).ping.latency
                Internal_IP = $($test | ConvertFrom-Json).interface.internalIp
                External_IP = $($test | ConvertFrom-Json).interface.externalIp
                Server = $($test | ConvertFrom-Json).server
            }
        )
        $Collections
    }
}