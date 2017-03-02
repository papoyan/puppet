#!/bin/bash

#delete existing policy
as-update-auto-scaling-group web_group --min-size 0 --max-size 0
as-delete-policy scale-down --auto-scaling-group web_group -f
as-delete-policy scale-up --auto-scaling-group web_group -f
as-delete-auto-scaling-group web_group -d -f
sleep 5
as-delete-launch-config web_launch -f



# create new policy

as-create-launch-config web_launch --region us-west-2 --image-id ami-546bf064 --instance-type m1.medium --key master-vaac --group WEB

STATUS=`as-describe-auto-scaling-groups  |head -1| awk {'print $2'}`
while [ $STATUS = 'web_group' ]; do
      echo "the group still exists"
      sleep 5;
      STATUS=`as-describe-auto-scaling-groups  |head -1| awk {'print $2'}`
      done;
 
as-create-auto-scaling-group web_group --launch-configuration web_launch --availability-zones us-west-2a --min-size 2 --max-size 10 --load-balancers web-public --health-check-type ELB --grace-period 300 --tag 'k=role, v=web, p=true'

as-put-scaling-policy --auto-scaling-group web_group --name scale-up --adjustment 1 --type ChangeInCapacity --cooldown 300

as-put-scaling-policy --auto-scaling-group web_group --name scale-down "--adjustment=-1" --type ChangeInCapacity --cooldown 300




