function Get-Invent {
    <#
.SYNOPSIS
Remote and local hardware inventory via WMI
.DESCRIPTION
Example:
Get-Invent server-01
Get-Invent localhost # default localhost
Get-Invent -Full server-01 # full report
Get-Invent -Full -SQL server-01 # out to database SQLite
.LINK
https://github.com/Lifailon/Get-Invent-SQLite
#>
    Param (
        $srv = "localhost",
        [switch]$Full,
        [switch]$SQL,
        $path = "$home\desktop\Get-Invent.db"
    )
    $Collection = New-Object System.Collections.Generic.List[System.Object]
    $SYS = Get-WmiObject Win32_ComputerSystem -computername $srv
    $OS = Get-WmiObject Win32_OperatingSystem -computername $srv
    $BB = Get-WmiObject Win32_BaseBoard -computername $srv
    $BBv = $BB.Manufacturer + " " + $BB.Product + " " + $BB.Version
    $CPU = Get-WmiObject Win32_Processor -computername $srv | Select-Object Name,
    @{Label = "Core"; Expression = { $_.NumberOfCores } },
    @{Label = "Thread"; Expression = { $_.NumberOfLogicalProcessors } }
    $Memory = Get-WmiObject Win32_PhysicalMemory -computername $srv | Select-Object Manufacturer, PartNumber,
    ConfiguredClockSpeed, @{Label = "Memory"; Expression = { [string]($_.Capacity / 1Mb) } }
    $MEMs = $Memory.Memory | Measure-Object -Sum
    $PhysicalDisk = Get-WmiObject Win32_DiskDrive -computername $srv | Select-Object Model,
    @{Label = "Size"; Expression = { [int]($_.Size / 1Gb) } }
    $PDs = $PhysicalDisk.Size | Measure-Object -Sum
    $LogicalDisk = Get-WmiObject Win32_logicalDisk -ComputerName $srv | Where-Object { $null -ne $_.Size } | Select-Object @{
        Label = "Value"; Expression = { $_.DeviceID }
    }, @{Label = "AllSize"; Expression = {
([int]($_.Size / 1Gb)) }
    }, @{Label = "FreeSize"; Expression = {
([int]($_.FreeSpace / 1Gb)) }
    }, @{Label = "Free%"; Expression = {
            [string]([int]($_.FreeSpace / $_.Size * 100)) + " %" }
    }
    $LDs = $LogicalDisk.AllSize | Measure-Object -Sum
    $VideoCard = Get-WmiObject Win32_VideoController -computername $srv | Select-Object @{
        Label = "VideoCard"; Expression = { $_.Name }
    }, @{Label = "Display"; Expression = {
            [string]$_.CurrentHorizontalResolution + "x" + [string]$_.CurrentVerticalResolution }
    }, 
    @{Label = "vRAM"; Expression = { ($_.AdapterRAM / 1Gb) } }
    $VCs = $VideoCard.vRAM | Measure-Object -Sum
    $NetworkAdapter = Get-WmiObject Win32_NetworkAdapter -computername $srv | Where-Object {
        $null -ne $_.Macaddress } | Select-Object Manufacturer, @{
        Label = "NetworkAdapter"; Expression = { $_.Name }
    }, Macaddress
    $NAs = $NetworkAdapter | Measure-Object
    $Collection.Add([PSCustomObject]@{
            Host                = $SYS.Name
            Owner               = $SYS.PrimaryOwnerName
            OS                  = $OS.Caption
            MotherBoard         = $BBv
            CPU                 = $CPU[0].Name
            Core                = $CPU[0].Core
            Thread              = $CPU[0].Thread
            MemoryAll           = [String]$MEMs.Sum + " Mb"
            MemorySlots         = $MEMs.Count
            PhysicalDiskCount   = $PDs.Count
            LogicalDiskCount    = $LDs.Count
            LogicalDiskAllSize  = [String]$LDs.Sum + " Gb"
            VideoCardCount      = $VCs.Count
            VideoCardAllSize    = [String]$VCs.Sum + " Gb"
            NetworkAdapterCount = $NAs.Count
        })
    $Collection

    if ($full) {
        $CollectionMEM = New-Object System.Collections.Generic.List[System.Object]
        $Memory | ForEach-Object {
            $CollectionMEM.Add([PSCustomObject]@{
                    MemoryModel = [String]$_.ConfiguredClockSpeed + " Mhz " + $_.Manufacturer + " " + $_.PartNumber
                    Memory      = [string]($_.Memory) + " Mb"
                })
        }

        $CollectionPD = New-Object System.Collections.Generic.List[System.Object]
        $PhysicalDisk | ForEach-Object {
            $CollectionPD.Add([PSCustomObject]@{
                    PhysicalDiskModel = $_.Model
                    Size              = [string]$_.Size + " Gb"
                })
        }

        $CollectionLD = New-Object System.Collections.Generic.List[System.Object]
        $LogicalDisk | ForEach-Object {
            $CollectionLD.Add([PSCustomObject]@{
                    LogicalDisk = $_.Value
                    AllSize     = [string]$_.AllSize + " Gb"
                    FreeSize    = [string]$_.FreeSize + " Gb"
                    Free        = $_."Free%"
                })
        }

        $CollectionVC = New-Object System.Collections.Generic.List[System.Object]
        $VideoCard | ForEach-Object {
            $CollectionVC.Add([PSCustomObject]@{
                    VideoCard = $_.VideoCard
                    Display   = $_.Display
                    vRAM      = [string]$_.vRAM + " Gb"
                })
        }

        $CollectionMEM
        $CollectionPD
        $CollectionLD
        $CollectionVC
        $NetworkAdapter

        if ($SQL) {
            # Import-Module mySQLite

            $MEM = $CollectionMEM | Select-Object @{Name = "Host"; Expression = { $SYS.Name } }, MemoryModel, Memory
            $PD = $CollectionPD | Select-Object @{Name = "Host"; Expression = { $SYS.Name } }, PhysicalDiskModel, Size
            $VC = $CollectionVC | Select-Object @{Name = "Host"; Expression = { $SYS.Name } }, VideoCard, Display, vRAM

            if (!(Test-Path $path)) {
                New-MySQLiteDB -Path $path
            }

            $Tables = Invoke-MySQLiteQuery -Path $path -Query "SELECT name FROM sqlite_master WHERE type='table';"

            if (!($Tables.Name -match "CPU")) {
                Invoke-MySQLiteQuery -Path $path -Query "CREATE TABLE CPU (
Host TEXT NOT NULL, Owner TEXT NOT NULL, OS TEXT NOT NULL,
MotherBoard TEXT NOT NULL, CPU TEXT NOT NULL, Core TEXT NOT NULL,
Thread TEXT NOT NULL, MemoryAll TEXT NOT NULL, MemorySlots TEXT NOT NULL,
PhysicalDiskCount TEXT NOT NULL, LogicalDiskCount TEXT NOT NULL, LogicalDiskAllSize TEXT NOT NULL,
VideoCardCount TEXT NOT NULL, VideoCardAllSize TEXT NOT NULL, NetworkAdapterCount TEXT NOT NULL
);"
            }

            if (!($Tables.Name -match "Memory")) {
                Invoke-MySQLiteQuery -Path $path -Query "CREATE TABLE Memory (
Host TEXT NOT NULL, MemoryModel TEXT NOT NULL, Memory TEXT NOT NULL
);"
            }

            if (!($Tables.Name -match "PhysicalDisk")) {
                Invoke-MySQLiteQuery -Path $path -Query "CREATE TABLE PhysicalDisk (
Host TEXT NOT NULL, PhysicalDiskModel TEXT NOT NULL, Size TEXT NOT NULL
);"
            }

            if (!($Tables.Name -match "VideoCard")) {
                Invoke-MySQLiteQuery -Path $path -Query "CREATE TABLE VideoCard (
Host TEXT NOT NULL, VideoCard TEXT NOT NULL, Display TEXT NOT NULL, vRAM TEXT NOT NULL
);"
            }

            foreach ($C in $Collection) {
                $1 = $C.Host;
                $2 = $C.Owner;
                $3 = $C.OS;
                $4 = $C.MotherBoard
                $5 = $C.CPU
                $6 = $C.Core
                $7 = $C.Thread
                $8 = $C.MemoryAll
                $9 = $C.MemorySlots
                $10 = $C.PhysicalDiskCount
                $11 = $C.LogicalDiskCount
                $12 = $C.LogicalDiskAllSize
                $13 = $C.VideoCardCount
                $14 = $C.VideoCardAllSize
                $15 = $C.NetworkAdapterCount
                Invoke-MySQLiteQuery -Path $path -Query "INSERT INTO CPU (Host, Owner, OS, MotherBoard,
CPU, Core, Thread, MemoryAll, MemorySlots, PhysicalDiskCount, LogicalDiskCount, LogicalDiskAllSize,
VideoCardCount, VideoCardAllSize, NetworkAdapterCount)
VALUES ('$1', '$2', '$3', '$4', '$5', '$6', '$7', '$8', '$9', '$10', '$11', '$12', '$13', '$14', '$15');"
            }

            foreach ($M in $MEM) {
                $1 = $M.Host;
                $2 = $M.MemoryModel;
                $3 = $M.Memory;
                Invoke-MySQLiteQuery -Path $path -Query "INSERT INTO Memory (Host, MemoryModel, Memory) 
VALUES ('$1', '$2', '$3');"
            }

            foreach ($D in $PD) {
                $1 = $D.Host;
                $2 = $D.PhysicalDiskModel;
                $3 = $D.Size;
                Invoke-MySQLiteQuery -Path $path -Query "INSERT INTO PhysicalDisk (Host, PhysicalDiskModel, Size) 
VALUES ('$1', '$2', '$3');"
            }

            foreach ($V in $VC) {
                $1 = $V.Host;
                $2 = $V.VideoCard;
                $3 = $V.Display;
                $4 = $V.vRAM;
                Invoke-MySQLiteQuery -Path $path -Query "INSERT INTO VideoCard (Host, VideoCard, Display, vRAM) 
VALUES ('$1', '$2', '$3', '$4');"
            }

        }
    }
}