variable "cluster_name" {
  default = "cluster"
  type = string
}

variable "cluster_role_name" {
  default = "cluster_role"
  type = string
}

variable "cluster_policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  type = string
}

variable "cluster_vpc_controller_policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  type = string
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-035ed092060e24e01", "subnet-0dcc19b37750b433f", "subnet-02bb9092399790b5a"]
}

