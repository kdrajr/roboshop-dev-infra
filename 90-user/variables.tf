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

variable "ec2_tags" {
  default = {}
}

variable "volume_tags" {
  default = {}
}



