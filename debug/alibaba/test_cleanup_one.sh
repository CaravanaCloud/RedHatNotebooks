#!/bin/bash

REGION="$1"
PREFIX="alij-"

# Ensure the Alibaba Cloud CLI is installed and configured
if ! command -v aliyun &> /dev/null; then
  echo "Error: Alibaba Cloud CLI not found. Please install and configure it."
  exit 1
fi

# Get the list of ECS instances with the given prefix and delete them
instances=$(aliyun ecs DescribeInstances --RegionId "$REGION" | jq -r ".Instances.Instance[] | select(.InstanceName | startswith(\"$PREFIX\")) | .InstanceId")
echo "Found $(echo "$instances" | wc -l) instances matching the prefix."
for instance in $instances; do
  echo "Deleting instance: $instance"
  aliyun ecs DeleteInstance --InstanceId "$instance" --RegionId "$REGION" --Force true
done

# Get the list of Elastic IP addresses with the given prefix and release them
eip_addresses=$(aliyun ecs DescribeEipAddresses --RegionId "$REGION" | jq -r ".EipAddresses.EipAddress[] | select(.Name | startswith(\"$PREFIX\")) | .AllocationId")
echo "Found $(echo "$eip_addresses" | wc -l) Elastic IPs matching the prefix."
for eip_id in $eip_addresses; do
  echo "Deleting Elastic IP: $eip_id"
  aliyun ecs ReleaseEipAddress --AllocationId "$eip_id" --RegionId "$REGION"
done

# Get the list of Security Groups with the given prefix and delete them
security_groups=$(aliyun ecs DescribeSecurityGroups --RegionId "$REGION" | jq -r ".SecurityGroups.SecurityGroup[] | select(.SecurityGroupName | startswith(\"$PREFIX\")) | .SecurityGroupId")
echo "Found $(echo "$security_groups" | wc -l) Security Groups matching the prefix."
for sg_id in $security_groups; do
  echo "Deleting Security Group: $sg_id"
  aliyun ecs DeleteSecurityGroup --SecurityGroupId "$sg_id" --RegionId "$REGION"
done

# Get the list of VSwitches with the given prefix and delete them
vswitches=$(aliyun vpc DescribeVSwitches --RegionId "$REGION" | jq -r ".VSwitches.VSwitch[] | select(.VSwitchName | startswith(\"$PREFIX\")) | .VSwitchId")
echo "Found $(echo "$vswitches" | wc -l) VSwitches matching the prefix."
for vswitch_id in $vswitches; do
  echo "Deleting VSwitch: $vswitch_id"
  aliyun vpc DeleteVSwitch --VSwitchId "$vswitch_id" --RegionId "$REGION"
done

# Get the list of VPCs with the given prefix and delete them
vpcs=$(aliyun vpc DescribeVpcs --RegionId "$REGION" | jq -r ".Vpcs.Vpc[] | select(.VpcName | startswith(\"$PREFIX\")) | .VpcId")
echo "Found $(echo "$vpcs" | wc -l) VPCs matching the prefix."
for vpc_id in $vpcs; do
  echo "Deleting VPC: $vpc_id"
  aliyun vpc DeleteVpc --VpcId "$vpc_id" --RegionId "$REGION"
done
