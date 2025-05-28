variable "environment" {
  description = "The environment to deploy the EFS to"
  type        = string
}

variable "common_tags" {
  description = "The common tags to deploy the EFS to"
  type        = map(string)
}

variable "efs_name" {
  description = "The name of the EFS to deploy"
  type        = string
}

variable "efs_subnet_ids" {
  description = "The subnet IDs to deploy the EFS to"
  type        = list(string)
}

variable "efs_security_group_id" {
  description = "The security group ID to deploy the EFS to"
  type        = string
}
