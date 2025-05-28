variable "ecr_repo_name" {
  description = "The name of the ECR repository."
}

variable "environment" {
  description = "Environment for deployment (like test,dev or staging)"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable "project_name" {
  description = "Project name"
  type        = string
}

