# adds all users in an OU to a Security Group
$OU = "OU=Users,OU=KITAUJI_BAND,$(([ADSI]'').distinguishedName)"
$Group = "Resources_ReadOnly"

$Users = Get-ADUser -SearchBase $OU -Filter *

foreach ($u in $Users) {
    Add-ADGroupMember -Identity $Group -Members $u.SamAccountName
}