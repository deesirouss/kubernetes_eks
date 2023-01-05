locals {
  stage = "prod-eks-test"
  tags = {
    Name      = join("-", [var.environment, local.stage])
    Creator   = var.environment
    Project   = "DocVocate"
    Deletable = "false"
  }
}
