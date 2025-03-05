# Definig Variables
$target = "TERMSRV/$($env:USERNAME).domain"
$username = "$($env:USERNAME)@domain"
# Request to enter the user’s password
$password = Read-Host -Prompt "Write yor password here:" -AsSecureString

# Creating Credential Object
$credential = New-Object -TypeName PSCredential -ArgumentList $username, (ConvertTo-SecureString $password -AsPlainText -Force)

# Adding Generic Credentials in Credential Menager
$cmd = "cmdkey /generic:$target /user:$username /pass:$password"
Invoke-Expression $cmd

Write-Output "A Generic Credential has been added for the address ‘$target’ with the username ‘$username’.."
