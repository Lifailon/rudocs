function ConvertTo-HtmlTableSort {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $false)][object]$Object
    )
    $Style = '
        <style>
            header {
                background-color: #4051B5;
                color: white;
                text-align: center;
                padding: 20px 0;
                position: fixed;
                width: 100%;
                top: 0;
                left: 0;
                z-index: 1000;
            }
            header a {
                color: white;
                text-decoration: none;
                font-size: 26px;
            }
            body {
                margin: 0;
                padding-top: 50px;
                padding-left: 150px;
                padding-right: 150px;
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
    '
    $Script = '
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
    '
    return $Object | ConvertTo-Html -Head $Style -Body $Script
}

# Examples:
# ConvertTo-HtmlTableSort $(Get-Process) | Out-File report.html
# ConvertTo-HtmlTableSort $(Get-Service | Select-Object Name,Status) | Out-File report.html