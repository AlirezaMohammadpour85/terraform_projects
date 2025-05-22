########################################################################################################################
## aws credentials profile info
########################################################################################################################
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

variable "environment" {
  description = "Environment for deployment (like test,dev or staging)"
  default     = "test"
  type        = string
}

########################################################################################################################
## ebs 
########################################################################################################################
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

########################################################################################################################
## elb 
########################################################################################################################
variable "OT367_alb_zone_id" {
  description = "OT-367 alb Zone id"
  type        = string
}

########################################################################################################################
#  network resources
########################################################################################################################
variable "vpc_cidr_block" {
  description = "ID of the existing VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "The CIDRs of the existing public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "The CIDRs of the existing private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b"] # Adjust for your region
}

########################################################################################################################
# ecs - start
########################################################################################################################

variable "ecs_task_desired_count" {
  description = "How many ECS tasks should run in parallel"
  type        = number
}

variable "ecs_task_min_count" {
  description = "How many ECS tasks should minimally run in parallel"
  default     = 1
  type        = number
}

variable "ecs_task_max_count" {
  description = "How many ECS tasks should maximally run in parallel"
  default     = 2
  type        = number
}

variable "ecs_task_deployment_minimum_healthy_percent" {
  description = "How many percent of a service must be running to still execute a safe deployment"
  default     = 50
  type        = number
}

variable "ecs_task_deployment_maximum_percent" {
  description = "How many additional tasks are allowed to run (in percent) while a deployment is executed"
  default     = 100
  type        = number
}

variable "cpu_target_tracking_desired_value" {
  description = "Target tracking for CPU usage in %"
  default     = 70
  type        = number
}

variable "memory_target_tracking_desired_value" {
  description = "Target tracking for memory usage in %"
  default     = 80
  type        = number
}

variable "target_capacity" {
  description = "Amount of resources of container instances that should be used for task placement in %"
  default     = 100
  type        = number
}

variable "container_port" {
  description = "Port of the container"
  type        = number
  default     = 80
}

variable "task_cpu_units" {
  description = "Amount of CPU units for a single ECS task"
  default     = 256
  type        = number
}

variable "task_memory_units" {
  description = "Amount of memory in MB for a single ECS task"
  default     = 512
  type        = number
}

# container name - start
variable "app_image_name" {
  description = "The name of the n8n app."
  type        = string
}
variable "app_container_name" {
  description = "The name of the n8n app container."
  type        = string
}
# container name - end
# Service name - start
variable "ecs_service_name" {
  description = "The name of the ECS service."
  type        = string
}
variable "ecs_cluster_name" {
  description = "name of the ecs cluster"
  type        = string

}

########################################################################################################################
# ecr 
########################################################################################################################
variable "ecr_repo_name" {
  description = "The name of the ECR repository. A Docker image-compatible name."
  type        = string
}

########################################################################################################################
# efs
########################################################################################################################
variable "efs_name" {
  description = "The name of the EFS"
  type        = string
}
