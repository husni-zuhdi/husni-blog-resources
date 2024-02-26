terraform {
  required_version = ">= 1.3"
  backend "gcs" {}
  required_providers {

    google = {
      source  = "hashicorp/google"
      version = ">= 4.51, < 6"
    }
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-cloud-router/v6.0.2"
  }

}
