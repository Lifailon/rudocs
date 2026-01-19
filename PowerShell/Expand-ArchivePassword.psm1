function Expand-ArchivePassword {
    param (
        $Path,
        $Password
    )
    $winrar =  "C:\Program Files\WinRAR\WinRAR.exe"
    & $winrar x -p"$Password" $Path
}

# cd "$home\Downloads"
# Expand-ArchivePassword archive.rar qwe123