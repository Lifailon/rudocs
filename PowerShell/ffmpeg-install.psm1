$release_latest = Invoke-RestMethod "https://api.github.com/repos/BtbN/FFmpeg-Builds/releases/latest"
$url = $($release_latest.assets | Where-Object name -match "ffmpeg-master-latest-win64-gpl.zip").browser_download_url
Invoke-RestMethod $url -OutFile $home\Downloads\ffmpeg-master-latest-win64-gpl.zip
Expand-Archive -Path "$home\Downloads\ffmpeg-master-latest-win64-gpl.zip" -DestinationPath "$home\Downloads\"
Copy-Item -Path "$home\Downloads\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe" -Destination "C:\Windows\System32\ffmpeg.exe"
Remove-Item "$home\Downloads\ffmpeg-*" -Force -Recurse