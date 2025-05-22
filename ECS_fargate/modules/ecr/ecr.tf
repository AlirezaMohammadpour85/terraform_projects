# use one ecr, different tags for different images
## Container registry for the service's Docker image
########################################################################################################################
resource "aws_ecr_repository" "domotz_repo" {
  name                 = "${lower(var.environment)}/${lower(var.ecr_repo_name)}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(var.common_tags, {
    Name = "${var.environment}-${var.project_name}-${var.ecr_repo_name}"
  })

}
