terraform {
  source = "../../../../../tf-modules/gcp/ip-address//v1.0"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "subnet" {
  config_path = "../../../../../000-main-infrastructure/infrastructure/asia-southeast1/subnet"
}

locals {
  project_id    = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl")).locals.project_id
  region        = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals.region
  base_name     = "${basename(get_terragrunt_dir())}"
  resource_name = "${basename(dirname(get_terragrunt_dir()))}"
}

inputs = {
  project_id   = local.project_id
  region       = local.region
  address_type = "EXTERNAL"
  names        = ["${local.base_name}-${local.resource_name}"]
}
