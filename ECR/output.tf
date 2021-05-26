output "server_registry_arn" {
  value = aws_ecr_repository.nginx-server.arn
}
output "server_registry_id" {
  value = aws_ecr_repository.nginx-server.id
}
