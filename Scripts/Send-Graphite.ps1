$graphiteAddress = "192.168.3.101"
$graphitePort = 2003

while ($true) {
    $timestamp = [int][double]::Parse((Get-Date -UFormat %s))
    $metric = $(Get-CimInstance -Class Win32_PerfFormattedData_PerfOS_Processor | Where-Object name -eq "_Total").PercentProcessorTime
    $data = "server.$($env:COMPUTERNAME).cpu $metric $timestamp"
    try {
        $client = New-Object System.Net.Sockets.TcpClient($graphiteAddress, $graphitePort)
        $stream = $client.GetStream()
        $bytes = [System.Text.Encoding]::ASCII.GetBytes($data + "`n")
        $stream.Write($bytes, 0, $bytes.Length)
    }
    catch {
        Write-Host $($_.Exception.Message) -ForegroundColor Red
    }
    finally {
        $client.Close()
    }
    Start-Sleep -Seconds 5
}