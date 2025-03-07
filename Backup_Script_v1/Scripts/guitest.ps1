$form = New-Object System.Windows.Forms.Form
$form.Text = "Backup Settings"
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = "CenterScreen"

$enableBtn = New-Object System.Windows.Forms.Button
$enableBtn.Location = New-Object System.Drawing.Point(75,120)
$enableBtn.Size = New-Object System.Drawing.Size(75,23)
$enableBtn.Text = "Enable"
$enableBtn.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $enableBtn
$form.Controls.Add($enableBtn)

