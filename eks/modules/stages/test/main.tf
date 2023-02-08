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

  namespace                          = module.label.namespace
  stage                              = local.stage
  name                               = module.label.name
  attributes                         = var.attributes
  instance_type                      = var.instance_type
  vpc_id                             = module.vpc.vpc_id
  subnet_ids                         = module.subnets.private_subnet_ids
  associate_public_ip_address        = var.associate_public_ip_address
  health_check_type                  = var.health_check_type
  min_size                           = var.min_size
  max_size                           = var.max_size
  wait_for_capacity_timeout          = var.wait_for_capacity_timeout
  cluster_name                       = module.label.id
  cluster_endpoint                   = module.eks_cluster.eks_cluster_endpoint
  cluster_certificate_authority_data = module.eks_cluster.eks_cluster_certificate_authority_data
  cluster_security_group_id          = module.eks_cluster.security_group_id
  use_custom_image_id                = var.use_custom_image_id
  image_id                           = var.image_id

  # Auto-scaling policies and CloudWatch metric alarms
  autoscaling_policies_enabled           = var.autoscaling_policies_enabled
  cpu_utilization_high_threshold_percent = var.cpu_utilization_high_threshold_percent
  cpu_utilization_low_threshold_percent  = var.cpu_utilization_low_threshold_percent
  tags                                   = module.label.tags

  # Bastion configuration
  allow_bastion_ingress     = true
  bastion_security_group_id = module.bastion_hosts.bastion_security_group_id
}


module "eks_cluster" {
  source = "./modules/eks-cluster"

  stage              = module.label.stage
  namespace          = module.label.namespace
  name               = module.label.name
  attributes         = var.attributes
  region             = var.region
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.subnets.public_subnet_ids
  kubernetes_version = var.kubernetes_version

  # `workers_security_group_count` is needed to prevent `count can't be computed` errors
  workers_security_group_ids = [
  module.eks_workers.security_group_id]
  workers_security_group_count = 1

  workers_role_arns      = [module.eks_workers.workers_role_arn]
  bastion_host_role_arns = [module.bastion_hosts.bastion_host_role_arn]
  kubeconfig_path        = var.kubeconfig_path
  tags                   = module.label.tags
}
