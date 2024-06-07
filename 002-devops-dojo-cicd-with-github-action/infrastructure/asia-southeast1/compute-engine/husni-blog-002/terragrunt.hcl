terraform {
  source = "../../../../../tf-modules/gcp/compute-engine//v1.0"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "subnetwork" {
  config_path = "../../../../../000-main-infrastructure/infrastructure/asia-southeast1/subnet"
}

dependency "instance_template" {
  config_path = "../../instance-template/husni-blog-002"
}

dependency "ip_address" {
  config_path = "../../ip-address/husni-blog-002-external"
}

locals {
  project_id    = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl")).locals.project_id
  region        = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals.region
  base_name     = "${basename(get_terragrunt_dir())}"
  resource_name = "${basename(dirname(get_terragrunt_dir()))}"
}

inputs = {
  project_id        = local.project_id
  region            = local.region
  zone              = "${local.region}-c"
  subnetwork        = dependency.subnetwork.outputs.self_link
  hostname          = "${local.base_name}-001"
  instance_template = dependency.instance_template.outputs.self_link
  num_instances     = 1
  access_config = [{
    nat_ip       = dependency.ip_address.outputs.addresses[0]
    network_tier = "PREMIUM"
  }]
}
