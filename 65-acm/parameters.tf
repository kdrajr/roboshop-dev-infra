resource "aws_ssm_parameter" "frontend-alb_cert_arn" {
  name  = "/${var.project_name}/${var.environment}/frontend-alb_cert_arn"
  type  = "String"
  value = aws_acm_certificate.roboshop.arn
  overwrite = true
}
