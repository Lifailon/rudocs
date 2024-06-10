$release_latest = Invoke-RestMethod "https://api.github.com/repos/jgm/pandoc/releases/latest"
$url = $($release_latest.assets | Where-Object name -match "windows-x86_64.zip").browser_download_url
Invoke-RestMethod $url -OutFile $home\Downloads\pandoc.zip
Expand-Archive -Path "$home\Downloads\pandoc.zip" -DestinationPath "$home\Downloads\"
$path = $(Get-ChildItem "$home\Downloads\pandoc-*\*.exe").FullName
Copy-Item -Path $path -Destination "C:\Windows\System32\pandoc.exe"
Remove-Item "$home\Downloads\pandoc*" -Force -Recurse