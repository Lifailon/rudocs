# Install-Module -Name PoshRSJob

function Start-PingRSJob ($Network) {
    $RNetwork = $Network -replace "\.\d{1,3}$","."
    foreach ($4 in 1..254) {
        $ip = $RNetwork+$4
        $(Start-RSJob {
            "$using:ip : " + $(ping -n 1 -w 50 $using:ip)[2]
        }) | Out-Null
    }
    while ($True) {
        $status_job = $(Get-RSJob).State -notcontains "Running" # проверяем, что массив не содержит активных заданий
        if ($status_job) {
            $ping_out = Get-RSJob | Receive-RSJob
            Get-RSJob | Remove-RSJob
            break
        }
    }
    $ping_out
}

# Start-PingRSJob -Network 192.168.3.0
# $(Measure-Command {Start-PingRSJob -Network 192.168.3.0}).TotalSeconds