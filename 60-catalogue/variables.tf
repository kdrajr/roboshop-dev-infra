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

variable "catalogue_target-grp_tags" {
  default = {}
}

variable "asg_tags" {
  default = [
    {
      key                 = "Name"
      value               = "${local.common_name_prefix}-catalogue"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "roboshop"
      propagate_at_launch = true
    },
  ]
}
