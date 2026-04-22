Import-Module ActiveDirectory

$OUs = @(
    "OU=Users,DC=corp,DC=local",
    "OU=HR,OU=Users,DC=corp,DC=local",
    "OU=IT,OU=Users,DC=corp,DC=local",
    "OU=Finance,OU=Users,DC=corp,DC=local",
    "OU=Groups,DC=corp,DC=local"
)

foreach ($ou in $OUs) {
    New-ADOrganizationalUnit -Name ($ou.Split(',')[0].Split('=')[1]) -Path ($ou.Substring($ou.IndexOf(',')+1)) -ErrorAction SilentlyContinue
}
