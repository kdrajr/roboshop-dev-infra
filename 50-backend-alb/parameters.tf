resource "aws_ssm_parameter" "backend-alb_listener_arn" {
  name  = "/${var.project_name}/${var.environment}/backend-alb_listener_arn"
  type  = "String"
  #value = aws_lb_listener.backend_alb.arn
  value = module.backend_alb.alb_listener_arn
  overwrite = true
}
