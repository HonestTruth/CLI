#!/bin/bash

##### WORK IN PROGRESS


#cd /home/mkaelber/ec2
#aws ec2 describe-vpcs --output json > vpcs.json
#aws ec2 describe-security-groups --output json > securitygroups.json
#aws ec2 describe-route-tables --output json > routetables.json
#aws ec2 describe-network-acls --output json > acls.json
#aws ec2 describe-subnets --output json > subnets.json
#aws ec2 describe-instances --output json > instances.json
function aws-describe-object-json( ) { 
}
subnetsWithRoutes=()
subnetsVpcs=()
vpcsInstances=()

#[x1][y1] #x1 can have many y1
#[x2][y2] # where instance of y1=x2 and can have many y2

#begin  psuedo bash loops logic
iterator=1
x=0
y=0
for rt in $(more /home/mkaelber/ec2/routetables.json | jq '.RouteTables[]|.RouteTableId,.Associations[].SubnetId')
do
  if ! (( $iterator % 2 )); #evens
  then
    if [[ $rt == *"subnet"*  ]];
    then
      noQuotes="${rt%\"}"
      noQuotes="${noQuotes#\"}"
      subnetsWithRoutes[$x]=${noQuotes}
      #echo $iterator
      #echo -e "DEBUG:\t${rt}"
      let "x+=1"
    fi
  fi
  let "iterator+=1"
done
iterator=1
x=0

for subnet in "${subnetsWithRoutes[@]}"
do
#select(.VpcId=="vpc-0648f9eddd5372f96")' 
#for vpc in $(more /home/mkaelber/ec2/vpcs.json | jq '.Vpcs[]|.VpcId,.CidrBlock,.Tags[].Value|select(.Key=="Name")') #.Tags[] CidrBlockAssociationSet[].AssociationId') 
for vpc in $(more /home/mkaelber/ec2/vpcs.json | jq '.Vpcs[]|.VpcId,.CidrBlock,.Tags[].Value')
  do
    echo $vpc
  done
done


for subnet in "${subnetsWithRoutes[@]}"
do
  echo $subnet
done 
  #only iterate through subnets that have a route table
#foreach subnet
  #foreach vpc
    #foreach instance


#more /home/mkaelber/ec2/routetables.json | jq '.RouteTables[]|.RouteTableId,.Associations[].SubnetId'
#more /home/mkaelber/ec2/vpcs.json | jq '.Vpcs[]|.Tags[],.VpcId'
#more /home/mkaelber/ec2/instances.json | jq '.Reservations[].Instances[]|.InstanceId,.VpcId'
##dev.forge (forge10)
#more /home/mkaelber/ec2/vpcs.json | jq '.Vpcs[] | select(.VpcId=="vpc-0648f9eddd5372f96")'
