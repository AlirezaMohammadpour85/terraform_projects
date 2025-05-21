resource "aws_ecs_task_definition" "api_task" {
  family                   = "api_task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = var.ecs_task_execution_role_arn

  container_definitions = jsonencode([
    {
      name      = var.app_container_name
      image     = "${var.ecr_repository_url}:${var.app_image_name}"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = var.app_port
          # hostPort      = 80
        }
      ]
    }
  ])
  tags = merge(var.common_tags, {
    Name = "TestECSTaskdefinition-" + var.ecs_cluster_name
  })
}
