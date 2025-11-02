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

/* variable "backend" {
  default = ["catalogue","user","cart","shipping","payment"]
} */

variable "ec2_tags" {
  default = {}
}

variable "volume_tags" {
  default = {}
}



