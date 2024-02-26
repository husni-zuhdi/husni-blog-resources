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

output "name" {
  value       = google_compute_subnetwork.vpc_subnetwork.name
  description = "Name of created subnet"
}

output "ip_range" {
  value       = google_compute_subnetwork.vpc_subnetwork.ip_cidr_range
  description = "The IP range of created subnet"
}

output "self_link" {
  value       = google_compute_subnetwork.vpc_subnetwork.self_link
  description = "The self link of created subnet"
}
