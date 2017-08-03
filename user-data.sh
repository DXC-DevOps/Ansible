#!/bin/bash
curl https://s3.amazonaws.com//aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
curl https://s3.amazonaws.com//aws-cloudwatch/downloads/latest/AgentDependencies.tar.gz -O
tar xvf AgentDependencies.tar.gz -C /tmp/
sudo python ./awslogs-agent-setup.py -n -r us-west-2 -c s3://test-log-rarchivelogsbucket-vff02p5x5izl/my-config-file
echo "Enabling monitoring for instance"
EC2_INSTANCE_ID="`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`"
pip install awscli --upgrade --user
aws ec2 monitor-instances --instance-ids $EC2_INSTANCE_ID --region us-west-2
