# SMART Exporter

Экспортер для получения состояния `S.M.A.R.T.` для всех дисков в ОС Windows из [Crystal Disk Info](https://github.com/hiyohiyo/CrystalDiskInfo).

Пример формата данных для 3-х дисков:

```shell
# HELP disk_temperature Disk temperature in Celsius
# TYPE disk_temperature gauge
disk_temperature{diskName="MSI-M390-250GB511220510128001162"} 43
# HELP disk_power_on_count Count of launch
# TYPE disk_power_on_count counter
disk_power_on_count{diskName="MSI-M390-250GB511220510128001162"} 112
# HELP disk_power_on_hours Count of running in hours
# TYPE disk_power_on_hours counter
disk_power_on_hours{diskName="MSI-M390-250GB511220510128001162"} 20953

# HELP disk_temperature Disk temperature in Celsius
# TYPE disk_temperature gauge
disk_temperature{diskName="ST1000DM003-1CH162Z1DD33DT"} 39
# HELP disk_power_on_count Count of launch
# TYPE disk_power_on_count counter
disk_power_on_count{diskName="ST1000DM003-1CH162Z1DD33DT"} 64
# HELP disk_power_on_hours Count of running in hours
# TYPE disk_power_on_hours counter
disk_power_on_hours{diskName="ST1000DM003-1CH162Z1DD33DT"} 43891

# HELP disk_temperature Disk temperature in Celsius
# TYPE disk_temperature gauge
disk_temperature{diskName="WDC-WD2005FBYZ-01YCBB2WD-WMC6N0L3JK47"} 37
# HELP disk_power_on_count Count of launch
# TYPE disk_power_on_count counter
disk_power_on_count{diskName="WDC-WD2005FBYZ-01YCBB2WD-WMC6N0L3JK47"} 133
# HELP disk_power_on_hours Count of running in hours
# TYPE disk_power_on_hours counter
disk_power_on_hours{diskName="WDC-WD2005FBYZ-01YCBB2WD-WMC6N0L3JK47"} 25263
```