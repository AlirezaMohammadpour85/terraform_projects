output "aws_sg_go_api_sg_id" {
  value = aws_security_group.go_api_sg.id

}

output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "ARN of the ECS task execution role"

}
