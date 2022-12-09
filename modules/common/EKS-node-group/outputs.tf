output "ng_id" {
  value = aws_eks_node_group.default_node.id
}

output "ng_arn" {
  value = aws_eks_node_group.default_node.arn
}
