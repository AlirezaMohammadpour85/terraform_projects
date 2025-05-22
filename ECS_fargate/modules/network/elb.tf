# This module creates an Application Load Balancer (ALB) in AWS.
resource "aws_lb" "OT367_alb" {
  name                             = "${var.environment}-${var.project_name}-alb"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [var.OT367_elb_sg.id]
  subnets                          = [aws_subnet.OT367_public_subnet_1.id, aws_subnet.OT367_public_subnet_2.id] # Add more if needed (e.g. AZ redundancy)
  enable_cross_zone_load_balancing = true
  tags = merge(var.common_tags, {
    Name = "${var.environment}-${var.project_name}-alb"
  })
}
# This module creates a Target Group for the Application Load Balancer (ALB).
resource "aws_lb_target_group" "OT367_target_group" {
  name     = "OT367-target-group"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = aws_vpc.OT367_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "8000"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = merge(var.common_tags, {
    Name = "OT367-TG"
  })
}

# Attach EC2 Instances to the Target Group
resource "aws_lb_target_group_attachment" "OT367_tg_attachment" {
  target_group_arn = aws_lb_target_group.OT367_target_group.arn
  target_id        = var.OT367_ec2_instance_info.id
  port             = 8000
}


resource "aws_route53_record" "alb_alias_record" {
  zone_id = var.OT367_alb_zone_id
  name    = "airbyte.service.domotz.app"
  type    = "A"

  alias {
    name                   = aws_lb.OT367_alb.dns_name
    zone_id                = aws_lb.OT367_alb.zone_id
    evaluate_target_health = true
  }


}

# This module creates a Listener for the Application Load Balancer (ALB). HTTPS listerner port:443
resource "aws_lb_listener" "OT367_listener" {
  load_balancer_arn = aws_lb.OT367_alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.acm_certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.OT367_target_group.arn
  }
  tags = merge(var.common_tags, {
    Name = "OT367-Listener"
  })
}
# This module creates a Listener for the Application Load Balancer (ALB). HTTP listerner port:8000
# resource "aws_lb_listener" "OT367_listener" {
#   load_balancer_arn = aws_lb.OT367_alb.arn
#   port              = 8000
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.OT367_target_group.arn
#   }
# }
