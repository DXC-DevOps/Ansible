write-host "Enabling Monitoring"
$webclient = new-object net.webclient
$instanceid = $webclient.Downloadstring('http://169.254.169.254/latest/meta-data/instance-id')
aws ec2 monitor-instances --instance-ids $instanceid --region us-west-2
