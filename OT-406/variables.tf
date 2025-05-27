########################################################################################################################
## aws credentials profile info
########################################################################################################################
variable "aws_region" {
  description = "AWS region for resource deployment"
  type        = string
}

variable "shared_credentials_files" {
  description = "Path to shared credentials file"
  type        = string
  default     = "~/.aws/credentials"
}

variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
}

########################################################################################################################
## Common Tags 
########################################################################################################################
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

########################################################################################################################
## project variables 
########################################################################################################################
variable "project_name" {
  description = "Project name"
  type        = string
}

########################################################################################################################
## vpc & network
########################################################################################################################
variable "vpc_cidr_block" {
  description = "VPC cidr block"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public subnet cidrs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet cidrs"
  type        = list(string)
}

variable "private_subnet_availability_zone" {
  description = "Private subnet availability zone"
  type        = string
}

########################################################################################################################
## ec2 instance
########################################################################################################################
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}

########################################################################################################################
## s3
########################################################################################################################
variable "s3_bucket_name" {
  description = "Name of the S3 bucket for EC2 instance access"
  type        = string
  default     = "ubuntu-core-secrets"
}