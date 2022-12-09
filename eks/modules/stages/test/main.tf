data "aws_availability_zones" "default" {}

#############
# VPC
#############

module "vpc_demo" {
  source = "../../common/vpc"
  providers = {
    aws = aws.nvirginia
  }
  environment              = "BIBEK"
  vpc_cidr                 = "172.11.0.0/16"
  availability_zones_names = data.aws_availability_zones.default.names
  stage                    = local.stage
  tags                     = local.tags
}

######################
# bastion ec2
######################

module "dev_ec2" {
  providers = {
    aws = aws.nvirginia
  }
  source                  = "../../common/ec2"
  ec2_instance_name       = "bibek_bastion_host"
  ami_id                  = "ami-08ad748ca6d229b62"
  ec2_security_group_name = join("-", [local.stage, var.environment])
  vpc_id                  = module.vpc_demo.vpc_id
  subnet_id               = module.vpc_demo.public_subnet_ids[0]
  enable_elastic_ip       = true
  key_name                = "bibek-lf-training"
  is_bastion              = true
  tags                    = local.tags
}

###########################
# EKS Cluster
###########################

#module "eks_cluster_public" {
#  providers = {
#    aws = aws.nvirginia
#  }
#  source              = "../../common/EKS"
#  stage               = local.stage
#  eks_cluster_name    = "eks-public"
#  tags                = local.tags
#  cluster_subnet_ids  = module.vpc_demo.public_subnet_ids
#}
#
############################
## EKS public node-grp
############################
#
#module "eks_ng_public" {
#  providers = {
#    aws = aws.nvirginia
#  }
#  source = "../../common/EKS-node-group"
#  tags = local.tags
#  stage = local.stage
#  eks_cluster_name = module.eks_cluster_public.cluster_name
#  eks_node_group_name = "${local.stage}-ng-public"
#  node_subnet_ids = module.vpc_demo.public_subnet_ids
#}
#
#module "eks_ng_private" {
#  providers = {
#    aws = aws.nvirginia
#  }
#  source = "../../common/EKS-node-group"
#  tags = local.tags
#  stage = local.stage
#  eks_cluster_name = module.eks_cluster_public.cluster_name
#  eks_node_group_name = "${local.stage}-ng-private"
#  node_subnet_ids = module.vpc_demo.private_subnet_ids
#}
