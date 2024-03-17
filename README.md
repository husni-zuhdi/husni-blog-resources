# Husni Blog Resources
My technical blog resources repository. Feel free to read 📖

## Tools I use in this repo
* [Terraform](https://www.terraform.io/) with [tfenv](https://github.com/tfutils/tfenv) for version management
* [Terragrunt](https://terragrunt.gruntwork.io/) with [tgenv](https://github.com/cunymatthieu/tgenv) for version management
* [Taskfile](https://taskfile.dev/)
* [gcloud cli](https://cloud.google.com/sdk/gcloud)

## Articles
* [How to Setup Simple Kubernetes Cluster with GCE](./001-how-to-setup-simple-kubernetes-cluster-with-gce/README.md)

## Usage
1. Make sure to change `locals` section in [terragrunt.hcl](./terragrunt.hcl) with your Googe Cloud Storage Bucket.
2. Use Taskfile CLI to appy, plan, and destroy infra resources. Here is the example commands.
```bash
# List all task subcommands
task --list-all

# Plan all resources under ./000-main-infrastructure/infrastructure folder
task plan-all -- ./000-main-infrastructure/infrastructure
# Apply all resources under ./000-main-infrastructure/infrastructure folder
task apply-all -- ./000-main-infrastructure/infrastructure
# Destroy all resources under ./000-main-infrastructure/infrastructure folder
task destroy-all -- ./000-main-infrastructure/infrastructure

# Plan husni-blog-resources VPC resource
task plan -- ./000-main-infrastructure/infrastructure/global/vpc/husni-blog-resources
# Apply husni-blog-resources VPC resource
task apply -- ./000-main-infrastructure/infrastructure/global/vpc/husni-blog-resources
# Destroy husni-blog-resources VPC resource
task destroy -- ./000-main-infrastructure/infrastructure/global/vpc/husni-blog-resources
```
3. Create base infrastructure resources in [000-main-infrastructure](./000-main-infrastructure) folder
by execute this commmand from root repository.
```bash
task apply-all -- ./000-main-infrastructure/infrastructure/
```
