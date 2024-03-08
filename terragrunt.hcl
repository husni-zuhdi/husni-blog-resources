locals {
  project_id    = "husni-development"
  region        = "asia-southeast-1"
  bucket        = "tfstate-bucket-as1hkb"
}

remote_state {
  backend = "gcs"
  config = {
    project  = local.project_id
    location = local.region
    bucket   = local.bucket
    prefix = "${path_relative_to_include()}/terraform.tfstate"
  }
}
