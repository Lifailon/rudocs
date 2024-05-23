# Install-Module -Name ThreadJob

function Start-PingThreadJob ($Network) {
    $RNetwork = $Network -replace "\.\d{1,3}$","."
    foreach ($4 in 1..254) {
        $ip = $RNetwork+$4
        $(Start-ThreadJob {
            "$using:ip : " + $(ping -n 1 -w 50 $using:ip)[2]
        }) | Out-Null
    }
    while ($True) {
        $status_job = $(Get-Job).State[-1]
        if ($status_job -like "Completed") {
            $ping_out = Get-Job | Receive-Job
            Get-Job | Remove-Job -Force
            break
        }
    }
    $ping_out
}

# Start-PingThreadJob -Network 192.168.3.0
# $(Measure-Command {Start-PingThread -Network 192.168.3.0}).TotalSeconds