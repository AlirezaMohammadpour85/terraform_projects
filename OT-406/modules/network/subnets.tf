########################################################################################################################
## Data source for availability zones
########################################################################################################################
data "aws_availability_zones" "available" {
  state = "available"
}

########################################################################################################################
## Public Subnets
########################################################################################################################
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  # Using local.vpc_id instead of aws_vpc.main.id to support both VPC modes
  vpc_id                  = local.vpc_id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-public-subnet-${count.index + 1}"
      Type = "Public"
      Tier = "Public"
    }
  )
}

########################################################################################################################
## Private Subnet
########################################################################################################################
resource "aws_subnet" "private" {
  # Using local.vpc_id instead of aws_vpc.main.id to support both VPC modes
  vpc_id                  = local.vpc_id
  cidr_block              = var.private_subnet_cidrs[0]
  availability_zone       = var.private_subnet_availability_zone
  map_public_ip_on_launch = false

  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-private-subnet"
      Type = "Private"
      Tier = "Private"
    }
  )
}