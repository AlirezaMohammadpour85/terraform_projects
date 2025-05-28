
# EFS file system for persisting n8n data
resource "aws_efs_file_system" "n8n_data" {
  creation_token = "${var.environment}-EFS-${var.efs_name}"
  encrypted      = true
  tags = merge(var.common_tags, {
    Name = "${var.environment}-EFS-${var.efs_name}"
  })
}

# Mount targets for the EFS file system (one per subnet)
resource "aws_efs_mount_target" "n8n_mount_targets" {
  file_system_id  = aws_efs_file_system.n8n_data.id
  count = length(var.efs_subnet_ids)
  subnet_id       = var.efs_subnet_ids[count.index]

  security_groups = [var.efs_security_group_id]
}

# EFS access point for the container
resource "aws_efs_access_point" "n8n_access_point" {
  count = length(var.efs_subnet_ids)

  file_system_id = aws_efs_file_system.n8n_data.id
  
  posix_user {
    gid = 1000
    uid = 1000
  }
  
  root_directory {
    path = "/n8n"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "755"
    }
  }
  
  tags = merge(var.common_tags, {
    Name = "${var.environment}-EFS-${var.efs_name}-access-point"
  })
}