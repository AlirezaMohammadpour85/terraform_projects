output "sg_allow_ssm" {
  value = aws_security_group.sg_allow_ssm
}

output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "ARN of the ECS task execution role"

}

output "alb_sg" {
  value = aws_security_group.alb_sg
}
