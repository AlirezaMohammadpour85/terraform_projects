module "ecr" {
  source        = "./modules/ecr"
  ecr_repo_name = var.ecr_repo_name
  common_tags   = var.common_tags
  environment   = var.environment
  project_name  = var.project_name
}
module "security_groups" {
  source         = "./modules/security_groups"
  vpc_id         = module.network.vpc_id
  environment    = var.environment
  common_tags    = var.common_tags
  container_port = var.container_port
  project_name   = var.project_name
}

module "network" {
  source               = "./modules/network"
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  common_tags          = var.common_tags
  environment          = var.environment
  aws_region           = var.aws_region
  project_name         = var.project_name
  alb_sg               = module.security_groups.alb_sg
  availability_zones   = var.availability_zones
}

# module "efs" {
#   source = "./modules/efs"
#   environment = var.environment
#   common_tags = var.common_tags
#   efs_name = var.efs_name
#   efs_subnet_ids = [module.network.public_subnet_1_id, module.network.public_subnet_2_id]
#   efs_security_group_id = module.security_groups.aws_sg_go_api_sg_id
# }
# module "ecs" {
#   source                      = "./modules/ecs"
#   environment                 = var.environment
#   common_tags                 = var.common_tags
#   ecs_cluster_name            = var.ecs_cluster_name
#   app_image_name              = var.app_image_name
#   app_container_name          = var.app_container_name
#   container_port              = var.container_port
#   public_subnet_ids           = var.public_subnet_ids
#   private_subnet_ids          = var.private_subnet_ids
#   target_group_arn            = var.target_group_arn
#   aws_region                  = var.aws_region
#   ecs_service_name            = var.ecs_service_name
#   ecs_task_desired_count      = var.ecs_task_desired_count
#   ecs_task_deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
#   ecs_task_deployment_maximum_percent = var.ecs_task_deployment_maximum_percent
#   task_cpu_units              = var.task_cpu_units
#   task_memory_units           = var.task_memory_units
#   ecr_repository_url          = module.ecr.repository_url
#   aws_sg_go_api_sg_id         = module.security_groups.aws_sg_go_api_sg_id
#   ecs_task_execution_role_arn = module.security_groups.ecs_task_execution_role_arn
# }

