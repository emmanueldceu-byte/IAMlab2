param(
    [string]$username,
    [string]$newDepartment
)

Import-Module ActiveDirectory

$user = Get-ADUser $username

# Remove old group memberships
Get-ADPrincipalGroupMembership $user | Where-Object {
    $_.Name -like "*Read" -or $_.Name -like "*Modify"
} | ForEach-Object {
    Remove-ADGroupMember -Identity $_ -Members $user -Confirm:$false
}

# Move to new OU
$newOU = "OU=$newDepartment,OU=Users,DC=corp,DC=local"
Move-ADObject -Identity $user.DistinguishedName -TargetPath $newOU

# Assign new group
switch ($newDepartment) {
    "HR" { Add-ADGroupMember "HR_Read" $username }
    "IT" { Add-ADGroupMember "IT_Admin" $username }
    "Finance" { Add-ADGroupMember "Finance_Read" $username }
}
