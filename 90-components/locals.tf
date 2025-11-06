locals {
  ami_id = data.aws_ami.devops.id
/*   vpc_id  = data.aws_ssm_parameter.vpc_id.value
  backend-alb_listener_arn = data.aws_ssm_parameter.backend-alb_listener_arn.value
  component_sg_id = data.aws_ssm_parameter.component_sg_id.value
  private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  zone_id = data.aws_route53_zone.sniggie.zone_id */
  ec2-user_pass = data.aws_ssm_parameter.ec2-user_pass.value
  
  
  common_name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project = var.project_name
    Environment = var.environment
    Terraform = "true"
  }
}