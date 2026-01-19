# Source: https://github.com/ishu3101/PSMarkdown

Function ConvertFrom-MarkdownV2 {
    [CmdletBinding()]
    [OutputType([PSObject])]
    Param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        $InputObject
    )
    Begin {
        $items = @()
    }
    Process {
        $mddata = $InputObject
        $data = $mddata | Where-Object {$_ -notmatch "--" }
        $items += $data
    }
    End {
       $object = $items -replace ' +', '' | ConvertFrom-Csv -Delimiter '|'
       $object 
    }
}