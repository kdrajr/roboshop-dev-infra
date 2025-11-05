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

variable "component" {
  default = "user"
}

variable "rule_priority" {
  default = 20
}

variable "ec2_tags" {
  default = {}
}

variable "volume_tags" {
  default = {}
}



