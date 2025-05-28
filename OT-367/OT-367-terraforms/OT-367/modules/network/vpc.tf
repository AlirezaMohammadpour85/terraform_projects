resource "aws_vpc" "OT367_vpc" {
  cidr_block       = var.OT367_vpc_cidr_block
  instance_tenancy = "default"

  tags = merge(var.common_tags, {
    Name = "OT-367-vpc"
  }
  )
}