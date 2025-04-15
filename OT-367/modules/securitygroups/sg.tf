resource "aws_security_group" "OT367_sg_allow_ssm" {
  vpc_id = var.OT367_vpc_id
  tags = merge(var.common_tags, {
    Name = "OT-367-sg-allow-ssm"
  })
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound traffic for SSM (port 22 will not be used)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}