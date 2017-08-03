#!/bin/bash
sudo yum install wget -y
pip install awscli --upgrade --user
EC2_INSTANCE_ID=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
aws ec2 monitor-instances --instance-ids $EC2_INSTANCE_ID --region us-west-2
