# resource "aws_ecs_task_definition" "app_task" {
#   family                   = "${var.environment}_ECS_TaskDefinition_${var.ecs_cluster_name}"
#   requires_compatibilities = ["FARGATE"]
#   network_mode             = "awsvpc"
#   cpu                      = var.task_cpu_units
#   memory                   = var.task_memory_units
#   execution_role_arn       = var.ecs_task_execution_role_arn

#   container_definitions = jsonencode([
#     {
#       name      = var.app_container_name
#       image     = "${var.ecr_repository_url}:${var.app_image_name}"
#       cpu       = var.task_cpu_units
#       memory    = var.task_memory_units
#       essential = true
#       portMappings = [
#         {
#           containerPort = var.container_port
#           hostPort      = var.container_port
#           protocol      = "tcp"
#         }
#       ]
#       logConfiguration = {
#         logDriver = "awslogs"
#         options = {
#           "awslogs-group"         = aws_cloudwatch_log_group.log_group.name
#           "awslogs-region"        = var.aws_region
#           "awslogs-stream-prefix" = "${var.environment}-log-stream-${var.ecs_cluster_name}"
#         }
#       }
#     }
#   ])
#   tags = merge(var.common_tags, {
#     Name = "TestECSTaskdefinition-${var.ecs_cluster_name}"
#   })
# }
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/${var.environment}-${var.app_container_name}"
  retention_in_days = 30
  
  tags = merge(var.common_tags, {
    Name = "${var.environment}-${var.app_container_name}-logs"
  })
}

resource "aws_ecs_task_definition" "app_task" {
  family                   = "${var.environment}_ECS_TaskDefinition_${var.app_container_name}"
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
      
      environment = [
        {
          name  = "N8N_HOST",
          value = var.n8n_host != "" ? var.n8n_host : "localhost"
        },
        {
          name  = "N8N_PORT",
          value = tostring(var.container_port)
        },
        {
          name  = "N8N_LISTEN_ADDRESS",
          value = "0.0.0.0"
        },
        {
          name  = "N8N_PROTOCOL",
          value = "http"
        },
        {
          name  = "NODE_ENV",
          value = "production"
        },
        # {
        #   name  = "N8N_ENCRYPTION_KEY",
        #   value = var.n8n_encryption_key
        # },
        # {
        #   name  = "N8N_DATABASE_TYPE",
        #   value = var.n8n_database_type
        # },
        {
          name  = "WEBHOOK_URL",
          value = var.n8n_webhook_url
        }
      ],
           
      mountPoints = [
        {
          sourceVolume  = "n8n-data",
          containerPath = "/home/node/.n8n",
          readOnly      = false
        }
      ],
      
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "${var.environment}-log-stream-${var.app_container_name}"
        }
      }
    }
  ])
  
  volume {
    name = "n8n-data"
    
    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.n8n_data.id
      root_directory     = "/"
      transit_encryption = "ENABLED"
      
      authorization_config {
        access_point_id = aws_efs_access_point.n8n_access_point.id
      }
    }
  }
  
  tags = merge(var.common_tags, {
    Name = "${var.environment}_ECS_TaskDefinition_${var.app_container_name}"
  })
}
