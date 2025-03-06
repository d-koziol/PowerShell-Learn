$userName = $env:USERNAME
$sourcePath = "C:\Users\$($env:USERNAME)\Documents\"
$destinationPath = "C:\Users\$($env:USERNAME)\Backup\"
$logFile = "C:\Users\$($env:USERNAME)\Backup\backup_log.log"

#Script checks Backup folder and creates it if it doesn't exists.
if (!(Test-Path $destinationPath )) {
    New-Item $destinationPath -ItemType Directory
    Write-Output "'Backup' folder has been created succesfully." | Out-File $logFile -Append
} else {
    Write-Output "'Backup'folder already exists." | Out-File $logFile -Append
}

#Script checks Log file and creates it if it doesn't exists.
if (!(Test-Path $logFile)) {
    New-Item $logFile -ItemType File
    Write-Output "'Log' file was created." | Out-File $logFile -Append
} else {
    Write-Output "'Log' file already exists." | Out-File $logFile -Append
}
