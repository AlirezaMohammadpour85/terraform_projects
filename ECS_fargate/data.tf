# # Reference existing VPC
# data "aws_vpc" "existing_vpc" {
#   id = var.vpc_id
# }

# # Reference existing subnets
# data "aws_subnet" "public_subnet_1" {
#   id = var.public_subnet_1_id
# }

# data "aws_subnet" "public_subnet_2" {
#   id = var.public_subnet_2_id
# }

# # If there is an existing ALB that you want to use
# data "aws_lb" "existing_alb" {
#   count = var.use_existing_alb ? 1 : 0
#   name  = var.existing_alb_name
# }
# # If there is an existing ALB listener
# data "aws_lb_listener" "existing_http_listener" {
#   count             = var.use_existing_alb ? 1 : 0
#   load_balancer_arn = data.aws_lb.existing_alb[0].arn
#   port              = 80
# }