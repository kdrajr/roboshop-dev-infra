resource "aws_instance" "catalogue" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id = local.private_subnet_id

  tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-catalogue"
    }
  )
}


resource "terraform_data" "catalogue" {
  triggers_replace =  [aws_instance.catalogue.id]
    
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = local.ec2-user_pass
    host     = aws_instance.catalogue.private_ip
  }

  provisioner "file" {
  source      = "catalogue.sh"
  destination = "/tmp/catalogue.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/catalogue.sh",
      "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"

    ]
  }
}

resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"

  depends_on = [terraform_data.catalogue]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${local.common_name_prefix}-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id

  depends_on = [aws_ec2_instance_state.catalogue]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-catalogue-ami"
    }
  )
}

resource "aws_launch_template" "catalogue" {
  name = "${local.common_name_prefix}-catalogue"
  image_id = aws_ami_from_instance.catalogue.id
  instance_type = var.instance_type
  instance_initiated_shutdown_behavior = "terminate"
  vpc_security_group_ids = [local.catalogue_sg_id]


  tag_specifications {
    resource_type = "instance"

    tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-catalogue"
    }
  )
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(
    var.volume_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-catalogue"
    }
  )
  }

  tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name_prefix}-catalogue"
      }
  )

}


resource "aws_lb_target_group" "catalogue" {
  name     = "${local.common_name_prefix}-catalogue"
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
      Name = "${local.common_name_prefix}-catalogue"
    }
  )
}

resource "aws_autoscaling_group" "catalogue" {
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  vpc_zone_identifier = local.private_subnet_ids
  health_check_type = "ELB"
  health_check_grace_period = 60
  target_group_arns = [aws_lb_target_group.catalogue.arn]
  

  launch_template {
    id      = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version
  }

  timeouts {
    delete = "15m"
  }

  dynamic "tag" {
    for_each = merge(
      local.common_tags,
      {
        Name = "${local.common_name_prefix}-catalogue"
      }
    )
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true      
    }
  }
}

resource "aws_autoscaling_policy" "catalogue" {
  name = "${local.common_name_prefix}-catalogue"
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75.0
  }

}



resource "aws_lb_listener_rule" "backend_catalogue" {
  listener_arn = local.lb_listener_arn
  priority = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  condition {
    host_header {
      values = ["catalogue.backend-alb-${var.environment}.${var.domain_name}"]
    }
  }

  tags = {
    Name = "${local.common_name_prefix}-catalogue"
  }
}


  resource "terraform_data" "terminate_catalogue_instance" {
      triggers_replace = [aws_instance.catalogue.id]

      provisioner "local-exec" {
        command = "aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id}"
      }
      depends_on = [aws_autoscaling_group.catalogue]
    }



