resource "aws_ecs_cluster" "domotz_cluster" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(var.common_tags, {
    Name = "TestECS-" + var.ecs_cluster_name
  })
}
