module "cloud_manager" {
  source = "../.."

  vpc_id        = var.vpc_id
  refresh_token = var.refresh_token
  cidr_blocks = var.cidr_blocks
  ansible_provision_file = var.ansible_provision_file
  subnet_id              = var.subnet_id
  zone_id                = var.zone_id
  key_pair               = var.key_pair
  portal_user_name       = var.portal_user_name
  profile                = var.profile
  policy_path = var.policy_path
}
