resource "aws_ecs_service" "go_api_service" {
  name            = "go-api-service"
  cluster         = aws_ecs_cluster.zuru_cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.api_task.arn
  desired_count   = 1

  network_configuration {
    # taken from network ecs output file
    subnets          = [var.public_subnet_1_id, var.public_subnet_2_id]
    security_groups  = [var.aws_sg_go_api_sg_id]
    assign_public_ip = true
  }
}
