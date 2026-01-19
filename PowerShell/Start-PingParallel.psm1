function Start-PingParallel ($Network) {
    $RNetwork = $Network -replace "\.\d{1,3}$","."
    1..254 | ForEach-Object -Parallel {
        "$using:RNetwork.$_ : " + $(ping -n 1 -w 50 "$using:RNetwork$_")[2]
    } -ThrottleLimit 254
}

# Start-PingParallel -Network 192.168.3.0
# $(Get-History)[-1].Duration.TotalSeconds