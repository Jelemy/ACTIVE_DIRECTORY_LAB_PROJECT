#automates the creation of Active Directory user accounts for the KITAUJI_BAND organizational unit
$PASSWORD_FOR_USERS   = "kITAUJIF1GHT"
$USER_FIRST_LAST_LIST = Get-Content .\names.txt


$password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force
New-ADOrganizationalUnit -Name KITAUJI_BAND -ProtectedFromAccidentalDeletion $false

foreach ($n in $USER_FIRST_LAST_LIST) {
    $first = $n.Split(" ")[0].ToLower()
    $last = $n.Split(" ")[1].ToLower()
    $username = "$($first.Substring(0,1))$($last)".ToLower()
    Write-Host "Creating user: $($username)" -BackgroundColor Black -ForegroundColor Cyan
    
    New-AdUser -AccountPassword $password `
               -GivenName $first `
               -Surname $last `
               -DisplayName $username `
               -Name $username `
               -EmployeeID $username `
               -PasswordNeverExpires $true `
               -Path "ou=KITAUJI_BAND,$(([ADSI]`"").distinguishedName)" `
               -Enabled $true
}