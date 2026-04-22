$hrPath = "C:\Shares\HR"
$financePath = "C:\Shares\Finance"

icacls $hrPath /grant "CORP\HR_Read:(RX)"
icacls $hrPath /grant "CORP\HR_Modify:(M)"

icacls $financePath /grant "CORP\Finance_Read:(RX)"
icacls $financePath /grant "CORP\Finance_Modify:(M)"
