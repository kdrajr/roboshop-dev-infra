resource "aws_ssm_parameter" "frontend-alb_listener_arn" {
  name  = "/${var.project_name}/${var.environment}/frontend-alb_listener_arn"
  type  = "String"
  #value = aws_lb_listener.frontend_alb.arn
  value = module.frontend_alb.alb_listener_arn
}
