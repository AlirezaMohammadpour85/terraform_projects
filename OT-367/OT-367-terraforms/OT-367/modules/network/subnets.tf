resource "aws_subnet" "OT367_public_subnet_1" {
  vpc_id     = aws_vpc.OT367_vpc.id
  cidr_block = var.OT367_public_subnet_cidrs[0]

  tags = merge(var.common_tags, {
    Name = "OT-367-public_subnet_1"
    }
  )
}
resource "aws_subnet" "OT367_public_subnet_2" {
  vpc_id     = aws_vpc.OT367_vpc.id
  cidr_block = var.OT367_public_subnet_cidrs[1]

  tags = merge(var.common_tags, {
    Name = "OT-367-public_subnet_2"
    }
  )
}


resource "aws_subnet" "OT367_private_subnet" {
  vpc_id            = aws_vpc.OT367_vpc.id
  cidr_block        = var.OT367_private_subnet_cidrs[0]
  availability_zone = var.OT367_private_subnet_availability_zone
  tags = merge(var.common_tags, {
    Name = "OT-367-private_subnet"
  })
}
