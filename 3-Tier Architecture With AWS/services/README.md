Tier 3 Architecture With AWS.

Spins up ELB, autoscaling group (spot instances), RDS, and VPC network (NAT GW, 6 subnets - 2 AZs, route tables, network ACLs, IGW, etc).





Changes I need to make:
- Set egress ephemeral ports for SG.
- Remove static entries in modules, make modules reusable.
