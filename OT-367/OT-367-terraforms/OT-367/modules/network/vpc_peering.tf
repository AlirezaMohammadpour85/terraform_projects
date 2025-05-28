# Use aws_vpc_peering_connection_accepter to manage existing connections
resource "aws_vpc_peering_connection_accepter" "existing_peering" {
  count                     = length(var.existing_peering_connection_ids)
  vpc_peering_connection_id = var.existing_peering_connection_ids[count.index]
  auto_accept               = true

  tags = merge(
    var.common_tags,
    {
      Name = "OT367-vpc-peering-accepter-${count.index + 1}"
    }
  )
}

# Update route tables to use the peering connection for the peer VPC CIDR
# Routes for your public subnets
resource "aws_route" "public_subnet_1_to_peer" {
  count                     = length(var.existing_peering_connection_ids)
  route_table_id            = aws_route_table.OT367_public_1_rt.id
  destination_cidr_block    = var.peer_vpc_cidr_blocks[count.index]
  vpc_peering_connection_id = var.existing_peering_connection_ids[count.index]
}

resource "aws_route" "public_subnet_2_to_peer" {
  count                     = length(var.existing_peering_connection_ids)
  route_table_id            = aws_route_table.OT367_public_2_rt.id
  destination_cidr_block    = var.peer_vpc_cidr_blocks[count.index]
  vpc_peering_connection_id = var.existing_peering_connection_ids[count.index]
}

# Routes for your private subnet
resource "aws_route" "private_subnet_to_peer" {
  count                     = length(var.existing_peering_connection_ids)
  route_table_id            = aws_route_table.OT367_private_rt.id
  destination_cidr_block    = var.peer_vpc_cidr_blocks[count.index]
  vpc_peering_connection_id = var.existing_peering_connection_ids[count.index]
}
