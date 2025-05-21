resource "aws_iam_role" "OT367_ssm_role" {
  name               = "OT-367-ssm-role"
  tags = merge(var.common_tags, {
    Name = "OT-367-ssm-role"
  })
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# 7. Attach the AmazonSSMManagedInstanceCore policy to the IAM role
resource "aws_iam_role_policy_attachment" "ssm_policy_attach" {
  role       = aws_iam_role.OT367_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "OT367_ssm_instance_profile" {
  name = "OT-367-ec2_ssm_profile"
  role = aws_iam_role.OT367_ssm_role.name
}