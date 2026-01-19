# Установка модуля (идет в составе с Terminal.Gui)
# Install-Module Microsoft.PowerShell.ConsoleGuiTools

# Импорт модуля
Import-Module Microsoft.PowerShell.ConsoleGuiTools
# Импорт .NET библиотеки
$module = $(Get-Module Microsoft.PowerShell.ConsoleGuiTools -List).ModuleBase
Add-Type -Path $(Join-Path $module Terminal.Gui.dll)[0]
# Инициализация
[Terminal.Gui.Application]::Init()

# Создание основного окна
$top = [Terminal.Gui.Application]::Top
$win = New-Object Terminal.Gui.Window -Property @{
    Title = "PowerShell TUI Demo"
    Width = [Terminal.Gui.Dim]::Fill()
    Height = [Terminal.Gui.Dim]::Fill()
}

# Сначала создаем StatusBar
$statusBar = New-Object Terminal.Gui.StatusBar
$statusBar.Text = "Готово"

# Текстовое поле ввода
$labelInput = New-Object Terminal.Gui.Label -Property @{
    Text = "Введите текст:"
    X = 3
    Y = 2
}

$textField = New-Object Terminal.Gui.TextField -Property @{
    X = 20
    Y = 2
    Width = 30 # Уменьшено с 40
    Text = "Пример текста"
}
$textField.add_TextChanging({
    param($e)
    $statusBar.Text = "Ввод: $($e.NewText)"
})

# Поле пароля
$labelPassword = New-Object Terminal.Gui.Label -Property @{
    Text = "Пароль:"
    X = 3
    Y = 4
}

$passwordField = New-Object Terminal.Gui.TextField -Property @{
    X = 20
    Y = 4
    Width = 20
    Secret = $true
}

# CheckBox
$checkbox1 = New-Object Terminal.Gui.CheckBox -Property @{
    Text = "Опция 1"
    X = 3
    Y = 6
    Checked = $true
}

$checkbox2 = New-Object Terminal.Gui.CheckBox -Property @{
    Text = "Опция 2"
    X = 20
    Y = 6
}

$checkbox1.add_Toggled({
    $statusBar.Text = "Опция 1: $($checkbox1.Checked)"
})

# Radio Button
$labelRadio = New-Object Terminal.Gui.Label -Property @{
    Text = "Выберите:"
    X = 3
    Y = 8
}

$radioGroup = New-Object Terminal.Gui.RadioGroup -Property @{
    X = 20
    Y = 8
    RadioLabels = @("Вариант A", "Вариант B", "Вариант C")
    SelectedItem = 0
}
$radioGroup.add_SelectedItemChanged({
    $statusBar.Text = "Выбран: $($radioGroup.RadioLabels[$radioGroup.SelectedItem])"
})

# Выпадающий список (ComboBox)
$labelCombo = New-Object Terminal.Gui.Label -Property @{
    Text = "Список:"
    X = 3
    Y = 12
}

$comboBox = New-Object Terminal.Gui.ComboBox -Property @{
    X = 20
    Y = 12
    Width = 20
}
$comboBox.SetSource(@("Элемент 1", "Элемент 2", "Элемент 3", "Элемент 4"))
$comboBox.add_SelectedItemChanged({
    if ($comboBox.Text -ne "") {
        $statusBar.Text = "Выбран: $($comboBox.Text)"
    }
})

# Список (ListView)
$labelList = New-Object Terminal.Gui.Label -Property @{
    Text = "Список файлов:"
    X = 3
    Y = 14
}

$listView = New-Object Terminal.Gui.ListView -Property @{
    X = 20
    Y = 14
    Width = 30
    Height = 5
}
$listView.SetSource((Get-ChildItem -Path $HOME -File | Select-Object -First 10).Name)
$listView.add_OpenSelectedItem({
    $statusBar.Text = "Выбран файл: $($listView.Source[$listView.SelectedItem])"
})

# ProgressBar
$labelProgress = New-Object Terminal.Gui.Label -Property @{
    Text = "Прогресс:"
    X = 3
    Y = 20
}

$progressBar = New-Object Terminal.Gui.ProgressBar -Property @{
    X = 20
    Y = 20
    Width = 30
    Fraction = 0.5
}

# Многострочное текстовое поле
$labelMulti = New-Object Terminal.Gui.Label -Property @{
    Text = "Многострочный ввод:"
    X = 55  # Уменьшено с 60
    Y = 2
}

$textView = New-Object Terminal.Gui.TextView -Property @{
    X = 55  # Уменьшено с 60
    Y = 4
    Width = 25  # Уменьшено с 30
    Height = 8
    Text = "Первая строка`nВторая строка`nТретья строка"
}

