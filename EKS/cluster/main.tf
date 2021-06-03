provider "aws" {
  region = var.region
}

resource "aws_iam_role" "eks_cluster_role" {
  name = var.cluster_role_name

  assume_role_policy = file("${path.module}/eksAssumeRolePolicy.json")
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_policy" {
  policy_arn = var.cluster_policy_arn
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
  policy_arn = var.cluster_vpc_controller_policy_arn
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.20"

  vpc_config {
    subnet_ids = var.subnet_ids
  }
  enabled_cluster_log_types = ["api", "audit"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller
  ]
}

// Add-ons

resource "aws_eks_addon" "cni-addon" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "coredns-addon" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "coredns"
  addon_version = "v1.8.3-eksbuild.1"
}

resource "aws_eks_addon" "kube-proxy-addon" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "kube-proxy"
}
