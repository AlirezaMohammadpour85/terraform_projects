########################################################################################################################
## AWS Configuration
########################################################################################################################
aws_region  = "eu-west-2"
aws_profile = "Domotz"

########################################################################################################################
## Project Configuration
########################################################################################################################
project_name = "OT-406"

common_tags = {
  test       = "true"
  jira_issue = "OT-406"
  project    = "NEC"
  owner      = "Iacopo Papalini"
  terraform  = "true"
}

########################################################################################################################
## Network Configuration - CHOOSE ONE OPTION
########################################################################################################################

# OPTION 1: Create a NEW VPC
# Uncomment these lines if you want to create a new VPC
# vpc_cidr_block = "10.251.0.0/16"
# existing_vpc_id = ""  # Empty string means "create new VPC"

# OPTION 2: Use an EXISTING VPC
# Using existing VPC from OT-367
vpc_cidr_block = ""  # Not needed when using existing VPC
existing_vpc_id = "vpc-0f7f6a2b57d4959dc"  # Using existing VPC from OT-367

########################################################################################################################
## Subnet Configuration
########################################################################################################################
# Subnet CIDR Blocks - Make sure these don't conflict with existing subnets if using existing VPC
public_subnet_cidrs  = ["10.251.11.0/24", "10.251.12.0/24"]
private_subnet_cidrs = ["10.251.20.0/24"]

# Private Subnet Availability Zone
private_subnet_availability_zone = "eu-west-2a"

########################################################################################################################
## EC2 Configuration
########################################################################################################################
# c5a.4xlarge: 16 vCPUs, 32 GB RAM, AMD EPYC processors
ec2_instance_type = "c5a.4xlarge"

########################################################################################################################
## S3 Configuration
########################################################################################################################
# S3 bucket name for EC2 instance access
s3_bucket_name = "ubuntu-core-secrets"