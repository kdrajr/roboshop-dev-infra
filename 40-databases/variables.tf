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

variable "database" {
  default = ["mongodb","redis","rabbitmq"]
}

variable "ec2_tags" {
  default = {}
}
