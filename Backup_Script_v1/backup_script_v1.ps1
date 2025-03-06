$userName = $env:USERNAME
$sourcePath = "C:\Users\$($env:USERNAME)\Documents\"
$destinationPath = "C:\Users\$($env:USERNAME)\Backup\"
$logFile = "C:\Users\$($env:USERNAME)\Backup\backup_log.log"

function Write-log {
    param (
        [string]$message
    )
    $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timeStamp - $message"
    Write-Output $logMessage | Out-File $logFile -Append
}

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
