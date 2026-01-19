# Example:
# Get-Content index.md -Raw | ConvertFrom-MarkdownToHtml | Out-File index.html

function ConvertFrom-MarkdownToHtml  {
param (
    [Parameter(Mandatory = $true,ValueFromPipeline = $true)]$Markdown
)
$html = $(Get-Content index.md -Raw | ConvertFrom-Markdown).html
@"
<!DOCTYPE html>
<html>
    <head>
        <style>
            body {
                margin: 0;
                padding-left: 200px;
                padding-right: 200px;
            }
            h1 {
                color: #4051B5;
            }
            h2 {
                color: #4051B5;
            }
            h3 {
                color: #4051B5;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin: auto;
                font-size: 14px;
            }
            th, td {
                border: 1px solid black;
                padding: 8px;
                text-align: left;
                cursor: pointer;
            }
            th {
                background-color: #6495ED;
                color: white;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            th:hover {
                background-color: #4051B5;
            }
            .ascending::after {
                content: " ▲";
            }
            .descending::after {
                content: " ▼";
            }
        </style>
    </head>
    <body>
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                var tableLinks = document.querySelectorAll("table a");
                tableLinks.forEach(function(link) {
                    link.setAttribute("target", "_blank");
                });
            });
            document.addEventListener("DOMContentLoaded", function() {
                var tables = document.querySelectorAll("table");
                tables.forEach(function(table) {
                    makeTableSortable(table);
                });
            });
            function makeTableSortable(table) {
                var headers = table.querySelectorAll("th");
                headers.forEach(function(header, index) {
                    header.addEventListener("click", function() {
                        sortTable(table, index);
                    });
                });
            }
            function sortTable(table, columnIndex) {
                var rows = Array.from(table.rows).slice(1);
                var ascending = !table.rows[0].cells[columnIndex].classList.contains("ascending");
                rows.sort(function(rowA, rowB) {
                    var cellA = rowA.cells[columnIndex].textContent.trim();
                    var cellB = rowB.cells[columnIndex].textContent.trim();
                    return ascending ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
                });
                rows.forEach(function(row) {
                    table.appendChild(row);
                });
                updateHeaderClasses(table, columnIndex, ascending);
            }
            function updateHeaderClasses(table, columnIndex, ascending) {
                var headers = table.querySelectorAll("th");
                headers.forEach(function(header, index) {
                    if (index === columnIndex) {
                        if (ascending) {
                            header.classList.add("ascending");
                            header.classList.remove("descending");
                        } else {
                            header.classList.add("descending");
                            header.classList.remove("ascending");
                        }
                    } else {
                        header.classList.remove("ascending");
                        header.classList.remove("descending");
                    }
                });
            }
        </script>
        $html
    </body>
</html>
"@
}