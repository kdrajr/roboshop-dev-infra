resource "aws_instance" "frontend" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.frontend_sg_id]
  subnet_id = local.public_subnet_id

  tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-frontend"
    }
  )
}


resource "terraform_data" "frontend" {
  triggers_replace =  [aws_instance.frontend.id]
    
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = local.ec2-user_pass
    host     = aws_instance.frontend.public_ip
  }

  provisioner "file" {
  source      = "frontend.sh"
  destination = "/tmp/frontend.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/frontend.sh",
      "sudo sh /tmp/frontend.sh frontend ${var.environment}"

    ]
  }
}

resource "aws_ec2_instance_state" "frontend" {
  instance_id = aws_instance.frontend.id
  state       = "stopped"

  depends_on = [terraform_data.frontend]
}

resource "aws_ami_from_instance" "frontend" {
  name               = "${local.common_name_prefix}-frontend-ami"
  source_instance_id = aws_instance.frontend.id

  depends_on = [aws_ec2_instance_state.frontend]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-frontend-ami"
    }
  )
}

resource "aws_launch_template" "frontend" {
  name = "${local.common_name_prefix}-frontend"
  image_id = aws_ami_from_instance.frontend.id
  instance_type = var.instance_type
  instance_initiated_shutdown_behavior = "terminate"
  vpc_security_group_ids = [local.frontend_sg_id]


  tag_specifications {
    resource_type = "instance"

    tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-frontend"
    }
  )
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(
    var.volume_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-frontend"
    }
  )
  }

  tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name_prefix}-frontend"
      }
  )

}


resource "aws_lb_target_group" "frontend" {
  name     = "${local.common_name_prefix}-frontend"
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  deregistration_delay = 60

  health_check {
    path = "/health"
    protocol = "HTTP"
    port = 80
    matcher = "200-299"
    interval = 10
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 3
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-frontend"
    }
  )
}

resource "aws_autoscaling_group" "frontend" {
  name = "${local.common_name_prefix}-frontend"
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  vpc_zone_identifier = local.public_subnet_ids
  health_check_type = "ELB"
  health_check_grace_period = 60
  target_group_arns = [aws_lb_target_group.frontend.arn]
  

  launch_template {
    id      = aws_launch_template.frontend.id
    version = aws_launch_template.frontend.latest_version
  }

  timeouts {
    delete = "15m"
  }

  dynamic "tag" {
    for_each = merge(
      local.common_tags,
      {
        Name = "${local.common_name_prefix}-frontend"
      }
    )
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true      
    }
  }
}

resource "aws_autoscaling_policy" "frontend" {
  name = "${local.common_name_prefix}-frontend"
  autoscaling_group_name = aws_autoscaling_group.frontend.name
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75.0
  }

}



resource "aws_lb_listener_rule" "frontend-lb_frontend" {
  listener_arn = local.frontend-alb_listener_arn
  priority = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }

  condition {
    host_header {
      values = ["${var.environment}.${var.domain_name}"] # dev.sniggie.fun
    }
  }

  tags = {
    Name = "${local.common_name_prefix}-frontend"
  }
}


resource "terraform_data" "terminate_frontend_instance" {
    triggers_replace = [aws_instance.frontend.id]

    provisioner "local-exec" {
      command = "aws ec2 terminate-instances --instance-ids ${aws_instance.frontend.id}"
    }
    depends_on = [aws_autoscaling_policy.frontend]
}



