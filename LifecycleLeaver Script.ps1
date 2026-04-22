param([string]$username)

Import-Module ActiveDirectory

Disable-ADAccount -Identity $username

# Remove from all groups
Get-ADPrincipalGroupMembership $username | ForEach-Object {
    Remove-ADGroupMember -Identity $_ -Members $username -Confirm:$false
}

# Move to Disabled OU
New-ADOrganizationalUnit -Name "DisabledUsers" -Path "DC=corp,DC=local" -ErrorAction SilentlyContinue

Move-ADObject `
-Identity (Get-ADUser $username).DistinguishedName `
-TargetPath "OU=DisabledUsers,DC=corp,DC=local"
