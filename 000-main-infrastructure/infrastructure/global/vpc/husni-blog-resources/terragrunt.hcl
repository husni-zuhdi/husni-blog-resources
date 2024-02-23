terraform {
  source = "../../../../../tf-modules/gcp/vpc//v1.0"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  project_id      = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals.project_id
  region          = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals.region
  base_name       = "${basename(get_terragrunt_dir())}"
  resource_name = "${basename(dirname(get_terragrunt_dir()))}"
  vpc_name        = format("%s-vpc-network", local.base_name)
}

inputs = {
  project  = local.project_id
  vpc_name = local.vpc_name

  enable_service_network_connection = false
  enable_svpc_connector = false
}
