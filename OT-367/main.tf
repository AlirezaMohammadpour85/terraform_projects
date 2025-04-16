module "ec2" {
  source                     = "./modules/ec2"
  OT367_ec2_instance_type    = var.OT367_ec2_instance_type
  common_tags                = var.common_tags
  OT367_ssm_instance_profile = module.securitygroup.OT367_ssm_instance_profile
  OT367_public_subnet_1      = module.network.OT367_public_subnet_1
  OT367_sg_allow_ssm         = module.securitygroup.OT367_sg_allow_ssm
  OT367_private_subnet_id    = module.network.OT367_private_subnet_id
}

# module "ebs" {
#   source                  = "./modules/ebs"
#   common_tags             = var.common_tags
#   ebs_volume_size         = var.ebs_volume_size
#   OT367_ec2_instance_info = module.ec2.OT367_ec2_instance_info

# }

module "network" {
  source                     = "./modules/network"
  common_tags                = var.common_tags
  OT367_public_subnet_cidrs  = var.OT367_public_subnet_cidrs
  OT367_private_subnet_cidrs = var.OT367_private_subnet_cidrs
  OT367_vpc_cidr_block       = var.OT367_vpc_cidr_block
  OT367_ec2_instance_info    = module.ec2.OT367_ec2_instance_info
}

module "securitygroup" {
  source       = "./modules/securitygroups"
  common_tags  = var.common_tags
  OT367_vpc_id = module.network.OT367_vpc_id
}

