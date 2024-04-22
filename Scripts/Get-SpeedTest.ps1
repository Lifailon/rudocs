$path = "$home\Downloads\speedtest.exe"
# & $path -L
$test = & $path -s 3682 -f json
$Collections = New-Object System.Collections.Generic.List[System.Object]
$Collections.Add(
    [PSCustomObject]@{
        Download = [double]::Round($($($test | ConvertFrom-Json).download.bandwidth / 1mb * 8), 2)
        Upload = [double]::Round($($($test | ConvertFrom-Json).upload.bandwidth / 1mb * 8), 2)
    }
)
$Collections