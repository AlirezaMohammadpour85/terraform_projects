variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "zuru-ecs-cluster"
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Environment for deployment (like test,dev or staging)"
  type        = string
}

variable "app_image_name" {
  description = "app image name"
}

variable "app_container_name" {
  description = "app container name"
}

variable "container_port" {
  description = "app port"
}

variable "ecs_service_name" {
  description = "The name of the ECS service."
  type        = string
}

variable "task_cpu_units" {
  description = "The number of CPU units for the ECS task."
  type        = number
}

variable "task_memory_units" {
  description = "The number of memory units for the ECS task."
  type        = number
}

variable "ecr_repository_url" {
  type = string
}

variable "public_subnet_ids" {
  description = "IDs of the existing public subnets"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "IDs of the existing private subnets"
  type        = list(string)
}


variable "aws_sg_go_api_sg_id" {
  description = "Security group ID for the n8n service"
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "ecs_task_desired_count" {
  description = "The number of tasks to run in the ECS service"
  type        = number
}

variable "ecs_task_deployment_minimum_healthy_percent" {
  description = "The minimum healthy percent of tasks to run in the ECS service"
  type        = number
}

variable "ecs_task_deployment_maximum_percent" {
  description = "The maximum percent of tasks to run in the ECS service"
  type        = number
}

variable "target_group_arn" {
  description = "ARN of the target group for the ALB"
  type        = string
}

  
