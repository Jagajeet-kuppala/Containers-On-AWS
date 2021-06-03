output "node_group_arn" {
  value = aws_eks_node_group.node_group.arn
}

output "node_group_id" {
  value = aws_eks_node_group.node_group.id
}

output "node_group_resources" {
  value = aws_eks_node_group.node_group.resources
}
