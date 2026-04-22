New-Item -ItemType Directory -Path "C:\Shares\HR"
New-Item -ItemType Directory -Path "C:\Shares\Finance"

New-SmbShare -Name "HR" -Path "C:\Shares\HR"
New-SmbShare -Name "Finance" -Path "C:\Shares\Finance"
