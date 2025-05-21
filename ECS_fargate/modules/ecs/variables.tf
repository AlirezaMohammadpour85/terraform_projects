variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "zuru-ecs-cluster"
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}


variable "app_image_name" {
  description = "app image name"
}

variable "app_container_name" {
  description = "app container name"
}

variable "app_port" {
  description = "app port"
}

variable "ecr_repository_url" {
  type = string
}

variable "public_subnet_1_id" {
  description = "ID of the first public subnet"
  type        = string
  
}

variable "public_subnet_2_id" {
  description = "ID of the second public subnet"
  type        = string
  
}

variable "aws_sg_go_api_sg_id" {
  description = "Security group ID for the Go API service"
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}