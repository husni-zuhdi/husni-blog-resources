terraform {
  source = "../../../../tf-modules/gcp/router//v1.0"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../global/vpc/husni-blog-resources"
}

locals {
  project_id    = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl")).locals.project_id
  region        = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals.region
  resource_name = "${basename(get_terragrunt_dir())}"
}

inputs = {
  project = "${local.project_id}"
  name    = "${local.resource_name}-${local.region}"
  region  = "${local.region}"
  network = dependency.vpc.outputs.network_name
  nats = [{
    name                               = "nat-${local.region}"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
    nat_ip_allocate_option             = "AUTO_ONLY"
    log_config = {
      enable = false
      filter = "ERRORS_ONLY"
    }
  }]
}
