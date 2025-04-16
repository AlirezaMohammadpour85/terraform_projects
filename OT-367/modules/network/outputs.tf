output "OT367_public_subnet_1_id" {
  value = aws_subnet.OT367_public_subnet_1.id
  description = "Public Subnet 1 ID"
}
output "OT367_public_subnet_2_id" {
  value = aws_subnet.OT367_public_subnet_2.id
  description = "Public Subnet 1 ID"
}
output "OT367_private_subnet_id" {
  value = aws_subnet.OT367_private_subnet.id
  description = "Private Subnet ID"
  
}
output "OT367_vpc_id" {
  value = aws_vpc.OT367_vpc.id
  description = "OT-367 VPC ID"
  
}