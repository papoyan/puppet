#!/bin/bash

REGION='us-west-2'
AMI='ami-444dd674'
INSTANCE_SIZE='m1.medium'
SEC_GROUP='WEB'
KEY='master-vaac'




as-create-launch-config web_launch --region $REGION --image-id $AMI --instance-type $INSTANCE_SIZE --key $KEY --group $SEC_GROUP

as-create-auto-scaling-group web_group --launch-configuration web_launch --availability-zones $REGION --min-size 2 --max-size 10 --load-balancers web-public --health-check-type ELB --grace-period 300 --tag "k=role, v=web, p=true”

as-put-scaling-policy --auto-scaling-group web_group --name scale-up --adjustment 1 --type ChangeInCapacity --cooldown 300

as-put-scaling-policy --auto-scaling-group web_group --name scale-down "--adjustment=-1" --type ChangeInCapacity --cooldown 300


