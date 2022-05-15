variable "region" {
  default = "ap-south-1"
  type = string
}

variable "vpc_cidr_bloc" {
  default = "10.0.0.0/16"
  type = string
}

variable "eks_cluster_name" {
  default = "cluster"
  type = string
}

variable "private_subnet_cidr_blocks" {
  default = ["10.0.0.0/24", "10.0.1.0/24"]
  type = list(string)
}

variable "public_subnet_cidr_blocks" {
  default = ["10.0.2.0/24", "10.0.3.0/24"]
  type = list(string)
}

variable "availability_zones" {
  default = ["ap-south-1a", "ap-south-1b"]
  type  = list(string)
  description = "List of availability zones for the selected region"
}
