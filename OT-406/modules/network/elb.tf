########################################################################################################################
## Application Load Balancer
########################################################################################################################
resource "aws_lb" "main" {
  name                       = "${var.common_tags["project"]}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.elb_sg.id]
  subnets                    = aws_subnet.public[*].id
  enable_deletion_protection = true
  enable_http2              = true
  
  enable_cross_zone_load_balancing = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-alb"
    }
  )
}

########################################################################################################################
## Target Group
########################################################################################################################
resource "aws_lb_target_group" "main" {
  name     = "${var.common_tags["project"]}-tg"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200"
    port                = "8000"
    protocol            = "HTTP"
  }

  deregistration_delay = 30

  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-tg"
    }
  )
}

########################################################################################################################
## Target Group Attachment
########################################################################################################################
resource "aws_lb_target_group_attachment" "main" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = var.ec2_instance_info.id
  port             = 8000
}

########################################################################################################################
## HTTPS Listener
########################################################################################################################
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.common_tags["project"]}-https-listener"
    }
  )
}

########################################################################################################################
## HTTP to HTTPS Redirect Listener
########################################################################################################################
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# ########################################################################################################################
# ## Route53 DNS Record
# ########################################################################################################################
# resource "aws_route53_record" "alb" {
#   zone_id = var.alb_zone_id
#   name    = "${var.common_tags["project"]}.service.domotz.app"
#   type    = "A"

#   alias {
#     name                   = aws_lb.main.dns_name
#     zone_id                = aws_lb.main.zone_id
#     evaluate_target_health = true
#   }
# }