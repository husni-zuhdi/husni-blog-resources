terraform {
  source = "../../../../../tf-modules/gcp/instance-template//v1.0"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "subnetwork" {
  config_path = "../../../../../000-main-infrastructure/infrastructure/asia-southeast1/subnet"
}

locals {
  project_id    = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl")).locals.project_id
  region        = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals.region
  base_name     = "${basename(get_terragrunt_dir())}"
  resource_name = "${basename(dirname(get_terragrunt_dir()))}"
}

inputs = {
  project_id           = local.project_id
  region               = local.region
  name_prefix          = "${local.base_name}-${local.resource_name}-001"
  machine_type         = "e2-medium"
  subnetwork           = dependency.subnetwork.outputs.self_link
  disk_size_gb         = 10
  disk_type            = "pd-standard"
  source_image_project = "debian-cloud"
  source_image_family  = "debian-10"
  tags                 = ["${local.base_name}"]
  labels = {
    goog-ops-agent-policy = "v2-x86-template-1-1-0"
  }
  service_account = {
    email  = "423802482870-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}
