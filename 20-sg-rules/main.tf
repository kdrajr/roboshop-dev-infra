## Laptop(internet) to Bastion sg rule
resource "aws_security_group_rule" "bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.bastion_sg_id
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

## Bastion to user sg rule
resource "aws_security_group_rule" "user_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.user_sg_id
  source_security_group_id = local.bastion_sg_id  
}

## Bastion to cart sg rule
resource "aws_security_group_rule" "cart_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.cart_sg_id
  source_security_group_id = local.bastion_sg_id  
}

## Bastion to shipping sg rule
resource "aws_security_group_rule" "shipping_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.shipping_sg_id
  source_security_group_id = local.bastion_sg_id  
}

## Bastion to payment sg rule
resource "aws_security_group_rule" "payment_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.payment_sg_id
  source_security_group_id = local.bastion_sg_id  
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
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = local.catalogue_sg_id
  source_security_group_id = local.backend-alb_sg_id
}

## backend-alb to user sg rule
resource "aws_security_group_rule" "user_backend-alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = local.user_sg_id
  source_security_group_id = local.backend-alb_sg_id
}

## backend-alb to cart sg rule
resource "aws_security_group_rule" "cart_backend-alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = local.cart_sg_id
  source_security_group_id = local.backend-alb_sg_id
}

## backend-alb to shipping sg rule
resource "aws_security_group_rule" "shipping_backend-alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = local.shipping_sg_id
  source_security_group_id = local.backend-alb_sg_id
}


## backend-alb to payment sg rule
resource "aws_security_group_rule" "payment_backend-alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = local.payment_sg_id
  source_security_group_id = local.backend-alb_sg_id
}


## payment to rabbitmq sg rule
resource "aws_security_group_rule" "rabbitmq_payment" {
  type              = "ingress"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  security_group_id = local.rabbitmq_sg_id
  source_security_group_id = local.payment_sg_id
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

## user to mongodb sg rule
resource "aws_security_group_rule" "mongodb_user" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = local.mongodb_sg_id
  source_security_group_id = local.user_sg_id
}

## user to redis sg rule
resource "aws_security_group_rule" "redis_user" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  security_group_id = local.redis_sg_id
  source_security_group_id = local.user_sg_id
}

## cart to redis sg rule
resource "aws_security_group_rule" "redis_cart" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  security_group_id = local.redis_sg_id
  source_security_group_id = local.cart_sg_id
}

## cart to backend-alb(for catalogue) sg rule
resource "aws_security_group_rule" "backend-alb_cart" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = local.backend-alb_sg_id
  source_security_group_id = local.cart_sg_id
}

## shipping to backend-alb(for cart) sg rule
resource "aws_security_group_rule" "backend-alb_shipping" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = local.backend-alb_sg_id
  source_security_group_id = local.shipping_sg_id
}

## shipping to mysql sg rule
resource "aws_security_group_rule" "mysql_shipping" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = local.mysql_sg_id
  source_security_group_id = local.shipping_sg_id
}

## payment to backend-alb(for cart, user) sg rule
resource "aws_security_group_rule" "backend-alb_payment" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = local.backend-alb_sg_id
  source_security_group_id = local.payment_sg_id
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

