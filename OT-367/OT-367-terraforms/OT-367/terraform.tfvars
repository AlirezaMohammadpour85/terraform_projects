# AWS Region
aws_region = "eu-west-2"

# VPC Configuration
OT367_vpc_cidr_block = "10.250.0.0/16"

# Subnet CIDR Blocks
OT367_public_subnet_cidrs  = ["10.250.1.0/24", "10.250.2.0/24"]
OT367_private_subnet_cidrs = ["10.250.10.0/24"]

# Private Subnet Availability Zone
OT367_private_subnet_availability_zone = "eu-west-2a"

# AWS Profile name 
aws_profile = "Domotz"


# Common Tags
# Common tags for all resources in the module
common_tags = {
  test       = "true"
  jira_issue = "OT-367"
  project    = "Airbyte"
  owner      = "Michael Beconcini"
  terraform  = "true"
}

project_name = "OT-367"

# ec2 instance configuration
# "t3.xlarge" causes issues with the application
OT367_ec2_instance_type = "t3.2xlarge"
ami_id     = "ami-0757346e231d7ed5a"

# ebs volume configuration
# Size in GB
ebs_volume_size = 20

# acm_certificate_arn 
acm_certificate_arn= "arn:aws:acm:eu-west-2:805719057625:certificate/bca9094c-c295-41d7-a603-0a2ec06568f4"

# elb zone id
OT367_alb_zone_id = "Z3UJBO2M5QHFLY"

# elb zone id


# Variables for existing peer connections -start
existing_peering_connection_ids = ["pcx-0f1cd18cc279208c4", "pcx-0705c8c85d8a1d522", "pcx-0d56e642a01c91195"]
peer_vpc_cidr_blocks = ["172.26.0.0/16", "172.21.0.0/16", "172.22.0.0/21"]

# Variables for existing peer connections -end
