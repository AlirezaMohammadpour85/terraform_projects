########################################################################################################################
## Internet Gateway - Conditional Creation
########################################################################################################################
# Only create Internet Gateway when creating a new VPC
# Existing VPCs should already have an IGW attached
resource "aws_internet_gateway" "main" {
  count  = var.existing_vpc_id == "" ? 1 : 0
  vpc_id = local.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-igw"
    }
  )
}

# Data source to find existing Internet Gateway when using existing VPC
# This assumes the existing VPC has an IGW attached (which is typical for VPCs with public subnets)
data "aws_internet_gateway" "existing" {
  count = var.existing_vpc_id != "" ? 1 : 0
  
  filter {
    name   = "attachment.vpc-id"
    values = [var.existing_vpc_id]
  }
}

# Local value to determine which Internet Gateway ID to use
locals {
  # Use existing IGW if using existing VPC, otherwise use newly created IGW
  igw_id = var.existing_vpc_id != "" ? data.aws_internet_gateway.existing[0].id : aws_internet_gateway.main[0].id
}

########################################################################################################################
## Elastic IP for NAT Gateway
########################################################################################################################
# Always create a new EIP for NAT Gateway regardless of VPC mode
# Each NAT Gateway needs its own EIP
resource "aws_eip" "nat" {
  domain = "vpc"
  
  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-nat-eip"
    }
  )
  
  # Ensure IGW exists before creating EIP (best practice)
  depends_on = [
    aws_internet_gateway.main,
    data.aws_internet_gateway.existing
  ]
}

########################################################################################################################
## NAT Gateway
########################################################################################################################
# Always create NAT Gateway in the first public subnet
# This provides internet access for resources in private subnets
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-nat-gateway"
    }
  )

  # Ensure IGW exists before creating NAT Gateway
  depends_on = [
    aws_internet_gateway.main,
    data.aws_internet_gateway.existing
  ]
}