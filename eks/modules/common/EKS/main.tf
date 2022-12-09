resource "aws_eks_cluster" "default" {
  name     = "${var.stage}-${var.eks_cluster_name}"
  role_arn = aws_iam_role.default.arn
  version  = var.eks_version
  tags     = var.tags

  vpc_config {
    subnet_ids              = var.cluster_subnet_ids
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_public_access_cidrs
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}
