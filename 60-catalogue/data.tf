data "aws_ami" "devops" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "lb_listener_arn" {
  name = "/${var.project_name}/${var.environment}/lb_listener_arn"
}

data "aws_ssm_parameter" "catalogue_sg_id" {
  name = "/${var.project_name}/${var.environment}/catalogue_sg_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${var.project_name}/${var.environment}/mongodb_sg_id"
}


data "aws_route53_zone" "sniggie" {
      name = var.domain_name 
}

data "aws_ssm_parameter" "ec2-user_pass" {
  name = "/roboshop/ec2-user"
}
