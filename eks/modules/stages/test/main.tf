data "aws_availability_zones" "default" {}

#############
# VPC
#############

module "vpc_demo" {
  source = "../../common/vpc"
  providers = {
    aws = aws.nvirginia
  }
  environment              = "bipin"
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
  ec2_instance_name       = "bipin_bastion_host"
  ec2_instance_type       = "t3.medium"
  ami_id                  = "ami-0753e0e42b20e96e3"
  ec2_security_group_name = join("-", [local.stage, var.environment])
  vpc_id                  = module.vpc_demo.vpc_id
  subnet_id               = module.vpc_demo.public_subnet_ids[0]
  enable_elastic_ip       = true
  key_name                = var.key_name
  is_bastion              = true
  tags                    = local.tags
}

module "launch_template" {
  source        = "../../common/launch_template"
  instance_type = "t3.medium"
  ami_id        = "ami-0753e0e42b20e96e3"
}

module "eks_workers" {
  source = "./modules/eks-workers"

  namespace                          = "prod-test"
  stage                              = local.stage
  name                               = "vyaguta"
  instance_type                      = "t3.medium"
  vpc_id                             = module.vpc_demo.vpc_id
  subnet_ids                         = module.vpc_demo.private_subnet_ids
  min_size                           = 2
  max_size                           = 5
  cluster_name                       = module.eks_cluster_private.cluster_name
  cluster_endpoint                   = module.eks_cluster.eks_cluster_endpoint
  cluster_certificate_authority_data = module.eks_cluster.eks_cluster_certificate_authority_data
  cluster_security_group_id          = module.eks_cluster.security_group_id
  use_custom_image_id                = true
  image_id                           = "ami-0753e0e42b20e96e3"

  # Auto-scaling policies and CloudWatch metric alarms
  tags                                   = local.tags

  # Bastion configuration
#  allow_bastion_ingress     = true
#  bastion_security_group_id = module.bastion_hosts.bastion_security_group_id
}


module "eks_cluster" {
  source = "../../common/eks-cluster"

  stage              = local.stage
  namespace          = "prod-vyaguta"
  name               = "private-cluster"
  region             = "ap-southeast-1"
  vpc_id             = module.vpc_demo.vpc_id
  subnet_ids         = module.vpc_demo.private_subnet_ids
  kubernetes_version = "1.24"

  # `workers_security_group_count` is needed to prevent `count can't be computed` errors
  workers_security_group_ids = [
  module.eks_workers.security_group_id]
  workers_security_group_count = 1

  workers_role_arns      = [module.eks_workers.workers_role_arn]
  tags                   = local.tags
}
