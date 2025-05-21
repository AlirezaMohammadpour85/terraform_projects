module "ecr" {
  source        = "./modules/ecr"
  ecr_repo_name = var.ecr_repo_name
  common_tags   = var.common_tags
  environment   = var.environment
}

module "network" {
  source = "./modules/network"

}

module "ecs" {
  source                      = "./modules/ecs"
  environment                 = var.environment
  common_tags                 = var.common_tags
  ecs_cluster_name            = var.ecs_cluster_name
  app_image_name              = var.app_image_name
  app_container_name          = var.app_container_name
  container_port              = var.container_port
  aws_region                  = var.aws_region
  ecs_service_name            = var.ecs_service_name
  ecs_task_desired_count      = var.ecs_task_desired_count
  ecs_task_deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  ecs_task_deployment_maximum_percent = var.ecs_task_deployment_maximum_percent
  task_cpu_units              = var.task_cpu_units
  task_memory_units           = var.task_memory_units
  ecr_repository_url          = module.ecr.repository_url
  public_subnet_1_id          = module.network.public_subnet_1_id
  public_subnet_2_id          = module.network.public_subnet_2_id
  aws_sg_go_api_sg_id         = module.security_groups.aws_sg_go_api_sg_id
  ecs_task_execution_role_arn = module.security_groups.ecs_task_execution_role_arn
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.network.vpc_id
  environment = var.environment
  common_tags = var.common_tags
}
