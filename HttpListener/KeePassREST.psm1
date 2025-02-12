function Read-KeePass {
	<#
    .SYNOPSIS
    Function for reading the KeePass base via Windows PowerShell (PowerShell Core not supported)
    .DESCRIPTION
    Examples:
		$data = Read-KeePass -basePath C:\Users\Lifailon\Downloads\Lifailon.kdbx -basePass 12345
		$($($data | Where-Object {$_.Group -eq "Network"}).Entries | Where-Object {$_.Title -match "hikvision"})[0] | Select-Object Login,Password
    .LINK
    https://github.com/Lifailon/PS-Commands
    #>
	param (
		[Parameter(Mandatory)][string]$basePath,
		[Parameter(Mandatory)][string]$basePass,
		[string]$KeePassExecPath = "C:\Program Files\KeePass Password Safe 2\KeePass.exe",
		[switch]$Json
	)
	# Load Assembly from KeePass.exe
	[System.Reflection.Assembly]::LoadFrom($KeePassExecPath) | Out-Null
	[KeePass.Program]::CommonInitialize()
	# Open base kdbx format
	$IOConnectionInfo = [KeePassLib.Serialization.IOConnectionInfo]::FromPath($basePath)
	$CompositeKey = New-Object KeePassLib.Keys.CompositeKey
	$KcpPassword = New-Object KeePassLib.Keys.KcpPassword @($basePass)
	$CompositeKey.AddUserKey($KcpPassword)
	$PwDatabase = New-Object KeePassLib.PwDatabase
	$PwDatabase.Open($IOConnectionInfo, $CompositeKey, $null)
	try {
		$Groups = $PwDatabase.RootGroup.Groups
		$groupCollections = New-Object System.Collections.Generic.List[System.Object]
		foreach ($Group in $Groups) {
			$entryCollections = New-Object System.Collections.Generic.List[System.Object]
			foreach ($entry in $Group.Entries) {
				$entryCollections.Add([PSCustomObject]@{
					Title       = $entry.Strings.Get("Title").ReadString()
					Login       = $entry.Strings.Get("UserName").ReadString()
					Password    = $entry.Strings.Get("Password").ReadString()
					Url         = $entry.Strings.Get("URL").ReadString()
					Description = $entry.Strings.Get("Notes").ReadString()
				})
			}
			$groupCollections += [PSCustomObject]@{
				# ($Group.Name) = $entryCollections
				Group        = $Group.Name
				Modification = $Group.LastAccessTime.ToString()
				Entries      = $entryCollections
			}
		}
		if ($Json) {
			$groupCollections | ConvertTo-Json -Depth 3
		}
		else {
			$groupCollections
		}
	}
 finally {
		$PwDatabase.Close()
	}
}

