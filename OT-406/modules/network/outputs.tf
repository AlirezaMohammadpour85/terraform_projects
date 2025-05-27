########################################################################################################################
## VPC Outputs
########################################################################################################################
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

########################################################################################################################
## Subnet Outputs
########################################################################################################################
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "public_subnet_1_id" {
  description = "Public Subnet 1 ID"
  value       = aws_subnet.public[0].id
}

output "public_subnet_2_id" {
  description = "Public Subnet 2 ID"
  value       = aws_subnet.public[1].id
}

output "private_subnet_id" {
  description = "Private Subnet ID"
  value       = aws_subnet.private.id
}

output "private_subnet_ids" {
  description = "List of all private subnet IDs"
  value       = [aws_subnet.private.id]
}

########################################################################################################################
## Route Table Outputs
########################################################################################################################
output "private_rt_id" {
  description = "Private route table ID"
  value       = aws_route_table.private.id
}

output "public_rt_id" {
  description = "Public route table ID"
  value       = aws_route_table.public.id
}