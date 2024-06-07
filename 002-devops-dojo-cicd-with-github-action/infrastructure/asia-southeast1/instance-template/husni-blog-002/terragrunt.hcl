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
  image_name    = "gcr.io/${local.project_id}/${local.base_name}:v1.0.1"
}

inputs = {
  project_id           = local.project_id
  region               = local.region
  name_prefix          = "${local.base_name}-${local.resource_name}"
  machine_type         = "f1-micro"
  subnetwork           = dependency.subnetwork.outputs.self_link
  disk_size_gb         = 10
  disk_type            = "pd-standard"
  source_image_project = "cos-cloud"
  source_image_family  = "cos-stable"
  tags                 = ["${local.base_name}"]
  labels = {
    goog-ops-agent-policy = "v2-x86-template-1-1-0"
    container-vm          = "cos-stable-109-17800-0-51"
  }
  service_account = {
    email  = "423802482870-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
  metadata = {
    "gce-container-declaration" = <<EOF
spec:
  containers:
  - image: "${local.image_name}"
    name: ${local.base_name}
    env:
    - name: "SVC_ENDPOINT"
      value: "127.0.0.1"
    - name: "SVC_PORT"
      value: "8080"
  volumes: []
  restartPolicy: Never
    EOF
  }
}
