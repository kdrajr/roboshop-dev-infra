locals {
  ami_id = data.aws_ami.devops.id
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  frontend-lb_listener_arn = data.aws_ssm_parameter.frontend-lb_listener_arn.value
  frontend_sg_id = data.aws_ssm_parameter.frontend_sg_id.value
  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
  public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
  ec2-user_pass = data.aws_ssm_parameter.ec2-user_pass.value
  zone_id = data.aws_route53_zone.sniggie.zone_id
  
  common_name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project = var.project_name
    Environment = var.environment
    Terraform = "true"
  }
}