########################################################################################################################
## SSM Configuration Outputs
########################################################################################################################
output "ssm_instance_profile" {
  description = "SSM instance profile for EC2"
  value = {
    name = aws_iam_instance_profile.ssm_instance_profile.name
    arn  = aws_iam_instance_profile.ssm_instance_profile.arn
  }
}

output "ssm_role_arn" {
  description = "ARN of the SSM IAM role"
  value       = aws_iam_role.ssm_role.arn
}

########################################################################################################################
## Security Group Outputs
########################################################################################################################
output "sg_allow_ssm" {
  description = "Security group for EC2 instance with SSM access"
  value = {
    id   = aws_security_group.sg_allow_ssm.id
    name = aws_security_group.sg_allow_ssm.name
  }
}

output "sg_allow_ssm_id" {
  description = "ID of the SSM security group"
  value       = aws_security_group.sg_allow_ssm.id
}