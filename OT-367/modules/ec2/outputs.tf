output "OT367_ec2_instance_info" {
  value = {
    id                = aws_instance.OT367_ec2_instance.id
    public_ip         = aws_instance.OT367_ec2_instance.public_ip
    availability_zone = aws_instance.OT367_ec2_instance.availability_zone
  }
}

