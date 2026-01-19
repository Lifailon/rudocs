# (c) NirSoft
# Загрузить: https://www.nirsoft.net/utils/disk_smart_view.html
# Поместить русификатор рядом (DiskSmartView_lng.ini) с исполняемым файлов

function Get-DiskSmartView {
    param (
        $path = "$home\Documents\DiskSmartView"
    )
    . "$path/DiskSmartView.exe" /scomma "$path/report.csv"
    $csv = "Описание,Текущее,Нормальное,Худшее,Порог,Статус
    "
    $encoding = [System.Text.Encoding]::GetEncoding(1251)
    $csv += [System.IO.File]::ReadAllText("$path\report.csv", $encoding)
    $csv | ConvertFrom-Csv -Delimiter ","
}