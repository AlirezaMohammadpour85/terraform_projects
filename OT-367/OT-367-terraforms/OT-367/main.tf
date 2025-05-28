module "ec2" {
  source                     = "./modules/ec2"
  OT367_ec2_instance_type    = var.OT367_ec2_instance_type
  common_tags                = var.common_tags
  OT367_ssm_instance_profile = module.securitygroup.OT367_ssm_instance_profile
  OT367_public_subnet_1_id   = module.network.OT367_public_subnet_1_id
  OT367_sg_allow_ssm         = module.securitygroup.OT367_sg_allow_ssm
  OT367_elb_sg               = module.securitygroup.OT367_elb_sg
  OT367_private_subnet_id    = module.network.OT367_private_subnet_id
  ami_id                     = var.ami_id
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
  OT367_elb_sg               = module.securitygroup.OT367_elb_sg
  OT367_alb_zone_id          = var.OT367_alb_zone_id
  OT367_private_subnet_availability_zone = var.OT367_private_subnet_availability_zone
  acm_certificate_arn       = var.acm_certificate_arn
  existing_peering_connection_ids = var.existing_peering_connection_ids
  peer_vpc_cidr_blocks = var.peer_vpc_cidr_blocks
}

module "securitygroup" {
  source       = "./modules/securitygroups"
  common_tags  = var.common_tags
  OT367_vpc_id = module.network.OT367_vpc_id
  existing_peering_connection_ids = var.existing_peering_connection_ids
  peer_vpc_cidr_blocks = var.peer_vpc_cidr_blocks
}

