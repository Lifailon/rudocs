# Скрипт отправки системных  оповещений из PingInfoView (https://www.nirsoft.net/utils/multiple_ping_tool.html)
# Добавить команду при сбое и удачных пингах в дополнительных настройках (F9):
# powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Users\Lifailon\Documents\PingInfoView-3.20\Send-PingNotify.ps1" "%HostName%" "%IPAddress%" "%LastPingStatus%" "%SucceedCount%" "%FailedCount%" "%LastSucceedOn%" "%LastFailedOn%"

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$HostName = $args[0]
$IPAddress = $args[1]
$LastPingStatus = $args[2]
$SucceedCount = $args[3]
$FailedCount = $args[4]
$LastSucceedOn = $args[5]
$LastFailedOn = $args[6]

$iconPath = "C:\Users\Lifailon\Documents\PingInfoView-3.20\PingInfoView.exe"

$NotifyIcon = New-Object System.Windows.Forms.NotifyIcon
$NotifyIcon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($iconPath)
$NotifyIcon.Visible = $true

if ($IPAddress.Length -ne 0 -and $HostName.Length -ne 0) {
    $HostName = "$HostName ($IPAddress)"
}

if ($HostName.Length -eq 0) {
    $HostName = $IPAddress
}

if ($LastPingStatus.Length -eq 6) {
    $NotifyIcon.BalloonTipTitle = "Succeed on $HostName"
} else {
    $NotifyIcon.BalloonTipTitle = "Failed on $HostName"
}

$NotifyIcon.BalloonTipText = "Last succeed: $LastSucceedOn"
$NotifyIcon.BalloonTipText += "`nLast failed: $LastFailedOn"
$NotifyIcon.BalloonTipText += "`nSucceed count: $SucceedCount"
$NotifyIcon.BalloonTipText += "`nFailed count: $FailedCount"

$NotifyIcon.ShowBalloonTip(5000)
Start-Sleep -Seconds 5
$NotifyIcon.Dispose()