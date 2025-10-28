locals {
  common_name_prefix = "${var.project_name}-${var.environment}"
  vpc_id             = data.aws_ssm_parameter.vpc_id.value
  sg_ids = flatten(module.sg[*].sg_ids)
}