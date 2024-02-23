terraform {
  source = "../../../../tf-modules/gcp/subnet//v1.0"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../global/vpc/husni-blog-resources"
}

locals {
  project_id = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals.project_id
  region     = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals.region
  resource_name     = "${basename(get_terragrunt_dir())}"
}

inputs = {
  project         = local.project_id
  vpc_name        = dependency.vpc.outputs.network_name
  subnet_name     = "${local.region}-${local.resource_name}"
  subnet_region   = local.region
  subnet_ip_range = "11.1.0.0/16"
}
