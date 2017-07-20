New-Item -Path c:\testing -ItemType directory
write-host "Installing and Enabling SSM agent"
Invoke-WebRequest -Uri "https://s3.amazonaws.com/ec2-downloads-windows/EC2Config/EC2Install.zip" -OutFile "C:\Temp\EC2Install.zip"
$BackUpPath = "C:\Temp\EC2Install.zip"
$Destination = "C:\Temp"
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($BackUpPath, $destination)
cd c:\Temp
$ssminstall=.\Ec2Install.exe /quiet /norestart

$EC2SettingsFile="C:\Program Files\Amazon\Ec2ConfigService\Settings\Config.xml"
$xml = [xml](get-content $EC2SettingsFile)
$xmlElement = $xml.get_DocumentElement()
$xmlElementToModify = $xmlElement.Plugins

foreach ($element in $xmlElementToModify.Plugin)
{
    if ($element.name -eq "AWS.EC2.Windows.CloudWatch.PlugIn")
    {
        $element.State="Enabled"
    }
}
$xml.Save($EC2SettingsFile)
