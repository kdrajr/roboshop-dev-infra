locals {
  common_name_prefix = "${var.project_name}-${var.environment}"
  zone_id = data.aws_route53_zone.sniggie.zone_id
  common_tags = {
    Project = var.project_name
    Environment = var.environment
    Terraform = "true"
  }
}