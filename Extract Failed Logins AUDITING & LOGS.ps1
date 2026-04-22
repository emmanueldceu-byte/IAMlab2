Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4625
} | Select-Object TimeCreated, Message -First 20
