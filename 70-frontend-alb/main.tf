module "frontend_alb" {
  source = "../../roboshop-terraform-modules/alb"
  is_it_internal = false
  #enable_deletion_protection = false
}


































/* resource "aws_lb" "frontend_alb" {
  name               = "${local.common_name_prefix}-frontend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.frontend-alb_sg_id]
  subnets            = local.public_subnet_ids

  enable_deletion_protection = true


  tags = merge(
    var.frontend-alb_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-frontend-alb"
    }
  )
}


resource "aws_lb_listener" "frontend_alb" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hello, I am from ${local.common_name_prefix}-frontend-alb"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "frontend_alb" {
  zone_id = local.zone_id
  name    = "${var.environment}.${var.domain_name}" # dev.sniggie.fun
  type    = "A"
  alias {
    name                   = aws_lb.frontend_alb.dns_name
    zone_id                = aws_lb.frontend_alb.zone_id
    evaluate_target_health = true
  }
  allow_overwrite = true
}


 */