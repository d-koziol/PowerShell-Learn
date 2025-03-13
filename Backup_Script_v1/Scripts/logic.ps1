param (
    [bool]$EnableBackup
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


$userName = $env:USERNAME
$sourcePath = "C:\Users\$($env:USERNAME)\Documents\"
$destinationPath = "C:\Users\$($env:USERNAME)\Backup\"
$logFile = "C:\Kopia\PowershellScripts\PowerShell-Learn\Backup_Script_v1\Logs\backup_log.log"

function Write-log {
    param (
        [string]$message
    )
    $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timeStamp - $message"
    Write-Output $logMessage | Out-File $logFile -Append
}

if ($EnableBackup) {
    Write-Output "Daily backup enabled."

    #Script checks Backup folder and creates it if it doesn't exists.
    if (!(Test-Path $destinationPath )) {
        New-Item $destinationPath -ItemType Directory
        Write-log "'Backup' folder has been created successfully." 
    } else {
        Write-log "'Backup' folder already exists." 
    }

    #Script checks Log file and creates it if it doesn't exists.
    if (!(Test-Path $logFile)) {
        New-Item $logFile -ItemType File
        Write-log "'Log' file was created successfully." 
    } else {
        Write-log "'Log' file already exists." 
    }

    # Script checks and counts files and copies them if they exist.
    if (Test-Path $sourcePath) {
        $files = Get-ChildItem -Path $sourcePath -File
        $filesCount = ($files | Measure-Object). Count
        if ($files.Count -gt 0) {
            foreach ($file in $files) {
                $destFile = Join-Path $destinationPath $file.Name
                if (!(Test-Path $destFile) -or ($file.LastWriteTime -gt (Get-Item $destFile).LastWriteTime)){
                    Copy-Item -Path $file.FullName -Destination $destinationPath -Recurse
                    Write-log "Copied file: $($file.Name) from '$sourcePath' to '$destinationPath'."
                }
            } 
            Write-log "Total files copied: $filesCount"
        } else {
            Write-log "There is nothing to backup."
        }
    } else {
        Write-log "Source path '$sourcePath' does not exist."
    }
} else {
    Write-Output "Daily backup disabled."
}

function selectBtnFn {
    $SelectedFile = Show-OpenFileDialog
    if ($SelectedFile) {
        $pathLabel.Text = "Chosen file: $SelectedFile"
    } else {
        Write-Output "Nie wybrano żadnego pliku."
    }
}

function selectBupPth {
    $BackupLocation = Show-FolderBrowserDialog
    if ($BackupLocation) {
        $pathLabel.Text = "Chosen backup path: $BackupLocation"
    } else {
        Write-Output "Nie wybrano miejsca docelowego."
    }
    
}

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

function Show-OpenFileDialog {
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.InitialDirectory = [System.Environment]::GetFolderPath('Desktop')
    $OpenFileDialog.Filter = "Wszystkie pliki (*.*)|*.*"
    $OpenFileDialog.Multiselect = $false
    $DialogResult = $OpenFileDialog.ShowDialog()
    if ($DialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
        return $OpenFileDialog.FileName
    } else {
        return $null
    }
}

function Show-FolderBrowserDialog {
    $FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $FolderBrowserDialog.Description = "Wybierz miejsce docelowe kopii zapasowej"
    $FolderBrowserDialog.ShowNewFolderButton = $true
    $DialogResult = $FolderBrowserDialog.ShowDialog()
    if ($DialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
        return $FolderBrowserDialog.SelectedPath
    } else {
        return $null
    }
}
