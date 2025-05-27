########################################################################################################################
## Common Variables
########################################################################################################################
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

########################################################################################################################
## EC2 Configuration
########################################################################################################################
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}

########################################################################################################################
## Network Configuration
########################################################################################################################
variable "public_subnet_1_id" {
  description = "Public subnet 1 ID (not used currently as EC2 is in private subnet)"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID where EC2 will be launched"
  type        = string
}

########################################################################################################################
## Security Configuration
########################################################################################################################
variable "ssm_instance_profile" {
  description = "SSM instance profile for EC2"
  type = object({
    name = string
    arn  = string
  })
}

variable "sg_allow_ssm" {
  description = "Security group for allowing SSM access"
  type = object({
    id   = string
    name = string
  })
}

variable "elb_sg" {
  description = "Security group for the load balancer (passed but not directly used)"
  type = object({
    id   = string
    name = string
  })
}