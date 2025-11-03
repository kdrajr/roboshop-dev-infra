## Laptop(internet) to Bastion sg rule
resource "aws_security_group_rule" "bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.bastion_sg_id
}

## Bastion to mongodb sg rule
resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.mongodb_sg_id
  source_security_group_id = local.bastion_sg_id  
}

## Bastion to redis sg rule
resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.redis_sg_id
  source_security_group_id = local.bastion_sg_id  
}

## Bastion to mysql sg rule
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.mysql_sg_id
  source_security_group_id = local.bastion_sg_id  
}

## Bastion to catalogue sg rule
resource "aws_security_group_rule" "catalogue_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.catalogue_sg_id
  source_security_group_id = local.bastion_sg_id  
}

## Internet to frontend sg rule
resource "aws_security_group_rule" "frontend_internet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.frontend_sg_id
  cidr_blocks       = ["0.0.0.0/0"]  
}

## Bastion to rabbitmq sg rule
resource "aws_security_group_rule" "rabbitmq_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.rabbitmq_sg_id
  source_security_group_id = local.bastion_sg_id  
}

## Bastion to backend-alb sg rule
resource "aws_security_group_rule" "backend-alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = local.backend-alb_sg_id
  source_security_group_id = local.bastion_sg_id  
}

## backend-alb to catalogue sg rule
resource "aws_security_group_rule" "catalogue_backend-alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = local.catalogue_sg_id
  source_security_group_id = local.backend-alb_sg_id
}

## catalogue to mongodb sg rule
resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = local.mongodb_sg_id
  source_security_group_id = local.catalogue_sg_id  
}

## frontend-alb to frontend sg rule
resource "aws_security_group_rule" "frontend_frontend-alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = local.frontend_sg_id
  source_security_group_id = local.frontend-alb_sg_id
}

## Internet to frontend-alb sg rule
resource "aws_security_group_rule" "frontend-alb_internet" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = local.frontend-alb_sg_id
  cidr_blocks       = ["0.0.0.0/0"]  
}

## frontend to backend-alb sg rule
resource "aws_security_group_rule" "backend-alb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = local.backend-alb_sg_id
  source_security_group_id = local.frontend_sg_id
}

