$GitHubUsername = "Lifailon"
$GitHubToken = "Personal access tokens (classic)" # from https://github.com/settings/tokens
$ExcludeForks = $false

$headers = @{
    "Authorization" = "token $GitHubToken"
    "Accept" = "application/vnd.github.v3+json"
}

function Get-GitHubRepositories {
    $allRepos = @()
    $page = 1
    $perPage = 100
    
    do {
        $uri = "https://api.github.com/users/$GitHubUsername/repos?page=$page&per_page=$perPage"
        $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
        if ($ExcludeForks) {
            $repos = $response | Where-Object { $_.fork -eq $false }
        } else {
            $repos = $response
        }
        
        $allRepos += $repos
        $page++
    } while ($response.Count -eq $perPage)
    
    return $allRepos
}

function Get-RepositoryLanguages {
    param (
        [string]$repoName
    )
    $uri = "https://api.github.com/repos/$GitHubUsername/$repoName/languages"
    try {
        $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
        return $response
    } catch {
        Write-Warning "Error getting languages from ${repoName} repository: $_"
        return $null
    }
}

$repositories = Get-GitHubRepositories
$results = @()

foreach ($repo in $repositories) {
    $repoName = $repo.name
    $languages = Get-RepositoryLanguages -repoName $repoName
    if ($languages) {
        $totalSize = ($languages.PSObject.Properties.Value | Measure-Object -Sum).Sum
        $result = [PSCustomObject][ordered]@{
            Repository = $repoName
            SizeKB = [math]::Round($totalSize / 1KB, 2)
            SizeMB = [math]::Round($totalSize / 1MB, 2)
            Languages = ($languages.PSObject.Properties.Name -join ", ")
            PowerShell_KB = if ($languages.PowerShell) { [math]::Round($languages.PowerShell / 1KB, 2) } else { 0 }
            PowerShell_MB = if ($languages.PowerShell) { [math]::Round($languages.PowerShell / 1MB, 2) } else { 0 }
            PowerShell_Percent = if ($totalSize -gt 0 -and $languages.PowerShell) { [math]::Round(($languages.PowerShell / $totalSize) * 100, 2) } else { 0 }
            URL = $repo.html_url
            Created = $repo.created_at
            Updated = $repo.updated_at
            User = $env:USERNAME
            Server = $env:COMPUTERNAME
        }
        $results += $result
    }
}

# $results | Sort-Object -Property SizeMB -Descending | Format-Table -AutoSize
# $results | Export-Csv -Path "GitHubReposAnalysis.csv" -NoTypeInformation -Encoding UTF8
$results | Out-GridView