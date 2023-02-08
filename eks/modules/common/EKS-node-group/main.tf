
resource "aws_eks_node_group" "default_node" {
  cluster_name    = var.eks_cluster_name
  node_group_name = "${var.eks_node_group_name}"
  node_role_arn   = aws_iam_role.default_node.arn
  version         = var.eks_version
  subnet_ids      = var.node_subnet_ids

  ami_type        = "CUSTOM"
  capacity_type   = var.node_capacity_type
  # disk_size       = var.node_disk_size
  # # instance_types  = var.node_instace_types
  # remote_access {
  #   ec2_ssh_key = var.ec2_ssh_key_name
  # }
  launch_template {
    name    = var.launch_template_name
    version = var.launch_template_version
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

