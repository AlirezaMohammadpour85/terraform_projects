########################################################################################################################
## Public Route Table
########################################################################################################################
# Create route table for public subnets
# Routes are added separately to handle conditional IGW creation
resource "aws_route_table" "public" {
  vpc_id = local.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.common_tags["project"]}-public-rt"
      Type = "Public"
    }
  )
}

########################################################################################################################
## Public Route to Internet Gateway
########################################################################################################################
# Separate route resource allows us to use the conditional IGW ID
# This route enables internet access for resources in public subnets
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = local.igw_id
}

########################################################################################################################
## Public Route Table Associations
########################################################################################################################
# Associate each public subnet with the public route table
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)
  
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

########################################################################################################################
## Private Route Table
########################################################################################################################
# Create route table for private subnets
# Routes are added separately for better control
resource "aws_route_table" "private" {
  vpc_id = local.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.common_tags["project"]}-private-rt"
      Type = "Private"
    }
  )
}

########################################################################################################################
## Private Route to NAT Gateway
########################################################################################################################
# Separate route resource for NAT Gateway
# This route enables internet access for resources in private subnets via NAT
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

########################################################################################################################
## Private Route Table Association
########################################################################################################################
# Associate the private subnet with the private route table
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}