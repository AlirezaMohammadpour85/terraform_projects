resource "aws_ecs_task_definition" "app_task" {
  family                   = "${var.environment}_ECS_TaskDefinition_${var.ecs_cluster_name}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu_units
  memory                   = var.task_memory_units
  execution_role_arn       = var.ecs_task_execution_role_arn

  container_definitions = jsonencode([
    {
      name      = var.app_container_name
      image     = "${var.ecr_repository_url}:${var.app_image_name}"
      cpu       = var.task_cpu_units
      memory    = var.task_memory_units
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "${var.environment}-log-stream-${var.ecs_cluster_name}"
        }
      }
    }
  ])
  tags = merge(var.common_tags, {
    Name = "TestECSTaskdefinition-${var.ecs_cluster_name}"
  })
}
