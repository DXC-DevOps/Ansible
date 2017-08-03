#!/bin/bash
sudo yum install wget -y
sudo wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py --user
EC2_INSTANCE_ID=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
