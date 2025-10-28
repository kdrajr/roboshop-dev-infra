resource "aws_instance" "bastion" {
  ami = local.ami_id
  instance_type = var.instance_type
  #vpc_security_group_ids = 
}