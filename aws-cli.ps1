Invoke-WebRequest -Uri "https://github.com/DXC-DevOps/Ansible/raw/CSCSOE/AWSCLI64.msi" -OutFile "C:\awstemp\AWSCLI64.msi"
write-host "Enabling Monitoring"
EC2_INSTANCE_ID=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
aws ec2 monitor-instances --instance-ids $EC2_INSTANCE_ID --region us-west-2
