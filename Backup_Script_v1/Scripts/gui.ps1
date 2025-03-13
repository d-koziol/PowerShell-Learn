Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

. "C:\Kopia\PowershellScripts\PowerShell-Learn\Backup_Script_v1\Scripts\logic.ps1"



$form = New-Object System.Windows.Forms.Form
$form.Text = "Backup Settings"
$form.Size = New-Object System.Drawing.Size(500,400)
$form.StartPosition = "CenterScreen"

$selectBtn = New-Object System.Windows.Forms.Button
$selectBtn.Location = New-Object System.Drawing.Point(110,200)
$selectBtn.Size = New-Object System.Drawing.Size(75,23)
$selectBtn.Text = "Choose file:"
$selectBtn.Font = New-Object System.Drawing.Font("Arial Italic", 9, [System.Drawing.FontStyle]::Italic)
$selectBtn.Add_Click({
    selectBtnFn
})
$form.Controls.Add($selectBtn)

$selectPthBtn = New-Object System.Windows.Forms.Button
$selectPthBtn.Location = New-Object System.Drawing.Point(110,230)
$selectPthBtn.Size = New-Object System.Drawing.Size(100,23)
$selectPthBtn.Text = "Backup location:"
$selectPthBtn.Font = New-Object System.Drawing.Font("Arial Italic", 9, [System.Drawing.FontStyle]::Italic)
$selectPthBtn.Add_Click({
    selectBupPth
})
$form.Controls.Add($selectPthBtn)

$pathLabel = New-Object System.Windows.Forms.Label
$pathLabel.Location = New-Object System.Drawing.Point(200,200)
$pathLabel.Size = New-Object System.Drawing.Size(250,23)
$form.Controls.Add($pathLabel)

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
$exitBtn.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$exitBtn.Font = New-Object System.Drawing.Font("Arial Italic", 9, [System.Drawing.FontStyle]::Italic)
$exitBtn = $exitBtn
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

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($enableCheckbox.Checked) {
       & "C:\Kopia\PowershellScripts\PowerShell-Learn\Backup_Script_v1\Scripts\logic.ps1" -EnableBackup $true
    } else {
       & "C:\Kopia\PowershellScripts\PowerShell-Learn\Backup_Script_v1\Scripts\logic.ps1" -EnableBackup $false
    }
}


