output "OT367_ssm_instance_profile" {
  value = {
    name = aws_iam_instance_profile.OT367_ssm_instance_profile.name
    arn  = aws_iam_instance_profile.OT367_ssm_instance_profile.arn
  }
  
}

output "OT367_sg_allow_ssm" {
  value = {
    id   = aws_security_group.OT367_sg_allow_ssm.id
    name = aws_security_group.OT367_sg_allow_ssm.name
  }
  description = "Security group for allowing SSM access"
}