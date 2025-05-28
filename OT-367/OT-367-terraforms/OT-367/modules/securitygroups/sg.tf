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
  # ingress {
  #   from_port   = 8000
  #   to_port     = 8000
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  ingress {
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.OT367_elb_sg.id]
  }
}

# LB Security Group
# This security group is for the Load Balancer (ELB) to allow inbound HTTP traffic
resource "aws_security_group" "OT367_elb_sg" {
  name        = "OT367_elb_sg"
  description = "Allow inbound HTTP"
  vpc_id      = var.OT367_vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Accept HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    # Add common tags to the security group
    Name = "OT367_elb_sg"
  })
}
