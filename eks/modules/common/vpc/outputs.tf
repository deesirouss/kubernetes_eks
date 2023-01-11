output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "private_route_tb_id" {
  value = aws_route_table.private.id
}

output "public_route_tb_id" {
  value = aws_route_table.public.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet.*.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "igw_id" {
  value = aws_internet_gateway.ig.id
}

output "vpc_security_group_id" {
  value = aws_vpc.vpc.default_security_group_id
}
