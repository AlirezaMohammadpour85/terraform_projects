# use one ecr, different tags for different images
resource "aws_ecr_repository" "domotz_repo" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(var.common_tags, {
    Name = "TestECR-" + var.ecr_repo_name
  })

}
