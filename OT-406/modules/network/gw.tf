########################################################################################################################
## Internet Gateway
########################################################################################################################
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-igw"
    }
  )
}

########################################################################################################################
## Elastic IP for NAT Gateway
########################################################################################################################
resource "aws_eip" "nat" {
  domain = "vpc"
  
  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-nat-eip"
    }
  )
  
  depends_on = [aws_internet_gateway.main]
}

########################################################################################################################
## NAT Gateway
########################################################################################################################
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-nat-gateway"
    }
  )

  depends_on = [aws_internet_gateway.main]
}