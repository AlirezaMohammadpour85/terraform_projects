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

resource "aws_eip" "OT367_public_ip_ec2" {
  instance = aws_instance.OT367_ec2_instance.id # Use the EC2 instance ID for the EIP association
  domain   = "vpc"
  tags = merge(var.common_tags, {
    Name = "OT-367-public-ip-ec2"
  })

}

resource "aws_instance" "OT367_ec2_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.OT367_ec2_instance_type
  subnet_id                   = var.OT367_public_subnet_1
  vpc_security_group_ids      = [var.OT367_sg_allow_ssm["id"]]
  iam_instance_profile        = var.OT367_ssm_instance_profile["name"]
  associate_public_ip_address = false

  # Set root volume size to 80 GB
  root_block_device {
    volume_size           = 80
    volume_type           = "gp3" # or "gp2"
    delete_on_termination = false
    tags = merge(var.common_tags, {
      Name = "OT367-root-ebs"
    })
  }

  user_data = <<-EOF
            #!/bin/bash
            apt-get update -y
            apt-get install -y snapd
            snap install amazon-ssm-agent --classic
            systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
            systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
            apt-get install -y git
            apt-get install -y \
              ca-certificates \
              curl \
              gnupg \
              lsb-release
            mkdir -p /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            echo \
              "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
              $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
            apt-get update -y
            apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            systemctl enable docker
            systemctl start docker
            usermod -aG docker ubuntu
            sudo usermod -aG docker ssm-user
            sudo reboot
            EOF

  lifecycle {
    ignore_changes = [tags, associate_public_ip_address]
  }
  tags = merge(var.common_tags, {
    Name = "OT-367-ec2-instance"
  })
}
