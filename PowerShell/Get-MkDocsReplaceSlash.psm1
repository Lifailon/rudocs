# Удаляет обратные слэши в конце каждый строки во всех дочерних файлах подкаталогах директории docs
# Актуально при использовании расширения markdown.extensions.nl2br

function Get-ReplaceSlash {
    param (
        [string]$directory
    )
    Get-ChildItem -Path $directory -Recurse -Filter *.md | ForEach-Object {
        $file = $_.FullName
        (Get-Content $file) -replace '\\$', '' | Set-Content $file
    }
    Get-ChildItem -Path $directory -Directory | ForEach-Object {
        Get-ReplaceSlash $_.FullName
    }
}

# Get-ReplaceSlash "$home\Desktop\mkdocs-material\docs"