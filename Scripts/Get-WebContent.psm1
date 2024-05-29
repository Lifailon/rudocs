function Get-WebContent {
    <#
.SYNOPSIS
Module for check http/https content and SSL Certificate
Using Invoke-WebRequest (iwr/wget) and Class .NET: System.Net.ServicePointManager
.DESCRIPTION
Example:
Get-WebContent https://ya.ru sign
.LINK
https://github.com/Lifailon/Get-WebContent
#>
    Param (
        $srv,
        $select = "sign"
    )
    if (!$srv) {
        Write-Host (Get-Help Get-WebContent).DESCRIPTION.Text -ForegroundColor Cyan
        return
    }
    $iwr = iwr $srv
    $status_code = $iwr.StatusCode
    $status = $iwr.BaseResponse.StatusCode
    $info = $iwr.BaseResponse.Server
    $Content = $iwr.Content -split "\s"
    if (($Content | Select-String $select).Count -ne 0) {
        $Status_content = "Available"
    }
    elseif (($Content | Select-String $select).Count -eq 0) {
        $Status_content = "Not available"
    }
    $spm = [System.Net.ServicePointManager]::FindServicePoint("$srv")
    $date_end = $spm.Certificate.GetExpirationDateString()
    $cert_name = ($spm.Certificate.Subject) -replace "CN="
    $cert_owner = ((($spm.Certificate.Issuer) -split ", ") | where { $_ -match "O=" }) -replace "O="

    $Collections = New-Object System.Collections.Generic.List[System.Object]
    $Collections.Add([PSCustomObject]@{
            Host          = $srv;
            Server        = $info;
            Status        = $status;
            StatusCode    = $status_code;
            Content       = $select;
            ContentStatus = $Status_content;
            Certificate   = $cert_name;
            Issued        = $cert_owner;
            End           = $date_end
        })
    $Collections
}