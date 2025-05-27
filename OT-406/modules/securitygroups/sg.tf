########################################################################################################################
## EC2 Instance Security Group (SSM Access)
########################################################################################################################
resource "aws_security_group" "sg_allow_ssm" {
  name        = "${var.common_tags["project"]}-sg-allow-ssm"
  description = "Security group for EC2 instance with SSM access only"
  vpc_id      = var.vpc_id

  # Allow all outbound traffic (for apt, bitbucket, ubuntu core store, etc.)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound traffic for SSM endpoints
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-sg-allow-ssm"
    }
  )
}