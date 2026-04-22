param(
    [string]$username,
    [int]$minutes = 30
)

$group = "IT_Admin"

Add-ADGroupMember -Identity $group -Members $username

Write-Host "$username added to $group for $minutes minutes"

Start-Sleep ($minutes * 60)

Remove-ADGroupMember -Identity $group -Members $username -Confirm:$false

Write-Host "$username removed from $group"
