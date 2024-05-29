### Install-DeployToolkit

$githubRepository = "psappdeploytoolkit/psappdeploytoolkit"
$filenamePatternMatch = "PSAppDeployToolkit*.zip"
$psadtReleaseUri = "https://api.github.com/repos/$githubRepository/releases/latest"
$psadtDownloadUri = ((Invoke-RestMethod -Method GET -Uri $psadtReleaseUri).assets | Where-Object name -like $filenamePatternMatch ).browser_download_url
$zipExtractionPath = Join-Path $env:USERPROFILE "Downloads" "PSAppDeployToolkit"
$zipTempDownloadPath = Join-Path -Path $([System.IO.Path]::GetTempPath()) -ChildPath $(Split-Path -Path $psadtDownloadUri -Leaf)
## Download to a temporary folder
Invoke-WebRequest -Uri $psadtDownloadUri -Out $zipTempDownloadPath
## Remove any Zone.Identifier alternate data streams to unblock the file (if required)
Unblock-File -Path $zipTempDownloadPath
New-Item -Type Directory $zipExtractionPath
Expand-Archive -Path $zipTempDownloadPath -OutputPath $zipExtractionPath -Force
Write-Host ("File: {0} extracted to Path: {1}" -f $psadtDownloadUri, $zipExtractionPath) -ForegroundColor Yellow
Remove-Item $zipTempDownloadPath

### Copy the template, update the version and download the package

$PSAppDeployToolkit = "$home\Downloads\PSAppDeployToolkit\"
$version = "6.3.3"
$url_winscp = "https://cdn.winscp.net/files/WinSCP-$version.msi?secure=P2HLWGKaMDigpDQw-H9BgA==,1716466173"
$WinSCP_Template = Get-Content "$PSAppDeployToolkit\Examples\WinSCP\Deploy-Application.ps1"
$WinSCP_Template_Latest = $WinSCP_Template -replace "6.3.2","$version"
$WinSCP_Template_Latest > "$PSAppDeployToolkit\Toolkit\Deploy-Application.ps1"
Invoke-RestMethod $url_winscp -OutFile "$PSAppDeployToolkit\Toolkit\Files\WinSCP-$version.msi"

### Install WinSCP

powershell -File "$PSAppDeployToolkit\Toolkit\Deploy-Application.ps1"