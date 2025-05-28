resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.common_tags, {
    Name = "${var.environment}-${var.project_name}-igw"
  })
}

resource "aws_eip" "nat_gateway_eip" {
  domain   = "vpc"
  tags = merge(var.common_tags, {
    Name = "${var.environment}-${var.project_name}-nat_gateway_eip"
  })
}

resource "aws_nat_gateway" "app_nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id # Use one of the public subnets
  tags = merge(var.common_tags, {
    Name = "${var.environment}-${var.project_name}-nat-gateway"
  })
  depends_on = [aws_internet_gateway.app_igw]
}

