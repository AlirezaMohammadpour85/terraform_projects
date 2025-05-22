variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}


