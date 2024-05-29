# Install-WindowsFeature -Name UpdateServices-RSAT
Add-Type -AssemblyName "Microsoft.UpdateServices.Administration"

# Подключаемся к серверу WSUS
$srv = "srv-wsus-01"
$wsusServer = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer($srv, $False, 8530)
$computerTargetScope = New-Object Microsoft.UpdateServices.Administration.ComputerTargetScope
$allComputers = $wsusServer.GetComputerTargets($computerTargetScope)

# Создаем объект UpdateScope
$updateScope = New-Object Microsoft.UpdateServices.Administration.UpdateScope
$updateScope.IncludedInstallationStates = [Microsoft.UpdateServices.Administration.UpdateInstallationState]::NotInstalled

# Массив для хранения результатов
$report = @()
foreach ($computer in $allComputers) {
    $updateInstallationInfoCollection = $computer.GetUpdateInstallationInfoPerUpdate($updateScope)
    # Проверяем, обновления, которые еще не установлены
    if ($updateInstallationInfoCollection.Count -gt 0) {
        foreach ($updateInfo in $updateInstallationInfoCollection) {
            $update = $wsusServer.GetUpdate($updateInfo.UpdateId)
            $report += [PSCustomObject]@{
                ComputerName = $computer.FullDomainName
                UpdateTitle = $update.Title
                UpdateClassification = $update.GetUpdateClassification().Title
                UpdateApproval = $update.GetUpdateApprovals() | Select-Object -ExpandProperty Action
                UpdateDeadline = $update.GetUpdateApprovals() | Select-Object -ExpandProperty Deadline
            }
        }
    }
}

# Создаем HTML отчет
$htmlReport = @"
<!DOCTYPE html>
<html>
<head>
    <title>WSUS Report</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>WSUS Report</h1>
    <table>
        <tr>
            <th>Computer Name</th>
            <th>Update Title</th>
            <th>Update Classification</th>
            <th>Update Approval</th>
            <th>Update Deadline</th>
        </tr>
"@

foreach ($entry in $report) {
    $htmlReport += @"
        <tr>
            <td>$($entry.ComputerName)</td>
            <td>$($entry.UpdateTitle)</td>
            <td>$($entry.UpdateClassification)</td>
            <td>$($entry.UpdateApproval)</td>
            <td>$($entry.UpdateDeadline)</td>
        </tr>
"@
}

$htmlReport += @"
    </table>
</body>
</html>
"@

# Сохраняем отчет в HTML файл
$reportPath = "$home\Documents\WSUS-Report.html"
$htmlReport | Out-File -FilePath $reportPath -Encoding utf8