resource "aws_ebs_volume" "OT367_ec2_data_volume" {
  availability_zone = var.OT367_ec2_instance_info.availability_zone
  # Size in GB
  size              = var.ebs_volume_size     
   # General purpose SSD                 
  type              = "gp3"                    
  tags = merge(
    var.common_tags,
    {
      Name = "OT367-ec2-data-volume"
    }
  )
}

#  Attach the Volume to EC2 Instance
resource "aws_volume_attachment" "OT367_ebs_attach" {
  # Linux will map this (e.g., /dev/xvdf)
  device_name = "/dev/sdf"                      
  volume_id   = aws_ebs_volume.OT367_ec2_data_volume.id
  instance_id = var.OT367_ec2_instance_info.id
  force_detach = true
}
