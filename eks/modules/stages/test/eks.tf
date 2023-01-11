###########################
# EKS Cluster
###########################

module "eks_cluster_private" {
  providers = {
    aws = aws.nvirginia
  }
  source                          = "../../common/EKS"
  stage                           = local.stage
  eks_cluster_name                = "vyaguta"
  tags                            = local.tags
  cluster_subnet_ids              = module.vpc_demo.private_subnet_ids
  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true
}

############################
## EKS public node-grp
############################

module "eks_ng_public" {
  providers = {
    aws = aws.nvirginia
  }
  source              = "../../common/EKS-node-group"
  tags                = local.tags
  stage               = local.stage
  eks_cluster_name    = module.eks_cluster_private.cluster_name
  eks_node_group_name = "${local.stage}-ng-public"
  node_subnet_ids     = module.vpc_demo.public_subnet_ids
}

module "eks_ng_private" {
  providers = {
    aws = aws.nvirginia
  }
  source              = "../../common/EKS-node-group"
  tags                = local.tags
  stage               = local.stage
  eks_cluster_name    = module.eks_cluster_private.cluster_name
  eks_node_group_name = "${local.stage}-ng-private"
  node_subnet_ids     = module.vpc_demo.private_subnet_ids
}


