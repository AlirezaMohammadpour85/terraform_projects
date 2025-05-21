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

#elb - start
variable "OT367_alb_zone_id" {
  description = "OT-367 alb Zone id"
  type        = string
}
#elb - end


# ecs - start
variable "ecs_cluster_name" {
  description = "name of the ecs cluster"
  type        = string
}
# ecs - end

# ecr - start
variable "ecr_repo_name" {
  description = "The name of the ECR repository."
  type        = string
}
# ecr - end

# n8n image-container name - start
variable "app_image_name" {
  description = "The name of the n8n app."
  type        = string
}
variable "app_container_name" {
  description = "The name of the n8n app container."
  type        = string
}
variable "app_port" {
  description = "The port of the n8n app."
  type        = number
}
# n8n image-container name - end


# vpc - start
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "zuru_vpc_cidr" {
  description = "zuru vpc cidr block"
  default     = "-1"
}
variable "ecr_repo_name" {
  description = "The name of the ECR repository."
  default     = "zuru_ecr_repo"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "go_api_image_name" {
  description = "api image name"
}

variable "nginx_proxy_image_name" {
  description = "nginx proxy image name"
}

variable "ecs_cluster_name" {
  description = "name of the ecs cluster"
  type        = string

}
