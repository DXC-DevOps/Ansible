New-Item -Path c:\awstemp -ItemType directory
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
restart-service AmazonSSMAgent
