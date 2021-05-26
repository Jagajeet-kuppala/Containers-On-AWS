provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "nginx-server" {
  name                 = "server"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
  }
}

resource "aws_ecr_lifecycle_policy" "imageCountTwo" {
  repository = aws_ecr_repository.nginx-server.name

  policy = file("${path.module}/lifeCyclePolicy.json")
}

