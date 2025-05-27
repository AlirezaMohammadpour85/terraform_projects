########################################################################################################################
## Network Module
########################################################################################################################
module "network" {
  source = "./modules/network"
  
  # Common tags
  common_tags = var.common_tags
  
  # Network configuration
  vpc_cidr_block                   = var.vpc_cidr_block
  public_subnet_cidrs              = var.public_subnet_cidrs
  private_subnet_cidrs             = var.private_subnet_cidrs
  private_subnet_availability_zone = var.private_subnet_availability_zone
  
  # Dependencies from other modules
  ec2_instance_info = module.ec2.ec2_instance_info
  elb_sg            = module.securitygroup.elb_sg
  
  # ALB configuration
  alb_zone_id         = var.alb_zone_id
  acm_certificate_arn = var.acm_certificate_arn
}

########################################################################################################################
## Security Groups Module
########################################################################################################################
module "securitygroup" {
  source = "./modules/securitygroups"
  
  # Common tags
  common_tags = var.common_tags
  
  # VPC dependency
  vpc_id = module.network.vpc_id
  
  # S3 bucket name
  s3_bucket_name = var.s3_bucket_name
}

########################################################################################################################
## EC2 Module
########################################################################################################################
module "ec2" {
  source = "./modules/ec2"
  
  # Common tags
  common_tags = var.common_tags
  
  # EC2 configuration
  ec2_instance_type = var.ec2_instance_type
  
  # Dependencies from other modules
  ssm_instance_profile = module.securitygroup.ssm_instance_profile
  public_subnet_1_id   = module.network.public_subnet_1_id
  private_subnet_id    = module.network.private_subnet_id
  sg_allow_ssm         = module.securitygroup.sg_allow_ssm
  elb_sg               = module.securitygroup.elb_sg
}