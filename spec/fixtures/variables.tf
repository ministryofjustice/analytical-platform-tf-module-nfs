provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::525294151996:role/read-only-dev"
  }
}

variable "vpc_id" {}

variable "refresh_token" {
  default = "refresh_token"
}

variable "cidr_blocks" {
  type = "list"
  default = [
    "0.0.0.0/0",
    "127.0.0.1/32",
    "255.255.255.255/32",
  ]
}

variable "ansible_provision_file" {
  default = "occm_setup.yaml"
}

variable "subnet_id" {}

variable "zone_id" {}

variable "key_pair" {
  default = "key_pair"
}

variable "portal_user_name" {
  default = "portal_user_name"
}

variable "profile" {
  default = "dev"
}

variable "policy_path" {
  default = "../../iam_occm_policy.json"
}
