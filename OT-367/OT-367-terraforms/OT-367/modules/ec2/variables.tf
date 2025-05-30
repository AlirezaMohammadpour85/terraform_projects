variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}

}

variable "ami_id" {
  description = "AMI ID to launch the EC2 instance from (e.g. custom AMI you created)"
  type        = string
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

variable "OT367_public_subnet_1_id" {
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
variable "OT367_elb_sg" {
  description = "OT-367 security group for allowing SSM access"
  type = object({
    id   = string
    name = string
  })

}

