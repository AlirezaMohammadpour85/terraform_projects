module "ecr" {
  source        = "./modules/ecr"
  ecr_repo_name = var.ecr_repo_name  
  common_tags   = var.common_tags
}

module "network" {
  source = "./modules/network"

}

module "ecs" {
  source                 = "./modules/ecs"
  common_tags            = var.common_tags
  ecs_cluster_name       = var.ecs_cluster_name
  app_image_name         = var.app_image_name
  app_container_name     = var.app_container_name
  app_port               = var.app_port
  ecr_repository_url     = module.ecr.repository_url
  public_subnet_1_id     = module.network.public_subnet_1_id
  public_subnet_2_id     = module.network.public_subnet_2_id
  aws_sg_go_api_sg_id    = module.security_groups.aws_sg_go_api_sg_id
  ecs_task_execution_role_arn = module.security_groups.ecs_task_execution_role_arn
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.network.vpc_id
}
