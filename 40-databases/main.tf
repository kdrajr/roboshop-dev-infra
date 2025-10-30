resource "aws_instance" "database" {
  count = length(var.database)
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id = local.database_subnet_id

  tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-${var.database}"
    }
  )
}

resource "terraform_data" "database" {
  count = length(var.database)
  triggers_replace =  [aws_instance.database[count.index].id]
    
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.database[count.index].private_ip
  }

  provisioner "file" {
  source      = "bootstrap.sh"
  destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh ${var.database} ${var.environment}"

    ]
  }
}