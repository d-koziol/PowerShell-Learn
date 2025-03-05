# Definig Variables
$target = "TERMSRV/$($env:USERNAME).domain"
$username = "$($env:USERNAME)@domain"
# Request to enter the user’s password
$password = Read-Host -Prompt "Write yor password here:" -AsSecureString

# Tworzenie obiektu poświadczeń
$credential = New-Object -TypeName PSCredential -ArgumentList $username, (ConvertTo-SecureString $password -AsPlainText -Force)

# Dodawanie poświadczenia rodzajowego do Menedżera poświadczeń
$cmd = "cmdkey /generic:$target /user:$username /pass:$password"
Invoke-Expression $cmd

Write-Output "Poświadczenie rodzajowe zostało dodane dla adresu '$target' z nazwą użytkownika '$username'."