function Start-KeePass {
	<#
    .SYNOPSIS
    Function for starting REST API server
    .DESCRIPTION
	Examples:
		Server:
			Start-KeePass -basePath C:\Users\Lifailon\Downloads\Lifailon.kdbx -basePass 12345 -Address 127.0.0.1 -Port 3001 -User kee -Pass pass
		Client:
			$EncodingCred = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("kee:pass"))
			$Headers = @{"Authorization" = "Basic ${EncodingCred}"}
			Invoke-RestMethod -Headers $Headers -Uri http://localhost:3001/api/all
			Invoke-RestMethod -Headers $Headers -Uri http://localhost:3001/api/groups
		Filter:
			curl -sS -X GET -u kee:pass http://localhost:3001/api/group/git
			curl -sS -X GET -u kee:pass http://localhost:3001/api/entries/github
			curl -sS -X GET -u kee:pass http://localhost:3001/api/entries/github+api | jq -r .Password
    .LINK
    https://github.com/Lifailon/PS-Commands
    #>
	param (
		[Parameter(Mandatory)][string]$basePath,
		[Parameter(Mandatory)][string]$basePass,
		[string]$KeePassExecPath = "C:\Program Files\KeePass Password Safe 2\KeePass.exe",
		[string]$Address = "localhost",
		[int]$Port = "3000",
		[string]$User = "kee",
		[string]$Pass = "pass"
	)
	$cred = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("${user}:${pass}"))
	$http = [System.Net.HttpListener]::new()
	$http.Prefixes.Add("http://${Address}:${Port}/")
	$http.AuthenticationSchemes = [System.Net.AuthenticationSchemes]::Basic
	$http.Start()
	if ($http.IsListening) {
		Write-Host "Web Server Running: " -NoNewline
		Write-Host "$($http.Prefixes)" -ForegroundColor Green
	}
	try {
		function Write-Log {
			Write-Host "$($(Get-Date).ToString()) " -NoNewline -ForegroundColor Blue
			Write-Host "$($context.Request.HttpMethod) " -NoNewline -ForegroundColor Yellow
			Write-Host "$($context.Request.RemoteEndPoint) " -NoNewline -ForegroundColor Green
			Write-Host "($($context.Request.UserAgent))" -NoNewline -ForegroundColor Yellow
			Write-Host " => " -NoNewline
			Write-Host "$($context.Request.RawUrl)" -ForegroundColor Green
		}
		function Send-Response (
				$Data,
				[int]$Code
			) {
			try {
				Write-Log
				if ($Code -ne 200) {
					Write-Host "$($(Get-Date).ToString()) " -NoNewline -ForegroundColor Blue
					Write-Host "${Code} " -NoNewline -ForegroundColor Red
					Write-Host "$Data"
				}
				$context.Response.StatusCode = $Code
				$buffer = [System.Text.Encoding]::UTF8.GetBytes($Data)
				$context.Response.ContentLength64 = $buffer.Length
				$context.Response.OutputStream.Write($buffer, 0, $buffer.Length)
				$context.Response.OutputStream.Flush()
				$context.Response.OutputStream.Close()
			} catch {
				return
			}
		}
		while ($http.IsListening) {
            $contextTask = $http.GetContextAsync()
            while (-not $contextTask.AsyncWaitHandle.WaitOne(200)) { }
            $context = $contextTask.GetAwaiter().GetResult()
            $CredRequest = $context.Request.Headers["Authorization"]
            $CredRequest = $CredRequest -replace "Basic\s"
            if ( $CredRequest -ne $cred ) {
                $Data = "Unauthorized (login or password is invalid)"
                Send-Response -Data $Data -Code 401
            }
            elseif ($context.Request.HttpMethod -ne "GET") {
                $Data = "Method not allowed"
                Send-Response -Data $Data -Code 405
            }
			### /api/all
			elseif ($context.Request.HttpMethod -eq 'GET' -and $context.Request.RawUrl -eq '/api/all') {
				$Data = Read-KeePass -basePath $basePath -basePass $basePass -Json
				Send-Response -Data $data -Code 200
			}
			### /api/groups
			elseif ($context.Request.HttpMethod -eq 'GET' -and $context.Request.RawUrl -eq '/api/groups') {
				$Data = $(Read-KeePass -basePath $basePath -basePass $basePass).Group | ConvertTo-Json
				Send-Response -Data $data -Code 200
			}
			### /api/group/*name*
			elseif ($context.Request.HttpMethod -eq 'GET' -and $context.Request.RawUrl -match '/api/group/') {
				$GroupName = ($context.Request.RawUrl) -replace ".+/" -replace "\+"," "
				if ($GroupName) {
					$KeePassData = Read-KeePass -basePath $basePath -basePass $basePass
					$Data = $KeePassData | Where-Object {$_.Group -match $GroupName}
				}
				if ($Data) {
					Send-Response -Data $($data[0] | ConvertTo-Json -Depth 3) -Code 200
				} else {
					$Data = "Not found groups"
					Send-Response -Data $Data -Code 404
				}
			}
			### /api/entries/*name*
			elseif ($context.Request.HttpMethod -eq 'GET' -and $context.Request.RawUrl -match '/api/entries/') {
				$EntriesName = ($context.Request.RawUrl) -replace ".+/" -replace "\+"," "
				if ($EntriesName) {
					$KeePassData = Read-KeePass -basePath $basePath -basePass $basePass
					$Data = $KeePassData.Entries | Where-Object Title -match $EntriesName
				}
				if ($Data) {
					Send-Response -Data $($data | ConvertTo-Json -Depth 3) -Code 200
				} else {
					$Data = "Not found entries"
					Send-Response -Data $Data -Code 404
				}
			}
            else {
                $Data = "Not found endpoint"
                Send-Response -Data $Data -Code 404
            }
		}
	}
	catch {
		return $Error
	}
	finally {
		$http.Stop()
	}
}