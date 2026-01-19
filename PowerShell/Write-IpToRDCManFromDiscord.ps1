$DISCORD_TOKEN = "MTE5NzE1NjM0NTM3NjQxMTcyOQ.XXXXXX.EzBF6RA9Kx_MSuhLW5elH1U-XXXXXXXXXXXXXX"
$DISCORD_CHANNEL_ID = "119403124XXXXXXXXXX"
$RDCMan_RDG_PATH = "C:\RDCMan\main.rdg"
$RDCMan_Display_Name = "White-RDP"

function Read-DiscordMessages {
    param (
        $Token,
        $Channel,
        [switch]$Last
    )
    $URL = "https://discordapp.com/api/channels/$Channel/messages"
    $Output = curl -s -X GET $URL -H "Authorization: Bot $Token" -H "Content-Type: application/json" | ConvertFrom-Json
    if ($last) {
        $Output[0].content
    }
    else {
        $Output | Select-Object @{Name="Time"; Expression={$_.timestamp}},
        @{Name="Message"; Expression={$_.content}},
        @{Name="UserName"; Expression={$_.author.username}}
    }
}

$RDG =  Get-Content $RDCMan_RDG_PATH
$Current_IP = $RDG | Select-String $RDCMan_Display_Name -Context 0,1
$Current_IP = $Current_IP.Context.DisplayPostContext[0] -replace ".+<name>|<\/name>"
$New_IP = Read-DiscordMessages -Token $DISCORD_TOKEN -Channel $DISCORD_CHANNEL_ID -Last
if ($Current_IP -ne $New_IP) {
    $RDCMan_PATH = $(Get-Process *RDCMan* | Where-Object Description -match "Remote Desktop Connection Manager").Path
    Get-Process *RDCMan* | Where-Object Description -match "Remote Desktop Connection Manager" | Stop-Process
    $RDG -replace "$Current_IP","$New_IP" > $RDCMan_RDG_PATH
    Start-Process $RDCMan_PATH
}
