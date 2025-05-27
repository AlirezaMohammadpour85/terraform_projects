########################################################################################################################
## Data source for latest Ubuntu 22.04 AMI
########################################################################################################################
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's official AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

########################################################################################################################
## EC2 Instance
########################################################################################################################
resource "aws_instance" "main" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [var.sg_allow_ssm.id]
  iam_instance_profile        = var.ssm_instance_profile.name
  associate_public_ip_address = false

  # Root volume configuration
  root_block_device {
    volume_size           = 80
    volume_type           = "gp3"
    delete_on_termination = false
    encrypted             = true # Added encryption

    tags = merge(
      var.common_tags,
      {
        Name = "${var.common_tags["project"]}-root-volume"
      }
    )
  }

  # User data for initial setup
  user_data = <<-EOF
#!/bin/bash
# Update and install prerequisites
apt-get update -y
apt-get install -y snapd git ca-certificates curl gnupg lsb-release
snap install amazon-ssm-agent --classic
systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
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
EOF

}
