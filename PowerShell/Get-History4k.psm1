function Get-History4k {
    param (
        $Count = 100
    )
    $path = $(Get-PSReadLineOption).HistorySavePath
    $CountAll = $(Get-Content $path).Length
    $CountStart = $CountAll - $Count
    $(Get-Content $path)[$CountStart..$CountAll]
}

# Читаем историю команд из файла, в который пишет модуль PSReadLine (вывод последних команд)
# Get-History4k 200