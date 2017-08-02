Invoke-WebRequest -Uri "https://github.com/DXC-DevOps/Ansible/raw/CSCSOE/AWSCLI64.msi" -OutFile "C:\awstemp\AWSCLI64.msi"
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.5.4/python-3.5.4rc1.exe" -OutFile "C:\awstemp\python-3.5.4rc1.exe"
$pythoninstaller=.\python-3.5.4rc1.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
