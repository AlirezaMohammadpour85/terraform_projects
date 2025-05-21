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

# Common tags for all resources in the module
common_tags = {
  test       = "true"
  jira_issue = "OT-367"
  project    = "n8n"
  owner      = "Domenico"
  terraform  = "true"
}

project_name = "n8n"


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

# ecr - start
ecr_repo_name = "domotz-n8n"
# ecr - end

# ecs - start
ecs_cluster_name = "domotz-n8n"
# ecs - end




