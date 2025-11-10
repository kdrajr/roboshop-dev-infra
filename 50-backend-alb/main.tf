module "backend_alb" {
  #source = "../../roboshop-terraform-modules/alb"
  source = "git::https://github.com/kdrajr/roboshop-terraform-modules.git//alb?ref=main"
  is_it_internal = true
  enable_deletion_protection = false
}
























/* resource "aws_lb" "backend_alb" {
  name               = "${local.common_name_prefix}-backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend-alb_sg_id]
  subnets            = local.private_subnet_ids

  enable_deletion_protection = true


  tags = merge(
    var.backend-alb_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-backend-alb"
    }
  )
}


resource "aws_lb_listener" "backend_alb" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hello, I am from ${local.common_name_prefix}-backend-alb"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "backend_alb" {
  zone_id = local.zone_id
  name    = "*.backend-alb-${var.environment}.${var.domain_name}"
  type    = "A"
  alias {
    name                   = aws_lb.backend_alb.dns_name
    zone_id                = aws_lb.backend_alb.zone_id
    evaluate_target_health = true
  }
  allow_overwrite = true
}


 */