function Start-PingInvokeParallel ($Network) {
    # Прочитать и импортировать функцию из репозитория GitHub
    $module = "https://raw.githubusercontent.com/RamblingCookieMonster/Invoke-Parallel/master/Invoke-Parallel/Invoke-Parallel.ps1"
    Invoke-Expression $(Invoke-RestMethod $module)
    $RNetwork = $Network -replace "\.\d{1,3}$","."
    1..254 | ForEach-Object {$srvList += @($RNetwork+$_)}
    Invoke-Parallel -InputObject $srvList -ScriptBlock {
        "$_ : " + $(ping -n 1 -w 50 $_)[2]
    }
}

# Start-PingInvokeParallel -Network 192.168.3.0
# $(Get-History)[-1].Duration.TotalSeconds