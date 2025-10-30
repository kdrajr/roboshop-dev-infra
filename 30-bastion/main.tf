resource "aws_instance" "bastion" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_id

  tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-bastion"
    }
  )
}

resource "terraform_data" "bastion" {
  triggers_replace =  [aws_instance.bastion.id]
    
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = local.ec2-user_pass
    host     = aws_instance.bastion.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y yum-utils",
      "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo",
      "sudo yum -y install terraform"

    ]
  }
}