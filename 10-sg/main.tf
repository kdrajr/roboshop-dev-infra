module "sg" {
  count = length(var.sg_names)
  source = "../../terraform-aws-sg"
  project_name = var.project_name
  environment = var.environment
  sg_name = "${local.common_name_prefix}-${var.sg_names[count.index]}"
  sg_description = "Created for ${var.sg_names[count.index]}"
  vpc_id = local.vpc_id
}


/* module "catalogue" {
  source = "terraform-aws-modules/security-group/aws"
  use_name_prefix = false
  name        = "${local.common_name_prefix}-catalogue"
  description = "Security group for catalogue with custom ports open within VPC, and egress all traffic"
  vpc_id      = local.vpc_id

} */