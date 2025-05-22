variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}

}
variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the existing VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "OT-367 public subnet cidr"
  type        = list(string)

}

variable "private_subnet_cidrs" {
  description = "OT-367 private subnet cidr"
  type        = list(string)
}

variable "alb_sg" {
  description = "ALB security group ID"
  type        = object({
    id = string
  })
} 

