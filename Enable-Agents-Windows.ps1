New-Item -Path c:\awstemp -ItemType directory
Invoke-WebRequest -Uri "https://github.com/bhagyagunasekar/Ansible/raw/master/WindowsSensor_5121_NGAV_INCLUDED.exe" -OutFile "C:\awstemp\WindowsSensor_5121_NGAV_INCLUDED.exe"
cd c:\awstemp
$installer=.\WindowsSensor_5121_NGAV_INCLUDED.exe /install /quiet /norestart CID="35C43E7262224DFB9AA9F142596987E5-E7"
write-host "Installing and Enabling SSM agent"
Invoke-WebRequest -Uri "https://s3.amazonaws.com/ec2-downloads-windows/EC2Config/EC2Install.zip" -OutFile "C:\awstemp\EC2Install.zip"
$BackUpPath = "C:\awstemp\EC2Install.zip"
$Destination = "C:\awstemp"
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($BackUpPath, $destination)
cd c:\awstemp
$ssminstall=.\Ec2Install.exe /quiet /norestart

$EC2SettingsFile="C:\Program Files\Amazon\Ec2ConfigService\Settings\config.xml"
$xml = [xml](get-content $EC2SettingsFile)
$xmlElement = $xml.get_DocumentElement()
$xmlElementToModify = $xmlElement.Plugins

foreach ($element in $xmlElementToModify.Plugin)
{
    if ($element.name -eq "Ec2HandleUserData")
    {
        $element.State="Enabled"
    }
    if ($element.name -eq "AWS.EC2.Windows.CloudWatch.PlugIn")
    {
        $element.State="Enabled"
    }
}
$xml.Save($EC2SettingsFile)
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
    restart-service AmazonSSMAgent
