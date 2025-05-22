resource "aws_subnet" "public_subnet" {
  count      = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(var.common_tags, {
    Name = "${var.environment}-${var.project_name}-public_subnet_${count.index + 1}"
  })
}

resource "aws_subnet" "private_subnet" {
  count      = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(var.common_tags, {
    Name = "${var.environment}-${var.project_name}-private_subnet_${count.index + 1}"
  })
}
