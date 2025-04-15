# AWS Region
aws_region = "eu-west-2"

# VPC Configuration
OT367_vpc_cidr_block = "10.250.0.0/16"

# Subnet CIDR Blocks
OT367_public_subnet_cidrs  = "10.250.1.0/24"
OT367_private_subnet_cidrs = "10.250.10.0/24"

# AWS Profile name 
aws_profile = "Domotz"


# Common Tags
# Common tags for all resources in the module
common_tags = {
  test       = "true"
  jira_issue = "OT-367"
  project    = "SIEM"
  owner      = "Michael Beconcini"
  terraform  = "true"
}

project_name = "OT-367"

# ec2 instance configuration
OT367_ec2_instance_type = "t3.xlarge"


# ebs volume configuration
# Size in GB
ebs_volume_size = 20

# VPC and Networking
# vpc_name = "wazuh-test"
# vpc_cidr             = "10.150.0.0/16"
# public_subnet_cidrs  = ["10.150.5.0/24", "10.150.6.0/24", "10.150.7.0/24"]
# private_subnet_cidrs = ["10.150.8.0/24", "10.150.9.0/24", "10.150.10.0/24"]
# nat_subnet_id        = "a"
# availability_zone = "eu-west-3a"
# subnet_cidr = "10.150.5.0/24"
