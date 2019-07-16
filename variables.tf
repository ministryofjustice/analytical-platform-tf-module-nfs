provider "aws" {
  region = var.region

  profile = var.profile
  version = "~> 2.10"
}

provider "template" {
  version = "~> 2.1"
}

variable "subnet_id" {
  description = "Existing public subnet to deploy cloud manager on to"
}

variable "instance_type" {
  default = "t3.medium"
}
variable "key_pair" {
  description = "Name of your key-pair in aws"
}
variable "ansible_provision_file" {
  default     = "./occm_setup.yaml"
  description = "Path to ansible playbook file"
}
variable "refresh_token" {
  description = "Get it from: https://services.cloud.netapp.com/refresh-token"
}
variable "client_id" {
  default     = "Mu0V1ywgYteI6w1MbD15fKfVIUrNXGWC"
  description = "Application/Client ID in the NetApp Auth0 tenant"
}
variable "portal_user_name" {
  description = "Email address of the first admin user.  Note you need to have signed up here first: https://cloud.netapp.com"
}
variable "auth0_domain" {
  default     = "netapp-cloud-account.auth0.com"
  description = "NetApp's auth0 domain"
}
variable "region" {
  default = "eu-west-1"
}
variable "profile" {
  description = "Name of local aws credentials profile"
}

variable "policy_path" {
  description = "Path to IAM policy file for cloud manager"
  default = "assets/iam_occm_policy.json"
}

variable "name" {
  default = "occm"
}

variable "cidr_blocks" {
  type        = "list"
  description = "CIDR blocks you want to allow to connect to your Cloud Manager"
}

variable "zone_id" {
  description = "Route 53 Hosted Zone ID"
}

variable "vpc_id" {
  description = "Existing vpc id to deploy cloud manager into"
}

variable "tags" {
  type = "map"

  default = {
    business-unit = "Platforms"
    application   = "analytical-platform"
    is-production = true
    owner         = "analytical-platform:analytics-platform-tech@digital.justice.gov.uk"
  }
}
