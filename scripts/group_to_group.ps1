# adds all members from one security group to another security group
$SourceGroup = "Section_Leaders"

$TargetGroup = "Resources_ReadWrite"

$Members = Get-ADGroupMember -Identity $SourceGroup -Recursive | Where-Object { $_.objectClass -eq "user" }

foreach ($User in $Members) {
    Add-ADGroupMember -Identity $TargetGroup -Members $User.SamAccountName -ErrorAction SilentlyContinue
}