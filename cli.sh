#!/bin/bash
sudo yum install wget -y
sudo wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py --user
pip install awscli --upgrade --user
EC2_INSTANCE_ID=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
aws ec2 monitor-instances --instance-ids $EC2_INSTANCE_ID --region us-west-2
