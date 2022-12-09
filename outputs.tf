output "vpc_cidr" {
  value = module.test.vpc_cidr
}

output "private_subnets" {
  value = module.test.private_subnets
}

output "public_subnets" {
  value = module.test.public_subnets
}

output "ec2_public_ip" {
  value = module.test.ec2_private_ip
}

#output "eks_cluster_cert" {
#  value = module.test.eks_cluster_cert
#}
#
#output "eks_cluster_endpoint" {
#  value = module.test.eks_cluster_endpoint
#}
