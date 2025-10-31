resource "aws_instance" "bastion" {
  ami = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_id
  iam_instance_profile = aws_iam_instance_profile.bastion.name
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  user_data = file("bastion.sh")

  tags = merge(
    var.ec2_tags,
    local.common_tags,
    {
      Name = "${local.common_name_prefix}-bastion"
    }
  )
}


resource "aws_iam_role" "bastion" {
  name = "BastionTerraformAdmin"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
})

  tags = {
    tag-key = "bastion"
  }
}

resource "aws_iam_role_policy_attachment" "bastion" {
  role      = aws_iam_role.bastion.name
  policy_arn = data.aws_iam_policy.AdministratorAccess.arn
}

resource "aws_iam_instance_profile" "bastion" {
  name = "bastion"
  role = aws_iam_role.bastion.name
}