# Таблица (TableView)
$labelTable = New-Object Terminal.Gui.Label -Property @{
    Text = "Процессы:"
    X = 55  # Уменьшено с 60
    Y = 13
}

$tableView = New-Object Terminal.Gui.TableView -Property @{
    X = 55  # Уменьшено с 60
    Y = 14
    Width = 35  # Уменьшено с 40
    Height = 8
}

# Заполняем таблицу процессами - УМЕНЬШАЕМ КОЛИЧЕСТВО СТОЛБЦОВ
$processes = Get-Process | Select-Object -First 10 Name, Id, WorkingSet
$dataTable = New-Object System.Data.DataTable
[void]$dataTable.Columns.Add("Имя", [string])
[void]$dataTable.Columns.Add("PID", [int])
[void]$dataTable.Columns.Add("Память", [long])  # Убрали CPU

foreach ($proc in $processes) {
    [void]$dataTable.Rows.Add($proc.Name, $proc.Id, $proc.WorkingSet)
}

$tableView.Table = $dataTable

# 10. Кнопки
$btnAction = New-Object Terminal.Gui.Button -Property @{
    Text = "Выполнить"
    X = 3
    Y = 22
}
$btnAction.add_Clicked({
    $statusBar.Text = "Выполняется действие..."
    # Имитация работы
    for ($i = 0; $i -le 10; $i++) {
        $progressBar.Fraction = $i / 10
        [Terminal.Gui.Application]::DoEvents()
        Start-Sleep -Milliseconds 100
    }
    $statusBar.Text = "Действие завершено в $(Get-Date -Format 'HH:mm:ss')"
})

$btnClear = New-Object Terminal.Gui.Button -Property @{
    Text = "Очистить"
    X = 20
    Y = 22
}
$btnClear.add_Clicked({
    $textField.Text = ""
    $passwordField.Text = ""
    $statusBar.Text = "Поля очищены"
})

$btnExit = New-Object Terminal.Gui.Button -Property @{
    Text = "Выход"
    X = 37
    Y = 22
}
$btnExit.add_Clicked({ [Terminal.Gui.Application]::RequestStop() })

# Меню
$menu = New-Object Terminal.Gui.MenuBar -Property @{
    Menus = @(
        [Terminal.Gui.MenuBarItem]::new("_Файл", @(
            [Terminal.Gui.MenuItem]::new("_Новый", "", { $statusBar.Text = "Меню: Новый файл" }),
            [Terminal.Gui.MenuItem]::new("_Открыть", "", { $statusBar.Text = "Меню: Открыть файл" }),
            [Terminal.Gui.MenuItem]::new("_Сохранить", "", { $statusBar.Text = "Меню: Сохранить" }),
            # Разделитель
            [Terminal.Gui.MenuItem]::new("", "", $null),
            [Terminal.Gui.MenuItem]::new("_Выход", "", { [Terminal.Gui.Application]::RequestStop() })
        )),
        [Terminal.Gui.MenuBarItem]::new("_Правка", @(
            [Terminal.Gui.MenuItem]::new("_Копировать", "", { $statusBar.Text = "Меню: Копировать" }),
            [Terminal.Gui.MenuItem]::new("_Вставить", "", { $statusBar.Text = "Меню: Вставить" })
        )),
        [Terminal.Gui.MenuBarItem]::new("_Справка", @(
            [Terminal.Gui.MenuItem]::new("_О программе", "", { 
                [Terminal.Gui.MessageBox]::Query("О программе", "PowerShell TUI Demo`nВерсия 1.0", "OK") 
            })
        ))
    )
}

# Добавление всех элементов в окно
$elements = @(
    $labelInput, $textField, $labelPassword, $passwordField,
    $checkbox1, $checkbox2, $labelRadio, $radioGroup,
    $labelCombo, $comboBox, $labelList, $listView,
    $labelProgress, $progressBar, $labelMulti, $textView,
    $labelTable, $tableView, $btnAction, $btnClear, $btnExit
)

foreach ($element in $elements) {
    $win.Add($element)
}

$top.Add($menu, $win, $statusBar)

# Настройка горячих клавиш
$win.add_KeyPress({
    param($e)
    switch ($e.KeyEvent.Key) {
        ([Terminal.Gui.Key]::CtrlMask -bor [Terminal.Gui.Key]::S) {
            $statusBar.Text = "Сохраняем... $(Get-Date)"
            $e.Handled = $true
        }
        ([Terminal.Gui.Key]::F5) {
            $listView.SetSource((Get-ChildItem -Path $HOME -File | Select-Object -First 10).Name)
            $statusBar.Text = "Список обновлен"
            $e.Handled = $true
        }
    }
})

# Запуск
try {
    [Terminal.Gui.Application]::Run()
}
finally {
    [Terminal.Gui.Application]::Shutdown()
}