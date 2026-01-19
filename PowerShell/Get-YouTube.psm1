# Install yt-dlp latest from GitGub:
# $release_latest = Invoke-RestMethod "https://api.github.com/repos/yt-dlp/yt-dlp/releases/latest"
# $url = $($release_latest.assets | Where-Object name -match "yt-dlp.exe").browser_download_url
# Invoke-RestMethod $url -OutFile "C:\Windows\System32\yt-dlp.exe"

function Get-YouTube {
    param (
        $url
    )
    $result = yt-dlp -J $url
    $($result | ConvertFrom-Json).formats | 
    Where-Object filesize -ne $null | 
    Select-Object format_id,
    @{Name="FileSize"; 
        Expression={[string]([int]($_.filesize / 1024kb)).ToString("0.0")+" Mb"}
    },
    resolution,format_note,quality,fps,ext,language
}