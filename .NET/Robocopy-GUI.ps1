# RunAs Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {  
  $arguments = "& '" + $myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb RunAs -ArgumentList $arguments
  Break
}

$Time = foreach ($for in 0..24) { "$for" + ":00" }
$min = @("5", "10", "15", "30", "60")

Add-Type -AssemblyName System.Windows.Forms

$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = 'Robocopy-GUI Scheduler'
$main_form.ShowIcon = $false
$main_form.Width = 320
$main_form.Height = 300
$main_form.AutoSize = $true

$button1 = New-Object System.Windows.Forms.Button
$button1.Text = 'Откуда'
$button1.Location = New-Object System.Drawing.Point(10, 10)
$button1.AutoSize = $true
$main_form.Controls.Add($button1)

$button1.Add_Click({
    $FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $FolderBrowser.ShowDialog()
    $source = @($FolderBrowser.SelectedPath)
    if ($source -ne $null) { $out1 = @("$source") } else { $out1 = "директория не выбрана" }
    $outputBox1.text = $out1
  })

$outputBox1 = New-Object System.Windows.Forms.TextBox 
$outputBox1.Location = New-Object System.Drawing.Size(100, 10) 
$outputBox1.Size = New-Object System.Drawing.Size(160, 22) 
$outputBox1.MultiLine = $True
$main_form.Controls.Add($outputBox1)

$button2 = New-Object System.Windows.Forms.Button
$button2.Text = 'Куда'
$button2.Location = New-Object System.Drawing.Point(10, 40)
$button2.AutoSize = $true
$main_form.Controls.Add($button2)

$button2.Add_Click({
    $FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $FolderBrowser.ShowDialog()
    $dest = @($FolderBrowser.SelectedPath)
    if ($dest -ne $null) { $out2 = @("$dest") } else { $out2 = "директория не выбрана" }
    $outputBox2.text = $out2
  })

$outputBox2 = New-Object System.Windows.Forms.TextBox 
$outputBox2.Location = New-Object System.Drawing.Size(100, 40) 
$outputBox2.Size = New-Object System.Drawing.Size(160, 22) 
$outputBox2.MultiLine = $True
$main_form.Controls.Add($outputBox2)

$button3 = New-Object System.Windows.Forms.Button
$button3.Text = 'Реплицировать'
$button3.Location = New-Object System.Drawing.Point(10, 70)
$button3.AutoSize = $true
$main_form.Controls.Add($button3)

$button3.Add_Click({
    robocopy $outputBox1.text $outputBox2.text /MIR /COPYALL /Z /B /J /R:5 /W:5 # использовать текст из outputBox
    # /MIR - создать зеркало дерева папок (эквивалентно /E с /PURGE)
    # /E - копировать вложенные папки, включая пустые
    # /PURGE - удалять файлы и папки назначения, которых больше не существует в источнике
    # /COPYALL - копировать все сведения о файле (эквивалентно /COPY:DATSOU)
    # /COPY:флаги копирования -D=Данные, A=Атрибуты, T=Метки времени, S=Безопасность=NTFS ACLs, O=Сведения о владельце, U=Сведения аудита
    # /Z - продолжит копирование файла при обрыве, полезно при копировании больших файлов
    # /B – позволяет избегать ошибки access denied error, игнорирует все права на файлы, которые могли бы помешать прочитать/записать файл
    # /J – копирование без буфера (файлового кэша, оперативной памяти), эффективно для больших файлов
    # /R:3 – количество попыток скопировать недоступный файл, значение по умолчанию – миллион
    # /W:1 – секунды между попытками скопировать недоступный файл, значение по умолчанию – 30 секунд
    # /REG – сохранить текущие значения ключей /R и /W в реестр как стандартные, для будущих вызовов
    # /NP - не отображать число скопированных %
  })

$text4 = New-Object System.Windows.Forms.Label
$text4.Text = 'Название задания:'
$text4.Location = New-Object System.Drawing.Point(10, 105)
$text4.AutoSize = $true
$main_form.Controls.Add($text4)

$TextBox1 = New-Object System.Windows.Forms.TextBox
$TextBox1.Location = New-Object System.Drawing.Point(120, 102)
$TextBox1.Width = 140
$main_form.Controls.Add($TextBox1)

$text2 = New-Object System.Windows.Forms.Label
$text2.Text = 'Назначить время выполнения:'
$text2.Location = New-Object System.Drawing.Point(10, 132)
$text2.AutoSize = $true
$main_form.Controls.Add($text2)

$ComboBox1 = New-Object System.Windows.Forms.ComboBox
$ComboBox1.Location = New-Object System.Drawing.Point(180, 130)
$ComboBox1.Width = 80
foreach ($fortime in $time) { $ComboBox1.Items.Add($fortime) }
$main_form.Controls.Add($ComboBox1)

$text3 = New-Object System.Windows.Forms.Label
$text3.Text = 'Частота выполнения в минутах:'
$text3.Location = New-Object System.Drawing.Point(10, 164)
$text3.AutoSize = $true
$main_form.Controls.Add($text3)

$ComboBox2 = New-Object System.Windows.Forms.ComboBox
$ComboBox2.Location = New-Object System.Drawing.Point(180, 162)
$ComboBox2.Width = 80
foreach ($formin in $min) { $ComboBox2.Items.Add($formin) }
$main_form.Controls.Add($ComboBox2)

$button4 = New-Object System.Windows.Forms.Button
$button4.Text = 'Создать задание'
$button4.Location = New-Object System.Drawing.Point(10, 195)
$button4.AutoSize = $true
$main_form.Controls.Add($button4)

$button4.Add_Click({
    $Name = $TextBox1.text
    $log_file = "C:\Users\$env:UserName\Documents\$Name" + "-log.txt"
    $source = $outputBox1.text
    $dest = $outputBox2.text
    $sync = "robocopy $source $dest /MIR /COPYALL /Z /B /J /R:5 /W:5 /NP /LOG+:$log_file"
    $timer = New-TimeSpan -Minutes $ComboBox2.text
    $Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $sync
    $Trigger = New-ScheduledTaskTrigger -Once -At $ComboBox1.text -RepetitionInterval $Timer
    Register-ScheduledTask -TaskName $Name -Action $Action -Trigger $Trigger -RunLevel Highest –Force
  })

$button5 = New-Object System.Windows.Forms.Button
$button5.Text = 'Открыть планировщик'
$button5.Location = New-Object System.Drawing.Point(120, 195)
$button5.AutoSize = $true
$main_form.Controls.Add($button5)

$button5.Add_Click({
    taskschd.msc
  })

$main_form.ShowDialog()