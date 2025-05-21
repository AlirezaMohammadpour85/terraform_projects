resource "aws_route_table" "go_api_rt" {
  vpc_id = aws_vpc.zuru_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.go_api_igw.id
  }

  tags = {
    Name = "go-api-route-table"
  }
}