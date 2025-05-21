variable "ecr_repo_name" {
  description = "The name of the ECR repository."
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}