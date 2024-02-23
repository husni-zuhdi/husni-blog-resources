/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# Get VPC data
data "google_compute_network" "vpc" {
  project = var.project
  name    = var.vpc_name
}

# Create a subnet inside VPC network
resource "google_compute_subnetwork" "vpc_subnetwork" {
  project                  = var.project
  name                     = var.subnet_name
  ip_cidr_range            = var.subnet_ip_range
  region                   = var.subnet_region
  network                  = data.google_compute_network.vpc.id
  private_ip_google_access = true
}
