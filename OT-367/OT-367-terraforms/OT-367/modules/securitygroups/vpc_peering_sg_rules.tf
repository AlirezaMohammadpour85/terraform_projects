# Security group rules to allow inbound traffic from peered VPCs
resource "aws_security_group_rule" "allow_peer_vpc_ingress" {
  count             = length(var.peer_vpc_cidr_blocks)
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.peer_vpc_cidr_blocks[count.index]]
  security_group_id = aws_security_group.OT367_sg_allow_ssm.id
  description       = "Allow all inbound traffic from peer VPC ${count.index + 1} (${var.peer_vpc_cidr_blocks[count.index]})"
}

# Security group rules to allow outbound traffic to peered VPCs
resource "aws_security_group_rule" "allow_peer_vpc_egress" {
  count             = length(var.peer_vpc_cidr_blocks)
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.peer_vpc_cidr_blocks[count.index]]
  security_group_id = aws_security_group.OT367_sg_allow_ssm.id
  description       = "Allow all outbound traffic to peer VPC ${count.index + 1} (${var.peer_vpc_cidr_blocks[count.index]})"
}
