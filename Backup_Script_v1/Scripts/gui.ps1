Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function checkBox_CheckedChanged {
    if ($enableCheckbox.Checked) {
        $disableCheckbox.Enabled = $false
    } else {
        $disableCheckbox.Enabled = $true
    }

    if ($disableCheckbox.Checked) {
        $enableCheckbox.Enabled = $false
    } else {
        $enableCheckbox.Enabled = $true
    }
}

$form = New-Object System.Windows.Forms.Form
$form.Text = "Backup Settings"
$form.Size = New-Object System.Drawing.Size(500,400)
$form.StartPosition = "CenterScreen"

$acceptBtn = New-Object System.Windows.Forms.Button
$acceptBtn.Location = New-Object System.Drawing.Point(150,320)
$acceptBtn.Size = New-Object System.Drawing.Size(75,23)
$acceptBtn.Text = "Accept"
$acceptBtn.DialogResult = [System.Windows.Forms.DialogResult]::OK
$acceptBtn.Font = New-Object System.Drawing.Font("Arial Italic", 9, [System.Drawing.FontStyle]::Italic)
$form.AcceptButton = $acceptBtn
$form.Controls.Add($acceptBtn)

$exitBtn = New-Object System.Windows.Forms.Button
$exitBtn.Location = New-Object System.Drawing.Point(250,320)
$exitBtn.Size = New-Object System.Drawing.Size(75,23)
$exitBtn.Text = "Exit"
$exitBtn.DialogResult = [System.Windows.Forms.DialogResult]::OK
$exitBtn.Font = New-Object System.Drawing.Font("Arial Italic", 9, [System.Drawing.FontStyle]::Italic)
$exitBtn.Add_Click({
    $form.Close()
})
$form.Controls.Add($exitBtn)

$enableCheckbox = New-Object System.Windows.Forms.CheckBox
$enableCheckbox.Text = "Enable daily backup"
$enableCheckbox.Location = New-Object System.Drawing.Point(80,40)
$enableCheckbox.Size = New-Object System.Drawing.Size(200,30)
$enableCheckbox.Add_CheckedChanged({checkBox_CheckedChanged})
$form.Controls.Add($enableCheckbox)

$disableCheckbox = New-Object System.Windows.Forms.CheckBox
$disableCheckbox.Text = "Disable daily backup"
$disableCheckbox.Location = New-Object System.Drawing.Point(280,40)
$disableCheckbox.Size = New-Object System.Drawing.Size(200,30)
$disableCheckbox.Add_CheckedChanged({checkBox_CheckedChanged})
$form.Controls.Add($disableCheckbox)

$form.TopMost = $true
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK){
    if ($enableCheckbox.Checked) {
       & "C:\Kopia\PowershellScripts\PowerShell-Learn\Backup_Script_v1\Scripts\logic.ps1" -EnableBackup $true
    } else {
       & "C:\Kopia\PowershellScripts\PowerShell-Learn\Backup_Script_v1\Scripts\logic.ps1" -EnableBackup $false
    }
}

function Show-OpenFileDialog {
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.InitialDirectory = [System.Environment]::GetFolderPath('Desktop')
    $OpenFileDialog.Filter = "Wszystkie pliki(*.*)|*.*"
    $OpenFileDialog.Multiselect = $false
    $DialogResult= $OpenFileDialog.ShowDialog()
    if ($DialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
        return $OpenFileDialog.FileName
    } else {
        return $null
    }
}

$SelectedFile = Show-OpenFileDialog
if ($SelectedFile) {
    Write-Output "Wybrany plik: $SelectedFile"
    $BackupLocation = Show-FolderBrowserDialog
    if ($BackupLocation) {
        Write-Output "Miejsce docelowe dla kopii zapasowej: $BackupLocation"
        "C:\Kopia\PowershellScripts\PowerShell-Learn\Backup_Script_v1\Scripts\logic.ps1" -Source $SelectedFile -Destination $BackupLocation
    } else {
        Write-Output "Nie wybrano miejca docelowego"
    }
}