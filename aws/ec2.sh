aws ec2 describe-security-groups | jq '.SecurityGroups[].IpPermissions[] | {ip: .IpRanges[], port: .ToPort}'
#proper to do it this way, but filter by specific subnet
#aws ec2 describe-network-acls | jq '.NetworkAcls[] | {associations: .Associations[], entries: .Entries[] | {rule: .RuleAction, port: .PortRange.To, cidr: .CidrBlock}}'
aws ec2 describe-network-acls --filters 'Name=association.subnet-id,Values=subnet-0b3a2d3ffb3c678e6' | jq '.NetworkAcls[].Entries[] | {rule: .RuleAction, port: .PortRange.To, cidr: .CidrBlock}'
