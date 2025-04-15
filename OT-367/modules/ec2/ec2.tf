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
  filter {
    name = "architecture"
    # or "arm64"
    values = ["x86_64"]
  }
  # Canonical's official AWS account ID
  owners = ["099720109477"]
}


resource "aws_instance" "OT367_ec2_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.OT367_ec2_instance_type
  subnet_id                   = var.OT367_private_subnet_cidrs # Use the private subnet for the instance
  security_groups             = [var.OT367_sg_allow_ssm["name"]]
  iam_instance_profile        = var.OT367_ssm_instance_profile["name"]
  associate_public_ip_address = false # true

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y snapd
              snap install amazon-ssm-agent --classic
              systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
              systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
              EOF

  tags = merge(var.common_tags, {
    Name = "OT-367-ec2-instance"
  })
}


