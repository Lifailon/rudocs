function Invoke-AltTab {
    $(New-Object -ComObject WSCript.Shell).SendKeys("%{Tab}")
    Start-Sleep $(Get-Random -Minimum 30 -Maximum 180)
    Invoke-AltTab
}
Invoke-AltTab