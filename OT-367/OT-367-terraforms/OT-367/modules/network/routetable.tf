resource "aws_route_table" "OT367_public_1_rt" {
  vpc_id = aws_vpc.OT367_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.OT367_igw.id
  }
  tags = merge(var.common_tags, {
    Name = "OT-367-public-1-rt"
  })
}
resource "aws_route_table" "OT367_public_2_rt" {
  vpc_id = aws_vpc.OT367_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.OT367_igw.id
  }
  tags = merge(var.common_tags, {
    Name = "OT-367-public-2-rt"
  })
}

resource "aws_route_table_association" "OT367_public_1_rt_association" {
  subnet_id      = aws_subnet.OT367_public_subnet_1.id
  route_table_id = aws_route_table.OT367_public_1_rt.id
}
resource "aws_route_table_association" "OT367_public_2_rt_association" {
  subnet_id      = aws_subnet.OT367_public_subnet_2.id
  route_table_id = aws_route_table.OT367_public_2_rt.id
}

# private network route table
# The private route table is associated with the private subnet and routes traffic to the NAT gateway for internet access.
resource "aws_route_table" "OT367_private_rt" {
  vpc_id = aws_vpc.OT367_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.OT367_nat_gateway.id
  }
  tags = merge(var.common_tags, {
    Name = "OT-367-private-rt"
  })
}
resource "aws_route_table_association" "OT367_private_rt_association" {
  subnet_id      = aws_subnet.OT367_private_subnet.id # Use the  private subnet
  route_table_id = aws_route_table.OT367_private_rt.id
}
