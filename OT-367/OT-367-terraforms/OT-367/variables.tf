# aws credentials profile info -start
variable "aws_region" {
  description = "Value of the Name tag for the EC2 instance"
}
variable "shared_credentials_files" {
  description = "Path to shared credentials file"
  default     = "~/.aws/credentials"
}
variable "aws_profile" {
  description = "Value of the Name tag for the EC2 instance"
}
# aws credentials profile info -end

# Common Tags - start
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

# Common Tags - end

# project name - start
variable "project_name" {
  description = "Project name"
  type        = string
}
# project name - end

# vpc & network - start
variable "OT367_public_subnet_cidrs" {
  description = "OT-367 public subnet cidr"
  type        = list(string)
}

variable "OT367_private_subnet_cidrs" {
  description = "OT-367 private subnet cidr"
  type        = list(string)
}
variable "OT367_vpc_cidr_block" {
  description = "OT-367 vpc cidr block"
}
variable "OT367_private_subnet_availability_zone" {
  description = "OT-367 private subnet availability zone"
  type        = string
}

# vpc & network  - end

# ebs - start
variable "ebs_volume_size" {
  description = "EBS volume size in GB"
  type        = number
  
  validation {
    condition     = floor(var.ebs_volume_size) == var.ebs_volume_size
    error_message = "The ebs_volume_size must be an integer (whole number)."
  }
  
  validation {
    condition     = var.ebs_volume_size >= 1
    error_message = "EBS GP3 volumes must be at least 1 GB in size."
  }
}
# ebs - end


# ec2 instance - start
variable "OT367_ec2_instance_type" {
  description = "OT-367 ec2 instance type"
}
variable "ami_id" {
  description = "AMI ID created from the EC2 instance snapshot (2025/05/02) including all required dependencies installed"
  type        = string
}
variable "acm_certificate_arn" {
  description = "The ARN of the existing ACM certificate"
  type        = string
}

# ec2 instance - end

#elb - start
variable "OT367_alb_zone_id" {
  description = "OT-367 alb Zone id"
  type        = string
}
#elb - end

# Variables for existing peer connections -start
variable "existing_peering_connection_ids" {
  description = "IDs of existing VPC peering connections"
  type        = list(string)
  default     = []
}

variable "peer_vpc_cidr_blocks" {
  description = "CIDR blocks of the peer VPCs"
  type        = list(string)
  default     = []
}
# Variables for existing peer connections -start
