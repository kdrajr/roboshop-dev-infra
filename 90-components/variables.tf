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

variable "components" {
  default = {
    catalogue = {rule_priority = 10}
    cart = {rule_priority = 20}
    user = {rule_priority = 30}
    shipping = {rule_priority = 40}
    payment = {rule_priority = 50}
    frontend = {rule_priority = 10}
  }
}

variable "asg_desired_capacity" {
  default = 1
}

variable "asg_max_size" {
  default = 5
}

variable "asg_min_size" {
  default = 1
}

variable "ec2_tags" {
  default = {}
}

variable "volume_tags" {
  default = {}
}



