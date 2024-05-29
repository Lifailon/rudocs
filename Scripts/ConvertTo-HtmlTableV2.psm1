function ConvertTo-HtmlTableV2 {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][object]$Object
    )
    $html = $Object | ConvertTo-Html
    $($([string]$html -split "<body> ")[1] -split " </body>")[0]
}