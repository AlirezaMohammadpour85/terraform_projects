resource "aws_vpc" "zuru_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "zuru-vpc"
  }
}