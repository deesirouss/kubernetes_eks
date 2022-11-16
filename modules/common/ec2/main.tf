resource "aws_iam_role" "ec2" {
  name               = var.ec2_instance_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = var.tags
}

resource "aws_iam_instance_profile" "ec2" {
  name = var.ec2_instance_name
  role = aws_iam_role.ec2.name
}

resource "aws_security_group" "ec2" {
  name        = var.ec2_security_group_name
  description = var.ec2_security_group_description
  vpc_id      = var.vpc_id
  tags        = var.tags

  ingress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
    cidr_blocks = var.ec2_cidr_blocks
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = var.is_bastion ? ["0.0.0.0/0"] : var.ec2_cidr_blocks
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "image" {
  most_recent = true

  filter {
    name   = "name"
    values = var.image_filter_values
  }

  filter {
    name   = "virtualization-type"
    values = var.virtualization_filter_values
  }

  owners = var.image_owners
}

resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.ec2_instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  ebs_optimized          = var.ebs_optimized
  user_data              = var.userdata
  tags                   = var.tags

  root_block_device {
    volume_size           = var.ec2_volume_size
    delete_on_termination = true
  }
  iam_instance_profile = aws_iam_instance_profile.ec2.name
}

resource "aws_eip" "elastic_ip" {
  count    = var.enable_elastic_ip ? 1 : 0
  tags     = var.tags
  instance = aws_instance.ec2.id
  vpc      = true
}
