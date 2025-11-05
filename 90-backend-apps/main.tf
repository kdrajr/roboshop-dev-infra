module "user" {
  #source = "../../roboshop-terraform-modules/backend-app"
  source = "git::https://github.com/kdrajr/roboshop-terraform-modules.git//backend-app?ref=main"
  ami_id = local.ami_id
  instance_type = var.instance_type
  component = var.component 
  component_sg_id = local.user_sg_id
  vpc_id = local.vpc_id
  private_subnet_id = local.private_subnet_id
  private_subnet_ids = local.private_subnet_ids
  ec2-user_pass = local.ec2-user_pass
  backend-alb_listener_arn = local.backend-alb_listener_arn

}














































######################### user setup without module ##############################

/* resource "aws_instance" "user" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.user_sg_id]
  subnet_id = local.private_subnet_id

  tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-user"
    }
  )
}


resource "terraform_data" "user" {
  triggers_replace =  [aws_instance.user.id]
    
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = local.ec2-user_pass
    host     = aws_instance.user.private_ip
  }

  provisioner "file" {
  source      = "user.sh"
  destination = "/tmp/user.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/user.sh",
      "sudo sh /tmp/user.sh user ${var.environment}"

    ]
  }
}

resource "aws_ec2_instance_state" "user" {
  instance_id = aws_instance.user.id
  state       = "stopped"

  depends_on = [terraform_data.user]
}

resource "aws_ami_from_instance" "user" {
  name               = "${local.common_name_prefix}-user-ami"
  source_instance_id = aws_instance.user.id

  depends_on = [aws_ec2_instance_state.user]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-user-ami"
    }
  )
}

resource "aws_launch_template" "user" {
  name = "${local.common_name_prefix}-user"
  image_id = aws_ami_from_instance.user.id
  instance_type = var.instance_type
  instance_initiated_shutdown_behavior = "terminate"
  vpc_security_group_ids = [local.user_sg_id]


  tag_specifications {
    resource_type = "instance"

    tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-user"
    }
  )
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(
    var.volume_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-user"
    }
  )
  }

  tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name_prefix}-user"
      }
  )

}


resource "aws_lb_target_group" "user" {
  name     = "${local.common_name_prefix}-user"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  deregistration_delay = 60

  health_check {
    path = "/health"
    protocol = "HTTP"
    port = 8080
    matcher = "200-299"
    interval = 10
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 3
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-user"
    }
  )
}

resource "aws_autoscaling_group" "user" {
  name = "${local.common_name_prefix}-user"
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  vpc_zone_identifier = local.private_subnet_ids
  health_check_type = "ELB"
  health_check_grace_period = 60
  target_group_arns = [aws_lb_target_group.user.arn]
  

  launch_template {
    id      = aws_launch_template.user.id
    version = aws_launch_template.user.latest_version
  }

  timeouts {
    delete = "15m"
  }

  dynamic "tag" {
    for_each = merge(
      local.common_tags,
      {
        Name = "${local.common_name_prefix}-user"
      }
    )
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true      
    }
  }
}

resource "aws_autoscaling_policy" "user" {
  name = "${local.common_name_prefix}-user"
  autoscaling_group_name = aws_autoscaling_group.user.name
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75.0
  }

}



resource "aws_lb_listener_rule" "backend_user" {
  listener_arn = local.backend-alb_listener_arn
  priority = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.user.arn
  }

  condition {
    host_header {
      values = ["user.backend-alb-${var.environment}.${var.domain_name}"]
    }
  }

  tags = {
    Name = "${local.common_name_prefix}-user"
  }
}


resource "terraform_data" "terminate_user_instance" {
    triggers_replace = [aws_instance.user.id]

    provisioner "local-exec" {
      command = "aws ec2 terminate-instances --instance-ids ${aws_instance.user.id}"
    }
    depends_on = [aws_autoscaling_policy.user]
}



 */