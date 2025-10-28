module "vpc" {
  source = "git::https://github.com/kdrajr/terraform-aws-vpc.git?ref=main"
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  environment = var.environment
  pub_subnet_cidrs = var.pub_subnet_cidrs
  priv_subnet_cidrs = var.priv_subnet_cidrs
  db_subnet_cidrs = var.db_subnet_cidrs
  is_vpc_peering_required = true
  vpc_tags = var.vpc_tags
}


