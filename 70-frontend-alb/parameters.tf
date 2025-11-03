resource "aws_ssm_parameter" "frontend-lb_listener_arn" {
  name  = "/${var.project_name}/${var.environment}/frontend-lb_listener_arn"
  type  = "String"
  value = aws_lb_listener.frontend_alb.arn
}
