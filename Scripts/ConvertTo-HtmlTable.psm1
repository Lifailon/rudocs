function ConvertTo-HtmlTable {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][object]$Object
    )
    $html = "<table>"
    $html += "<tr>"
    foreach ($property in $Object.PSObject.Properties) {
        $html += "<th>$($property.Name)</th>"
    }
    $html += "</tr>"
    foreach ($item in $Object) {
        $html += "<tr>"
        foreach ($property in $item.PSObject.Properties) {
            $html += "<td>$($property.Value)</td>"
        }
        $html += "</tr>"
    }
    $html += "</table>"
    return $html
}