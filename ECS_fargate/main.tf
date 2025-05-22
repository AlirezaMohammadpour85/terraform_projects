module "ecr" {
  source        = "./modules/ecr"
  ecr_repo_name = var.ecr_repo_name
  common_tags   = var.common_tags
  environment   = var.environment
  project_name  = var.project_name
}
# module "security_groups" {
#   source        = "./modules/security_groups"
#   vpc_id        = var.vpc_id
#   environment   = var.environment
#   common_tags   = var.common_tags
#   alb_sg_id     = var.existing_alb_sg_id
#   container_port = var.container_port
# }

# module "network" {
#   source = "./modules/network"
#   OT367_vpc_cidr_block = var.OT367_vpc_cidr_block
#   OT367_public_subnet_cidrs = var.OT367_public_subnet_cidrs
#   OT367_private_subnet_availability_zone = var.OT367_private_subnet_availability_zone
#   OT367_alb_zone_id = var.OT367_alb_zone_id
#   OT367_elb_sg = var.OT367_elb_sg
#   common_tags = var.common_tags
#   environment = var.environment
#   aws_region = var.aws_region
#   acm_certificate_arn = var.acm_certificate_arn
#   OT367_ec2_instance_info = var.OT367_ec2_instance_info
#   OT367_private_subnet_cidrs = var.OT367_private_subnet_cidrs
#   project_name = var.project_name

# }

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

