$instance = [System.Net.Dns]::GetHostName()

# $pushgatewayUrl = "http://192.168.3.100:19091/metrics/job/disk_temperature"
# Имя контейнера шлюза при запуске через compose
$pushgatewayUrl = "http://pushgateway:9091/metrics/job/disk_temperature"

# $path = "C:/Program Files/CrystalDiskInfo/Smart"
# Путь при запуске в контейнере Docker через WSL
$path = "/mnt/c/Program Files/CrystalDiskInfo/Smart"

# Необходимо строго использовать синтаксис PowerShell (избегая псевдонимы ls)
$diskArray = $(Get-ChildItem $path).Name

while ($true) {
    $metrics = "# TYPE disk_temperature gauge`n"
    foreach ($diskName in $diskArray) {
        $lastTemp = $(@("Date,Value")+$(Get-Content "$path/$diskName/Temperature.csv") | ConvertFrom-Csv)[-1].Value
        $diskLabel = $diskName -replace "[^a-zA-Z0-9]", "_"
        $metrics += "disk_temperature{disk=`"$diskLabel`",instance=`"$instance`"} $lastTemp`n"
    }
    $metrics
    Invoke-RestMethod -Uri $pushgatewayUrl -Method POST -Body $metrics
    Start-Sleep 10
}