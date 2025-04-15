output "OT367_public_subnet_1" {
  value = aws_subnet.OT367_public_subnet_1.id
  description = "Public Subnet 1 ID"
}

output "OT367_vpc_id" {
  value = aws_vpc.OT367_vpc.id
  description = "OT-367 VPC ID"
  
}