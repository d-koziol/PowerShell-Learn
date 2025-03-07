$form = New-Object System.Windows.Forms.Form
$form.Text = "Backup Settings"
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = "CenterScreen"

$acceptBtn = New-Object System.Windows.Forms.Button
$acceptBtn.Location = New-Object System.Drawing.Point(100,120)
$acceptBtn.Size = New-Object System.Drawing.Size(75,23)
$acceptBtn.Text = "Accept"
$acceptBtn.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $acceptBtn
$form.Controls.Add($acceptBtn)

$enableCheckbox = New-Object System.Windows.Forms.CheckBox
$enableCheckbox.Text = "Enable daily backup"
$enableCheckbox.Location = New-Object System.Drawing.Point(80,40)
$enableCheckbox.Size = New-Object System.Drawing.Size(200,30)
$form.Controls.Add($enableCheckbox)

$disableCheckbox = New-Object System.Windows.Forms.CheckBox
$disableCheckbox.Text = "Disable daily backup"
$disableCheckbox.Location = New-Object System.Drawing.Point(80,70)
$disableCheckbox.Size = New-Object System.Drawing.Size(200,30)
$form.Controls.Add($disableCheckbox)

$form.TopMost = $true
$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()