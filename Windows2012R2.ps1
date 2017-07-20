New-Item -Path c:\testing -ItemType directory
Invoke-WebRequest -Uri "https://github.com/bhagyagunasekar/Ansible/raw/master/WindowsSensor_5121_NGAV_INCLUDED.exe" -OutFile "C:\temp\WindowsSensor_5121_NGAV_INCLUDED.exe"
cd c:\Temp
$installer=.\WindowsSensor_5121_NGAV_INCLUDED.exe /install /quiet /norestart CID="35C43E7262224DFB9AA9F142596987E5-E7"
write-host "Installing and Enabling SSM agent"
Invoke-WebRequest -Uri "https://s3.amazonaws.com/ec2-downloads-windows/EC2Config/EC2Install.zip" -OutFile "C:\Temp\EC2Install.zip"
$BackUpPath = "C:\Temp\EC2Install.zip"
$Destination = "C:\Temp"
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($BackUpPath, $destination)
cd c:\Temp
$ssminstall=.\Ec2Install.exe /quiet /norestart
