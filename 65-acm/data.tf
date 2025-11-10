data "aws_route53_zone" "sniggie" {
      name = var.domain_name 
}