resource "aws_ecs_service" "app_service" {
  name            = "${var.environment}_ECS_Service_${var.ecs_service_name}"
  cluster         = aws_ecs_cluster.domotz_cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent = var.ecs_task_deployment_maximum_percent
  
  # TODO: add LB and network configuration
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.app_container_name
    container_port   = var.container_port
  }
  network_configuration {
    # taken from network ecs output file
    subnets          = [var.public_subnet_1_id, var.public_subnet_2_id]
    security_groups  = [var.aws_sg_go_api_sg_id]
    assign_public_ip = false #true
  }

  tags = merge(var.common_tags, {
    Name = "${var.environment}_ECS_Service_${var.ecs_service_name}"
  })
}
