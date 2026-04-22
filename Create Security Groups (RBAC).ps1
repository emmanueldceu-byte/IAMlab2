$groups = @(
    "HR_Read",
    "HR_Modify",
    "IT_Admin",
    "Finance_Read",
    "Finance_Modify"
)

foreach ($group in $groups) {
    New-ADGroup `
    -Name $group `
    -GroupScope Global `
    -GroupCategory Security `
    -Path "OU=Groups,DC=corp,DC=local"
}
