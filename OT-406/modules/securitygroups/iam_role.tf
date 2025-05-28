########################################################################################################################
## IAM Role for SSM Access
########################################################################################################################
resource "aws_iam_role" "ssm_role" {
  name = "${var.project_name}-${var.common_tags["project"]}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.common_tags["project"]}-ssm-role"
    }
  )
}

########################################################################################################################
## Attach SSM Policy to Role
########################################################################################################################
resource "aws_iam_role_policy_attachment" "ssm_policy_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

########################################################################################################################
## Instance Profile for EC2
########################################################################################################################
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${var.project_name}-${var.common_tags["project"]}-ec2-ssm-profile"
  role = aws_iam_role.ssm_role.name

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.common_tags["project"]}-ec2-ssm-profile"
    }
  )
}

########################################################################################################################
## S3 Access Policy for ubuntu-core-secrets bucket
########################################################################################################################
resource "aws_iam_role_policy" "s3_access" {
  name = "${var.project_name}-${var.common_tags["project"]}-s3-${var.s3_bucket_name}-policy"
  role = aws_iam_role.ssm_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      }
    ]
  })
}
