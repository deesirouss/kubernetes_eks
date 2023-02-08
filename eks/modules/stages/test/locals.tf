locals {
  secret_stage = "prod"
  stage = "prod-eks-test"
  tags = {
    Name      = join("-", [var.environment, local.stage])
    Creator   = var.environment
    "kubernetes.io/cluster/eks" = "owned"
    Project   = "DocVocate"
    Deletable = "false"
  }
}
