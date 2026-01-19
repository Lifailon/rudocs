function Send-ToTelegramFile {
    param (
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Token,
        [Parameter(Mandatory = $true)][string]$Chat,
        $Keyboard
    )
    $endpoint = "senddocument"
    $url      = "https://api.telegram.org/bot$Token/$endpoint"
    $multipartContent = [System.Net.Http.MultipartFormDataContent]::new()
    $fileStream = [System.IO.FileStream]::new($Path, [System.IO.FileMode]::Open)
    $fileContent = [System.Net.Http.StreamContent]::new($fileStream)
    $fileHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
    $fileHeader.Name = "document"
    $fileHeader.FileName = [System.IO.Path]::GetFileName($Path)
    $fileContent.Headers.ContentDisposition = $fileHeader
    $multipartContent.Add($fileContent, "document")
    if ($Keyboard) {
        $keyboardContent = [System.Net.Http.StringContent]::new($Keyboard)
        $keyboardContent.Headers.ContentType.MediaType = "application/json"
        $multipartContent.Add($keyboardContent, "reply_markup")
    }
    $chatContent = [System.Net.Http.StringContent]::new($Chat)
    $multipartContent.Add($chatContent, "chat_id")
    $response = Invoke-RestMethod -Uri $url -Method Post -Body $multipartContent -ContentType "multipart/form-data"
    $fileStream.Dispose()
    return $response
}

# Send-ToTelegramFile -Path "C:\Users\Lifailon\Documents\lake.jpg" -Token "7777777777:AAF..." -Chat "7777777777"