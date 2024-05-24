function Start-TestConnectParallel (
        $Network,
        [switch]$Csv
    ) {
    $RNetwork = $Network -replace "\.\d{1,3}$","."
    if ($csv) {
        "Address,Status,Latency"
    }
    1..254 | ForEach-Object -Parallel {
        $test = Test-Connection "$using:RNetwork$_" -Count 1 -TimeoutSeconds 1
        if ($using:csv) {
            "$($using:RNetwork)$_,$($test.Status),$($test.Latency)"
        } else {
            $test
        }
    } -ThrottleLimit 254
}

# Start-TestConnectParallel -Network 192.168.3.0 -Csv | ConvertFrom-Csv
# $(Get-History)[-1].Duration.TotalSeconds # 3 seconds