function Veeam-Rep-Stat {
    <#
.SYNOPSIS
Veaam Repository Statisctics
Checking availabled host, path, and space size view
Default param use module Veeam.Backup.PowerShell
.DESCRIPTION
Example:
Veeam-Rep-Stat
Veeam-Rep-Stat -UseList
Veeam-Rep-Stat -UseList -Path ".\Veeam-Rep-List.txt"
Veeam-Rep-Stat -SizeRepository
Veeam-Rep-Stat -SizeDirectory
.LINK
https://github.com/Lifailon/Veeam-Rep-Stat
#>
    Param (
        [switch]$UseList,
        [string]$Path = ".\Veeam-Rep-List.txt",
        [switch]$SizeDirectory,
        [switch]$SizeRepository
    )

    if ($UseList) {
        $PathList = Get-Content $Path

        $Collection = New-Object System.Collections.Generic.List[System.Object]
        foreach ($List in $PathList) {
            $HostName = $List -replace "^\\\\"
            $HostName = $HostName -replace "\\.+"
            $ping_out = (ping -n 1 -4 $HostName)[2]
            if ($ping_out -match "TTL") {
                $Status = $True
            }
            else {
                $Status = $False
            }
            $TestPath = Test-Path $List
            $Collection.Add([PSCustomObject]@{
                    HostName  = $HostName;
                    Available = $Status;
                    Path      = $List;
                    TestPath  = $TestPath
                })
        }
    }
    else {
        $GetList = Get-VBRBackupRepository

        $ListWin += @()
        foreach ($List in $GetList) {
            if ($List.Type -eq "WinLocal") {
                $ListWin += $List
            }
        }

        $Collection = New-Object System.Collections.Generic.List[System.Object]
        foreach ($List in $ListWin) {
            $HostName = $List.Host.Name
            $ping_out = (ping -n 1 -4 $HostName)[2]
            if ($ping_out -match "TTL") {
                $Status = $True
            }
            else {
                $Status = $False
            }
            $Volume = ($List.FullPath.Root) -replace ":"
            $Elements = $List.FullPath.Elements # if ($Elements -ge 2) {?}
            $NetPath = "\\" + $HostName + "\" + $Volume + "$\" + $Elements
            $TestPath = Test-Path $NetPath
            $Collection.Add([PSCustomObject]@{
                    HostName  = $HostName;
                    Available = $Status;
                    Path      = $NetPath;
                    TestPath  = $TestPath
                })
        }
    }

    if ($SizeDirectory) {
        $Collection_Available = $Collection | where TestPath -eq $True
        $Collection_ls = New-Object System.Collections.Generic.List[System.Object]
        foreach ($Coll in $Collection_Available) {
            $ls = ls $Coll.Path
            foreach ($l in $ls) {
                $gci = gci $l.FullName -Recurse -Force | Measure-Object -Property Length -Sum

                $Collection_ls.Add([PSCustomObject]@{
                        HostName  = $Coll.HostName;
                        Directory = $l.Name
                        SizeDir   = [string]([int](($gci.Sum) / 1024mb)) + " GB"
                    })
            }
        }
        $Collection_ls

    }
    elseif ($SizeRepository) {
        $Collection_Space = New-Object System.Collections.Generic.List[System.Object]
        foreach ($Coll in $Collection) {
            if ($Coll.TestPath -eq $true) {
                $RVolume = (($Coll.Path -replace "\$.+").ToCharArray())[-1] # delete all after $ and take last value (type Char) before $ for filter WMI
                $gwmi = gwmi Win32_logicalDisk -ComputerName $Coll.HostName | where DeviceID -Match $RVolume | select @{
                    Label = "Value"; Expression = { $_.DeviceID }
                }, @{Label = "AllSize"; Expression = {
                        [string]([int]($_.Size / 1Gb)) + " GB" }
                }, @{Label = "FreeSize"; Expression = {
                        [string]([int]($_.FreeSpace / 1Gb)) + " GB" }
                }, @{Label = "FreeProc"; Expression = {
                        [string]([int]($_.FreeSpace / $_.Size * 100)) + " %" }
                }
            }
            $Collection_Space.Add([PSCustomObject]@{
                    HostName  = $Coll.HostName;
                    Available = $Coll.Available;
                    Path      = $Coll.Path;
                    TestPath  = $Coll.TestPath;
                    AllSize   = $gwmi.AllSize;
                    FreeSize  = $gwmi.FreeSize;
                    FreeProc  = $gwmi.FreeProc
                })
        }
        $Collection_Space
    }
    else {
        $Collection
    }
}