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


# resource "aws_instance" "web" {
#   ami = data.aws_ami.ubuntu.id
#   #   ami                    = "ami-02ec57994fa0fae21"
#   instance_type          = "t3.micro"
#   vpc_security_group_ids = [aws_security_group.web_server_sg.id]

#   tags = {
#     Name = "test-instance"
#   }
#   #   if i use <<-EOF and no indent is required.but if i dont and dont do left allign it will be error
# #   user_data = <<-EOF
# #             #!/bin/bash
# #             echo "Hello, World" > index.xhtml
# #             nohup busybox httpd -f -p ${var.server_port} &
# #             EOF
# # here must be left allign otherwise it will be error
#   user_data = <<EOF
# #!/bin/bash
# echo "Hello, World!" > index.html
# busybox httpd -f -p ${var.server_port} &
# EOF

#   user_data_replace_on_change = true
# }

####################################################################################################
# VPC and Subnet
####################################################################################################
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
              echo "Hello, World!" > index.html
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
}
