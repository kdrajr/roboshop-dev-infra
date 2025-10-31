locals {
  ami_id = data.aws_ami.bastion.id
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
  common_name_prefix = "${var.project_name}-${var.environment}"
  public_subnet_id = split("," , data.aws_ssm_parameter.public_subnet_ids.value)[0]
  
  common_tags = {
    Project = var.project_name
    Environment = var.environment
    Terraform = "true"
  }
}


