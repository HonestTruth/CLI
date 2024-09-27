#!/bin/bash
while true
do
clear
aws ec2 describe-instances \
  --query 'Reservations[*].Instances[*].{Name:Tags[?Key==`Name`]|[0].Value,public:PublicIpAddress,private:PrivateIpAddress,Domain:Tags[?Key==`domain`]|[0].Value,Time:LaunchTime,EBS:EbsOptimized,State:State.Name,ID:InstanceId,VPC:VpcId}' \
--output=table #\
#--filters 'Name=vpc-id,Values=vpc-0648f9eddd5372f96'

sleep 45
done
#now=$(date +"%Y-%m-%dT%T")

#

