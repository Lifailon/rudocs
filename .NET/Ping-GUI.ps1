#region ico
$ico_start = [System.Convert]::FromBase64String("
iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAA9pJREFUSEu1Vk1oXFU
U/s5985MmLbYWlVYUQRRpa7XqphsXLupCt3HRUmpBdKWgWEUUOgiCzULBnTKxxWIXGVCp46JFigZlaFE0NF
Y0aWpsk2km6UyS+X3v3XuO3DtvxnEytIPWNwzvPd695zvnO9855xK6LxECQHccP75uw+DqPaxojxF52ojsY
OHNIgCDrxmWXxiSBdOpuDZ/LOx/tQ5AQCSdJq2xvy9rPJNR98cWd4PoWSOyh0XuZBEYEcUQOAD3zmzvDMwJ
82kmOlaO3Z3D8DB3grQBUqmUGtuGGAa2HDSG3xRgq2Ymn7XSzDYoEBE8ck/OKS0MX2vWEGFgXoB3arHqUVy
ARiplN0UrRWhbJhNHvPiCEI4IJF7V2qvogEQEHil4zrgCEdrP9t1+r+hAqiY0LAhZ8+v+usaHGD4c2kgc3x
gbUw8OlJ4TwfshS7IUNFRNh1DOKLXv3QDN7woKgF1f9Bs2Gp9FXg6TP6bxTIYpJaK+ODm62xCfsLQU6tVYO
QzcRstx0vPgqaaRngAgKNWMsBz4KAQ1y9w8k9qr9x3K0c5TnwxREHwgIgdXQx/5WoXsBmtwx8bbYMHy9Qri
ynORqA6KXASgtgN2X75WEWsHhKMhx16ih04e206kvwqZ77pULiktgphSLjkvPvAYDty7Ex9PT+CzP39DOfS
R8KzJZjT/AIjotIKYKS+zBl82nnqKdn05+goRRhbrVe9KzXqq2h5ZgLcffhwhM364lsfhiXH8VFzAxviAS3
Y3gHUroRSu1MpY8usGwq/RI9n014bliUuVZarqsKmYiKIWgDVkfz4bvHfhLD6dmUTd6EgATf4dfSAXfVUHm
Kms2Eo5Q7uy6ash8+1TK0UyIk2vugCaySUnSSOMc0t5pKd/xrdXZ936Vn4seUoRDDOmyssSaFOgR7NpXdfa
myqXYGvcetELwBqyl11jgWzyv1uaw5Hz32OxUWvTZdfZNVOrRTSMMf8CQJx8y406xqd+xbuTOZSGEm0ZrwH
om6LIe20Mzs5O46OJHMZXC4htWI9EzEpYOcmuoaivJEd9yA9DjJzJ4sTc7whuWQ/Pi6QaSbZ3kvuRqdE4Nz
uDt77J4jz52LT5VpAR52270CIVrZHpjQpt/5b7MDqRw+fzF1EZTCCZSIKE+y+067WK7YObsLKwgMJQHPFE0
rWJVgNcU8lWgb1axY2a3UAiDiVwfyvfznbdquTezY736n1v5P7/dt2snmjgJEvPi8hIa+BUdUBW8/914DiM
7pHJwFZz00Zma+x3DH2GOiDgJ2/a0G8fLfo9tggm3bHF4PT1ji1/AZ07OMgavt6KAAAAAElFTkSuQmCC
")
#endregion

#region forms
Add-Type -assembly System.Windows.Forms

$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = "Multi Thread Ping"
$main_form.Width = 1000
$main_form.Height = 800
$main_form.Font = "Arial,16"
$main_form.AutoSize = $false
$main_form.StartPosition = "CenterScreen"
$main_form.ShowIcon = $False
$main_form.FormBorderStyle = "FixedSingle"

$StatusStrip = New-Object System.Windows.Forms.StatusStrip
$Status = New-Object System.Windows.Forms.ToolStripStatusLabel
$main_form.Controls.Add($statusStrip)
$StatusStrip.Items.Add($Status)
$Status.Text = "Github: Lifailon. Telegram: @kup57"

$textbox_network = New-Object System.Windows.Forms.MaskedTextBox
$textbox_network.Mask = "000\." + "000\." + "000\." + "000"
$textbox_network.Location = New-Object System.Drawing.Point(10, 10)
$textbox_network.Size = New-Object System.Drawing.Size(170, 35)
$textbox_network.MultiLine = $True
$main_form.Controls.Add($textbox_network)

$button_ping = New-Object System.Windows.Forms.Button
$button_ping.Text = "   Ping"
$button_ping.Image = $ico_start
$button_ping.ImageAlign = "MiddleLeft" # расположение изображения слева
$button_ping.Location = New-Object System.Drawing.Point(190, 10)
$button_ping.Size = New-Object System.Drawing.Size(100, 32)
$main_form.Controls.Add($button_ping)

$CheckBox_DNS = New-Object System.Windows.Forms.CheckBox
$CheckBox_DNS.Text = "Resolve DNS Name"
$CheckBox_DNS.AutoSize = $true
$CheckBox_DNS.Checked = $false
$CheckBox_DNS.Location = New-Object System.Drawing.Point(300, 14)
$CheckBox_DNS.Font = "Arial,14"
$main_form.Controls.Add($CheckBox_DNS)

$DataGridView = New-Object System.Windows.Forms.DataGridView
$DataGridView.Location = New-Object System.Drawing.Point(10, 50)
$DataGridView.Size = New-Object System.Drawing.Size(970, 680)
$DataGridView.Font = "Arial,11"
$DataGridView.AutoSizeColumnsMode = "Fill" 
$DataGridView.AutoSize = $false
$DataGridView.MultiSelect = $true
$DataGridView.ReadOnly = $true
$DataGridView.TabIndex = 0
$main_form.Controls.Add($DataGridView)
#endregion

#region ping
$button_ping.Add_Click({
        $button_ping.Enabled = $false
        $start_time = Get-Date

        $DataGridView.ColumnCount = $null
        $DataGridView.ColumnCount = 4
        $DataGridView.Columns[0].Name = "IP-Address"
        $DataGridView.Columns[1].Name = "Name"
        $DataGridView.Columns[2].Name = "Status"
        $DataGridView.Columns[3].Name = "Time"

        $network = $textbox_network.text -replace "\s{1,3}"
        $network = $network -replace "\.\d{1,3}$", "."

        foreach ($4 in 1..254) {
            $ip = $network + $4
            $(Start-RSJob { "$using:ip : " + (ping -n 1 -w 50 $using:ip)[2] }) | Out-Null
        }
        $ping_out = Get-RSJob | Receive-RSJob

        foreach ($ping in $ping_out) {
            if ($ping -match "ttl") {
                $row_ip = $ping -replace " : .+", ""
                if ($CheckBox_DNS.Checked -eq $True) {
                    $rdns = ((nslookup $row_ip)[3]) -replace ".{1,20}:\s{1,20}"
                }
                $time = ($ping -replace " TTL=.+", "") -replace ".+(?<==)"
                $DataGridView.Rows.Add("$row_ip", "$rdns", "Available", $time)
                $DataGridView.Rows[-2].Cells[2].Style.BackColor = "lightgreen"
                $on = $on + 1
            }
            else {
                $row_ip = $ping -replace " : .+", ""
                if ($CheckBox_DNS.Checked -eq $True) {
                    $rdns = ((nslookup $row_ip)[3]) -replace ".{1,20}:\s{1,20}"
                }
                $DataGridView.Rows.Add("$row_ip", "$rdns", "Not available", $null)
                $DataGridView.Rows[-2].Cells[2].Style.BackColor = "pink"
                $off = $off + 1
            }
        }

        $end_time = Get-Date
        $run_time = $end_time - $start_time
        $run_min = $run_time.Minutes
        $run_sec = $run_time.Seconds
        $status.Text = "Running time: $run_min minutes $run_sec seconds. Available: $on | Not available: $off"

        Get-RSJob | Remove-RSJob
        $button_ping.Enabled = $true
    })
#endregion

$main_form.ShowDialog()