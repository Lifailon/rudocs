# Source: https://github.com/Lifailon/epic-games-radar 

function Get-GameList {
    param (
        [ValidateSet("tierFree","tierDiscouted")][string]$Price,
        [ValidateSet("en-US","ru")][string]$Region,
        [ValidateRange(100,500)][int]$Count
    )
    # $url = "https://store.epicgames.com/en-US/browse?sortBy=releaseDate&sortDir=DESC&priceTier=tierFree&category=Game&count=500&start=0"
    $url = "https://store.epicgames.com/$Region/browse?sortBy=releaseDate&sortDir=DESC&priceTier=$($Price)&category=Game&count=$($Count)&start=0"
    $Agents = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"
    
    # v1 (HttpClient)
    # $handler = New-Object System.Net.Http.HttpClientHandler
    # $handler.AllowAutoRedirect = $true
    # $HttpClient = New-Object System.Net.Http.HttpClient($handler)
    # $requestMessage = [System.Net.Http.HttpRequestMessage]::new([System.Net.Http.HttpMethod]::Get, $url)
    # $requestMessage.Headers.Add("User-Agent", $userAgent)
    # $requestMessage.Headers.Add("Accept", "text/html")
    # $response = $HttpClient.SendAsync($requestMessage).Result
    # $content = $response.Content.ReadAsStringAsync().Result

    # v2 (WebClient)
    # $WebClient = New-Object System.Net.WebClient
    # $userAgent = Get-Random -InputObject $Agents
    # $WebClient.Headers.Add("User-Agent", $userAgent)
    # $WebClient.Headers.Add("Accept", "text/html")
    # $content = $WebClient.DownloadString($url)

    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $session.UserAgent = $Agents
    $response = Invoke-WebRequest -Uri $url -WebSession $session -Headers @{
        "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
        "Service-Worker-Navigation-Preload"="true"
        "Upgrade-Insecure-Requests"="1"
        "sec-ch-ua"="`"Chromium`";v=`"124`", `"Google Chrome`";v=`"124`", `"Not-A.Brand`";v=`"99`""
        "sec-ch-ua-mobile"="?0"
        "sec-ch-ua-platform"="`"Windows`""
    }
    $content = $response.Content

    # Get json from html
    $json = $($($($content -split "__REACT_QUERY_INITIAL_QUERIES__ = ")[1] -split "window.server_rendered")[0] -replace ";")
    # Data filtering
    $games = $($json | ConvertFrom-Json).queries.state.data[-1].catalog.searchStore.elements

    # Output formatting
    $Collections = New-Object System.Collections.Generic.List[System.Object]
    foreach ($game in $games) {
        $urlGame = $game.offerMappings.pageSlug
        if ($null -eq $urlGame) {
            $urlGame = $game.title.ToLower().replace(" ","-")
        }
        $Developer = $game.developerDisplayName
        $Publisher = $game.publisherDisplayName
        if ($null -eq $Developer) {
            $Developer = "-"
        }
        if ($null -eq $Publisher) {
            $Publisher = "-"
        }
        $FullPrice = $game.price.totalPrice.fmtPrice.originalPrice
        if ($FullPrice -eq 0) {
            $Discount = "Free"
        } else {
            $Discount = [string]$([math]::Round((1 - ($($game.price.totalPrice.discountPrice) / $($game.price.totalPrice.originalPrice))) * 100, 2)) + " %"
        }
        $DiscountEndDate = $game.price.lineOffers.appliedRules.endDate
        if ($null -eq $DiscountEndDate) {
            $DiscountEndDate = "-"
        }
        $Collections.Add([PSCustomObject]@{
            Title           = $game.title
            Developer       = $Developer
            Publisher       = $Publisher
            Description     = $game.description
            Url             = "https://store.epicgames.com/$region/p/$urlGame"
            ReleaseDate     = $game.releaseDate
            FullPrice       = $FullPrice
            CurrentPrice    = $game.price.totalPrice.fmtPrice.discountPrice
            Discount        = $Discount
            DiscountEndDate = $DiscountEndDate
        })
    }
    $Collections
}

### Examples:
# Get-GameList -Price tierFree -Region en-US -Count 500
# Get-GameList -Price tierDiscouted -Region en-US -Count 500
# Get-GameList -Price tierFree -Region ru -Count 500
# Get-GameList -Price tierDiscouted -Region ru -Count 500