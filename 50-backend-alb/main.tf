resource "aws_lb" "backend_alb" {
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