########################################################################################################################
## EC2 Instance Information
########################################################################################################################
output "ec2_instance_info" {
  description = "EC2 instance information"
  value = {
    id                = aws_instance.main.id
    public_ip         = aws_instance.main.public_ip
    private_ip        = aws_instance.main.private_ip
    availability_zone = aws_instance.main.availability_zone
  }
}

output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.main.id
}

output "ec2_instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.main.private_ip
}

output "ec2_instance_arn" {
  description = "The ARN of the EC2 instance"
  value       = aws_instance.main.arn
}

output "ec2_ami_id" {
  description = "The AMI ID used for the EC2 instance"
  value       = data.aws_ami.ubuntu.id
}

output "ec2_ami_name" {
  description = "The AMI name used for the EC2 instance"
  value       = data.aws_ami.ubuntu.name
}