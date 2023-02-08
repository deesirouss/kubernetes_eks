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
