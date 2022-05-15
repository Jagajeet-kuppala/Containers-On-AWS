output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "vpc_arn" {
  value = aws_vpc.eks_vpc.arn
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet.*.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "eks_igw_id" {
  value = aws_internet_gateway.eks_igw.id
}

output "nat_epi" {
  value = aws_eip.elastic_ip.*.id
}

output "eks_nat_gw" {
  value = aws_nat_gateway.eks_nat_gw.*.id
}

output "private_route_table" {
  value = aws_route_table.private_subnet_route_table.id
}
