########################################################################################################################
## Common Variables
########################################################################################################################
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

########################################################################################################################
## VPC Configuration
########################################################################################################################
# CIDR block for VPC creation - only required when creating a new VPC
# This variable is ignored when existing_vpc_id is provided
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC (required if creating new VPC, ignored if using existing VPC)"
  type        = string
  default     = ""
}

# Existing VPC ID - when provided, the module will use this VPC instead of creating a new one
# Default is empty string (""), which triggers new VPC creation
variable "existing_vpc_id" {
  description = "Existing VPC ID to use. Leave empty to create a new VPC"
  type        = string
  default     = ""  # Empty string as default means "create new VPC" mode
}

########################################################################################################################
## Subnet Configuration
########################################################################################################################
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  
  validation {
    condition     = length(var.public_subnet_cidrs) >= 2
    error_message = "At least 2 public subnets are required for NAT Gateway high availability."
  }
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  
  validation {
    condition     = length(var.private_subnet_cidrs) >= 1
    error_message = "At least 1 private subnet is required."
  }
}

variable "private_subnet_availability_zone" {
  description = "Availability zone for the private subnet"
  type        = string
  
}

########################################################################################################################
## Module Dependencies - REMOVED
########################################################################################################################
# The ec2_instance_info variable has been removed to eliminate circular dependency
# The network module should not depend on resources it provides infrastructure for
# 
# Previously this created a circular dependency:
# - Network module required EC2 instance info
# - EC2 module required network resources (subnets)
# This made the modules impossible to deploy