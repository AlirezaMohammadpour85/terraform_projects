variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
  
}
variable "environment" {
  description = "Environment for deployment (like test,dev or staging)"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
