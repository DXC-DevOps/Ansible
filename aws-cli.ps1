New-Item -Path c:\awstemp -ItemType directory
Invoke-WebRequest -Uri "https://github.com/DXC-DevOps/Ansible/raw/CSCSOE/AWSCLI64.msi" -OutFile "C:\awstemp\AWSCLI64.msi"


