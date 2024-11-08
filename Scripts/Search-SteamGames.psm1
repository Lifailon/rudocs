function Search-SteamGames {
    param (
        [Parameter(Mandatory = $true)][string]$Name,
        [string]$Region = "us",
        [string]$Language = "en"
    )
    # Import module Invoke-Parallel
    $module = "https://raw.githubusercontent.com/RamblingCookieMonster/Invoke-Parallel/master/Invoke-Parallel/Invoke-Parallel.ps1"
    Invoke-Expression $(Invoke-RestMethod $module)
    # Get unique app list
    $GetAppList = Invoke-RestMethod https://api.steampowered.com/ISteamApps/GetAppList/v2
    $GameList = $GetAppList.applist.apps
    $FilterList = $GameList | Where-Object name -match $Name
    $idArray = $FilterList.appid | Select-Object -Unique
    # Main object for all results
    $CustomObject = [PSCustomObject][ordered]@{}
    # foreach ($id in $idArray) {
    # Async
    Invoke-Parallel -ImportVariables -InputObject $idArray -ScriptBlock {
        $id = $_ # Use for async
        $idResponse = Invoke-RestMethod "https://store.steampowered.com/api/appdetails?appids=${id}&cc=${Region}&l={$Language}"
        $idData = $idResponse."$id".data
        $Collections = New-Object System.Collections.Generic.List[System.Object]
        $Collections.Add([PSCustomObject]@{
            Name        = $idData.name
            Url         = "https://store.steampowered.com/app/$id"
            Info        = $idData.support_info.url
            Developers  = $idData.publishers
            Publishers  = $idData.developers
            Date        = $idData.release_date.date
            Rating      = $idData.recommendations.total
            Price       = $idData.price_overview.final_formatted
            Discount    = $idData.price_overview.discount_percent
            Description = $idData.short_description
            Categories  = $idData.categories | ForEach-Object {$_.description}
            Genres      = $idData.genres | ForEach-Object {$_.description}
            Image       = $idData.header_image
            Screenshots = $idData.screenshots | ForEach-Object {$_.path_full}
            Movies      = $idData.movies | ForEach-Object {$_.mp4.max}
            dlcCount    = $idData.dlc.Count
            dlcUrl      = $idData.dlc | ForEach-Object {"https://store.steampowered.com/app/$_"}
        })
        $CustomObject | Add-Member –MemberType NoteProperty –Name $id –Value $Collections
    }
    $CustomObject
}

# $Data = Search-SteamGames -Name "Prey" -Region "ru" -Language "ru"
# $Data = Search-SteamGames -Name "Prey"
# $Data = Search-SteamGames -Name "God of War"
# $Data