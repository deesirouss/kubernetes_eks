resource "aws_eks_node_group" "default_node" {
  cluster_name    = var.eks_cluster_name
  node_group_name = "${var.stage}-${var.eks_node_group_name}"
  node_role_arn   = aws_iam_role.default_node.arn
  subnet_ids      = var.node_subnet_ids
  version         = var.eks_version
  ami_type        = var.node_ami_type
  capacity_type   = var.node_capacity_type
  disk_size       = var.node_disk_size
  instance_types  = var.node_instace_types
  remote_access {
    ec2_ssh_key = bipin-donot-touch
  }

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  update_config {
    max_unavailable = var.node_max_unavailable
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = var.tags
}

