####################################################################################################
# Provider
####################################################################################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "terraform_user"
}


####################################################################################################
# Security Group
####################################################################################################

resource "aws_security_group" "web_server_sg" {
  name = "web-server-sg"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #   egress {
  #     from_port   = 0
  #     to_port     = 0
  #     protocol    = "-1"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }
}




####################################################################################################
# EC2 Instance
####################################################################################################
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

####################################################################################################
# VPC and Subnet
####################################################################################################
# extract default vpc info from aws

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}
output "subnet_ids" {
  value = data.aws_subnets.default_subnets.ids
}
###################################################################################################
# ASG
####################################################################################################  
resource "aws_launch_template" "web-config" {
  name_prefix            = "test-asg-web-config"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  # i used <<-EOF and no indent is required.but if i dont and dont do left allign it will be error
  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo "Hello, World! $(hostname -f)" > index.html
              busybox httpd -f -p ${var.server_port} &
              EOF
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web-asg" {
  name = "test-asg-example"
  launch_template {
    id      = aws_launch_template.web-config.id
    version = "$Latest"
  }
  min_size         = 1
  max_size         = 2
  desired_capacity = 2 # add for test to have 2 instances

  vpc_zone_identifier = data.aws_subnets.default_subnets.ids
  tag {
    key                 = "Name"
    value               = "test-asg-example"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  # add target group arn to asg
  target_group_arns = [aws_lb_target_group.asg.arn]
  # change health check from ec2 to alb
  health_check_type = "ELB"
}

####################################################################################################
# Load Balancer
####################################################################################################
resource "aws_lb" "test" {
  name                       = "test-alb-tf"
  load_balancer_type         = "application"
  subnets                    = data.aws_subnets.default_subnets.ids
  security_groups            = [aws_security_group.alb.id]
  # enable_deletion_protection = true
  enable_deletion_protection = false

  tags = {
    Environment = "test-alb-tf"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "HTTP"
  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

# sg for alb
# can be createing inline or create rules in separate resource(good for dynamic and locals)

resource "aws_security_group" "alb" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  # Allow inbound HTTP requests
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

# step3
resource "aws_lb_target_group" "asg" {
  name     = "terraform-asg-example"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# step 5
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100
  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}

output "alb_dns_name" {
  value       = aws_lb.test.dns_name
  description = "The DNS name of the load balancer"
}
