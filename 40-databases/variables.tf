variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "domain_name" {
  default = "sniggie.fun"
}

variable "db-components" {
  default = {
    mongodb = null
    redis = null
    rabbitmq = null
    mysql = null
  }
}

variable "ec2_tags" {
  default = {}
}
