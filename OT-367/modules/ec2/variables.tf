variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}

}

variable "OT367_ec2_instance_type" {
  description = "OT-367 ec2 instance type"
  type        = string
}

variable "OT367_ssm_instance_profile" {
  description = "OT-367 ssm instance profile"
  type = object({
    name = string
    arn  = string
  })
}

variable "OT367_public_subnet_1" {
  description = "OT-367 public subnet 1"
  type        = string
}
variable "OT367_private_subnet_id" {
  description = "OT-367 private subnet cidr"
}
variable "OT367_sg_allow_ssm" {
  description = "OT-367 security group for allowing SSM access"
  type = object({
    id   = string
    name = string
  })

}

