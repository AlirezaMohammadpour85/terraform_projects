########################################################################################################################
## SG for ECS Container Instances
########################################################################################################################
resource "aws_security_group" "ecs_container_instance" {
  name = "${var.environment}_ECS_Container_Instance_SG"
  description = "Security group for ECS task running on Fargate"
  # taken from output file in network module
  vpc_id = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to all on only port 8080
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to all on only port 8080
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "go-api-security-group"
  }
}