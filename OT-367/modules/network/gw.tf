resource "aws_internet_gateway" "OT367_igw" {
  vpc_id = aws_vpc.OT367_vpc.id

  tags = merge(var.common_tags, {
    Name = "OT-367-igw"
  })
}

resource "aws_eip" "nat_gateway_eip" {
  # instance = var.OT367_ec2_instance_info.id # Use the EC2 instance ID for the EIP association
  domain   = "vpc"
  tags = merge(var.common_tags, {
    Name = "OT-367-nat_gateway_eip"
  })
}

resource "aws_nat_gateway" "OT367_nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.OT367_public_subnet_1.id # Use the  public subnet
  tags = merge(var.common_tags, {
    Name = "OT-367-nat-gateway"
  })
  depends_on = [aws_internet_gateway.OT367_igw]
}

