variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "sg_names" {
  type = list
  default = [
    # databases
    "mongodb", "mysql", "redis", "rabbitmq",
    # backend
    "catalogue", "user", "cart", "shipping", "payment",
    # frontend
    "frontend",
    # bastion
    "bastion",
    # frontend load balancer
    "frontend-alb",
    # backend application load balancer
    "backend-alb"
  ]
}
variable "sg_tags" {
  type    = map
  default = {}
}