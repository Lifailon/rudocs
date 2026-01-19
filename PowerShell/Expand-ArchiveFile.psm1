function Expand-ArchiveFile {
    param (
        # Путь к архиву
        $Path,
        # Путь, куда извлечь файл
        $DestinationPath,
        # Имя файла, который нужно извлечь
        $FileName
    )
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    try {
        # Открыть архив для чтения
        $zipArchive = [System.IO.Compression.ZipFile]::OpenRead($Path)
        # Найти файл в архиве
        $fileEntry = $zipArchive.Entries | Where-Object { $_.FullName -eq $fileName }
        if ($fileEntry) {
            # Создание потока для чтения содержимого файла
            $stream = $fileEntry.Open()
            # Создание файла и запись в него данных из потока
            $DestinationPathFileName = "$DestinationPath\$FileName"
            $fileStream = [System.IO.File]::Create($DestinationPathFileName)
            $stream.CopyTo($fileStream)
            # Закрытие потоков
            $stream.Close()
            $fileStream.Close()
        } else {
            Write-Output "Файл $fileName не найден в архиве"
        }
    } catch {
        Write-Error "Ошибка при извлечении файла из архива"
    } finally {
        # Закрыть архив
        $zipArchive.Dispose()
    }
}