variable "cluster_name" {
  default = "cluster"
  type = string
}

variable "node_group_name" {
  default = "demo_node_group"
  type = string
}

variable "subnet_ids" {
  default = ["subnet-035ed092060e24e01", "subnet-0dcc19b37750b433f", "subnet-02bb9092399790b5a"]
  type    = list(string)
}

variable "node_instance_types" {
  default = ["t3.small"]
  type    = list(string)
}

variable "node_ami_type" {
  default = "AL2_x86_64"
  type = string
}
