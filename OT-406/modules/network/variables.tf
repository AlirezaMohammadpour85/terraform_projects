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
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

########################################################################################################################
## Subnet Configuration
########################################################################################################################
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  
  validation {
    condition     = length(var.public_subnet_cidrs) >= 2
    error_message = "At least 2 public subnets are required for NAT Gateway availability."
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
## Module Dependencies
########################################################################################################################
variable "ec2_instance_info" {
  description = "EC2 instance information from EC2 module"
  type = object({
    id                = string
    public_ip         = string
    private_ip        = string
    availability_zone = string
  })
}