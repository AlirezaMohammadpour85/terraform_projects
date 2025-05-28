resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = merge(var.common_tags, {
    Name = "${var.environment}-${var.project_name}-vpc"
  }
  )
}