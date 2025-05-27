########################################################################################################################
## EC2 Instance Security Group (SSM Access)
########################################################################################################################
resource "aws_security_group" "sg_allow_ssm" {
  name        = "${var.common_tags["project"]}-sg-allow-ssm"
  description = "Security group for EC2 instance with SSM access"
  vpc_id      = var.vpc_id

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound traffic for SSM
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound traffic from ALB
  ingress {
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_sg.id]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-sg-allow-ssm"
    }
  )
}

########################################################################################################################
## Application Load Balancer Security Group
########################################################################################################################
resource "aws_security_group" "elb_sg" {
  name        = "${var.common_tags["project"]}-elb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  # Allow HTTPS from internet
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP from internet (for redirect)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-elb-sg"
    }
  )
}