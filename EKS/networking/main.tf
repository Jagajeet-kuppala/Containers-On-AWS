provider "aws" {
  region = var.region
}

resource "aws_vpc" "eks_vpc" {
  cidr_block       = var.vpc_cidr_bloc
  # Your VPC must have DNS hostname and DNS resolution support.
  # Otherwise, your worker nodes cannot register with your cluster.
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "eks_vpc"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.availability_zones)
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.availability_zones)
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
}

resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count = length(var.availability_zones)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_subnet_route_table.id
}

resource "aws_eip" "elastic_ip" {
  count = length(var.availability_zones)

  depends_on = [aws_internet_gateway.eks_igw]
}

resource "aws_nat_gateway" "eks_nat_gw" {
  count = length(var.availability_zones)
  allocation_id = aws_eip.elastic_ip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  depends_on = [
    aws_internet_gateway.eks_igw
  ]
}

resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  dynamic route  {
    for_each = aws_nat_gateway.eks_nat_gw
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = route.value.id
    }
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count = length(var.availability_zones)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_subnet_route_table.id
}
