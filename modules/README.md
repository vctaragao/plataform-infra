# Terraform Modules

Reusable Terraform modules for the infrastructure managed in this repository.

Current modules:
- `gcp/project-services`: manages the set of enabled Google APIs for a project
- `gcp/service-account`: manages one or more Google service accounts
- `gcp/artifact-registry`: manages a single Artifact Registry repository
- `gcp/gke-cluster`: manages the shared GKE cluster used by this repo

Modules are consumed from `live/` stacks only. Avoid running Terraform directly from module directories except for `terraform validate`.
