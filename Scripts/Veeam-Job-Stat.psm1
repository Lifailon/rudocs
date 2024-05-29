function Veeam-Job-Stat {
    $VBRBackup = Get-VBRBackup
    $Collections = New-Object System.Collections.Generic.List[System.Object]
    foreach ($VBRB in $VBRBackup) {
        if (($VBRB.VmCount -ne 0) -and ($VBRB.ForceOffload -ne $True)) {
            if ($VBRB.JobType -eq "Backup") {
                ### Jobs VM
                $VBRJob = Get-VBRJob -Name $VBRB.JobName
                $EnabledJob = $VBRJob.IsScheduleEnabled
            }
            else {
                ### Jobs PC
                $VBRJob = Get-VBRComputerBackupJob -Name $VBRB.JobName
                $EnabledJob = $VBRJob.ScheduleEnabled
            }
            if ($EnabledJob -ne $Null) {
                ### Repository
                $VBRBR = Get-VBRBackupRepository | where id -Match $VBRB.RepositoryId
                ### RestorePoint
                $RestorePoint = Get-VBRRestorePoint -Backup $VBRB
                if ($RestorePoint.CompletionTimeUTC -ne $null) {
                    $VBRRP = $RestorePoint | sort CompletionTimeUTC | select -Last 1
                }
                $RunTime = ($VBRRP.CompletionTimeUTC.ToLocalTime() - $VBRRP.CreationTime) | % {
                    [string]$_.Hours + ":" + [string]$_.Minutes + ":" + [string]$_.Seconds
                }
                $Collections.Add([PSCustomObject]@{
                        EnabledJob         = $EnabledJob;
                        JobName            = $VBRB.JobName;
                        VmCount            = $VBRB.VmCount;
                        VmName             = $VBRRP.VmName
                        JobType            = $VBRB.JobType;
                        LatestRunLocal     = $VBRJob.LatestRunLocal;
                        TimeLastCreation   = $VBRRP.CreationTime;
                        TimeLastCompletion = $VBRRP.CompletionTimeUTC.ToLocalTime();
                        RunTime            = $RunTime;
                        RepositoryType     = $VBRBR.TypeDisplay;
                        Repository         = $VBRBR.Name; #$VBRRP.FindChainRepositories().Name
                        DirPath            = $VBRB.DirPath;
                        VmSize             = [string]([int64](($VBRRP.ApproxSize) / 1024mb)) + "GB"
                        BackupName         = $VBRRP.GetStorage().PartialPath.Elements[0]
                        BackupType         = $VBRRP.Type;
                        BackupSize         = [string]([int64](($VBRRP.GetStorage().stats.BackupSize) / 1024mb)) + "GB"
                    })
            }
        }
    }
    $Collections
}