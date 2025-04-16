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
# vpc & network  - end

# ebs - start
variable "ebs_volume_size" {
  description = "EBS volume size"
}
# ebs - end


# ec2 instance - start
variable "OT367_ec2_instance_type" {
  description = "OT-367 ec2 instance type"
}

variable "acm_certificate_arn" {
  description = "The ARN of the existing ACM certificate"
  type        = string
}

# security group - start


