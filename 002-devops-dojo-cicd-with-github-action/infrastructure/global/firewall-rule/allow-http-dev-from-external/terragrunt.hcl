terraform {
  source = "../../../../../tf-modules/gcp/firewall-rules//v1.0"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../../../../000-main-infrastructure/infrastructure/global/vpc/husni-blog-resources"
}

dependency "asia-southeast1-subnet" {
  config_path = "../../../../../000-main-infrastructure/infrastructure/asia-southeast1/subnet"
}

locals {
  project_id    = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl")).locals.project_id
  base_name     = "${basename(get_terragrunt_dir())}"
  firewall_name = "${local.base_name}-fw"
}

inputs = {
  project_id   = local.project_id
  network_name = dependency.vpc.outputs.network_name
  ingress_rules = [{
    name        = "${local.firewall_name}-001"
    description = "Allow access to http dev port from public"
    priority    = null
    source_ranges = [
      dependency.asia-southeast1-subnet.outputs.ip_range,
    ]
    source_tags             = null
    source_service_accounts = null
    target_tags             = ["husni-blog-002"]
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["8080"]
    }]
  }]
}
