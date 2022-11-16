# VPC ID
output "vpc_cidr" {
  value = module.vpc_demo.vpc_cidr_block
}

# VPC Private Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc_demo.private_subnet_ids
}

# VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc_demo.public_subnet_ids
}

# Private Route TB ID
output "private_route_table_id" {
  value = module.vpc_demo.private_route_tb_id
}

# Public Route TB ID
output "public_route_table_id" {
  value = module.vpc_demo.public_route_tb_id
}

# IG ID
output "igw_id" {
  value = module.vpc_demo.igw_id
}

output "ec2_private_ip" {
  value = module.dev_ec2.public_ip
}
