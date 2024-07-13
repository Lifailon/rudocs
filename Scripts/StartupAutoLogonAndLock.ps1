# Установить автоматический вход в систему (альтернатива: https://learn.microsoft.com/en-us/sysinternals/downloads/autologon)
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $registryPath -Name "AutoAdminLogon" -Value "1"
Set-ItemProperty -Path $registryPath -Name "DefaultUserName" -Value "USERNAME"
Set-ItemProperty -Path $registryPath -Name "DefaultPassword" -Value "PASSWORD"

# Создать задачу в планировщике для блокировки экрана через 1 минуту после входа
$taskName = "StartupLogonLock"
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-Command `"Start-Sleep -Seconds 60; rundll32.exe user32.dll,LockWorkStation`""
$trigger = New-ScheduledTaskTrigger -AtLogon
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -User "SYSTEM" -RunLevel Highest
