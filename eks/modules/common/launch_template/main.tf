resource "aws_launch_template" "vyaguta_eks_launch_template" {
  name          = "vyaguta_eks_lt"
  image_id      = var.ami_id
  instance_type = var.instance_type
  # key_name = var.bipin_key
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 50
    }
  }
  user_data     = filebase64("${path.module}/user_data.sh")
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "eks-node-group-instance-name"
      "kubernetes.io/cluster/eks" = "owned"
      Project = "vyaguta"
      Creator = "Vyaguta"
    }
  }
}
