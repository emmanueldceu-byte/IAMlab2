Import-Module ActiveDirectory

$users = @(
    [PSCustomObject]@{FirstName="John";LastName="Doe";Department="HR";Username="jdoe";Password="P@ssw0rd123"},
    [PSCustomObject]@{FirstName="Jane";LastName="Smith";Department="IT";Username="jsmith";Password="P@ssw0rd123"},
    [PSCustomObject]@{FirstName="Mike";LastName="Brown";Department="Finance";Username="mbrown";Password="P@ssw0rd123"},
    [PSCustomObject]@{FirstName="Alice";LastName="Johnson";Department="HR";Username="ajohnson";Password="P@ssw0rd123"},
    [PSCustomObject]@{FirstName="David";LastName="Lee";Department="IT";Username="dlee";Password="P@ssw0rd123"}
)

foreach ($user in $users) {

    $ouPath = "OU=$($user.Department),DC=corp,DC=local"
    $securePass = ConvertTo-SecureString $user.Password -AsPlainText -Force

    New-ADUser `
        -Name "$($user.FirstName) $($user.LastName)" `
        -GivenName $user.FirstName `
        -Surname $user.LastName `
        -SamAccountName $user.Username `
        -UserPrincipalName "$($user.Username)@corp.local" `
        -Path $ouPath `
        -AccountPassword $securePass `
        -Enabled $true

    switch ($user.Department) {
        "HR"      { Add-ADGroupMember "HR_Read" $user.Username }
        "IT"      { Add-ADGroupMember "IT_Admin" $user.Username }
        "Finance" { Add-ADGroupMember "Finance_Read" $user.Username }
    }

    Write-Host "Created user: $($user.Username)"
}
