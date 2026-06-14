locals {
  project_id             = "teste-projet-496019"
  terraform_state_bucket = "teste-projet-496019-tf-state"
  github_actions_member  = "serviceAccount:github-actions-deployer@teste-projet-496019.iam.gserviceaccount.com"
  atlantis_gsa_email     = "atlantis-deployer@${local.project_id}.iam.gserviceaccount.com"
  atlantis_ksa_member    = "serviceAccount:${local.project_id}.svc.id.goog[default/atlantis]"

  service_accounts = {
    github-actions-deployer = {
      display_name = "github-actions-deployer"
      description  = "SA for github actions"
    }
    atlantis-deployer = {
      display_name = "atlantis-deployer"
      description  = "SA for Atlantis Terraform plans and applies"
    }
    google-sheets-mcp = {
      display_name = "google-sheets-mcp"
      description  = "Conta de serviço para se comunicar com google sheets"
    }
  }

  github_actions_project_roles = toset([
    "roles/browser",
    "roles/compute.viewer",
    "roles/iam.serviceAccountViewer",
    "roles/serviceusage.serviceUsageViewer",
  ])

  atlantis_project_roles = toset([
    "roles/artifactregistry.admin",
    "roles/compute.viewer",
    "roles/container.admin",
    "roles/iam.serviceAccountAdmin",
    "roles/serviceusage.serviceUsageAdmin",
  ])
}

module "service_accounts" {
  source = "../../../../modules/gcp/service-account"

  project_id       = local.project_id
  service_accounts = local.service_accounts
}

resource "google_project_iam_member" "github_actions_project_roles" {
  for_each = local.github_actions_project_roles

  project = local.project_id
  role    = each.value
  member  = local.github_actions_member
}

resource "google_project_iam_member" "atlantis_project_roles" {
  for_each = local.atlantis_project_roles

  project = local.project_id
  role    = each.value
  member  = "serviceAccount:${local.atlantis_gsa_email}"
}

resource "google_storage_bucket_iam_member" "atlantis_state_admin" {
  bucket = local.terraform_state_bucket
  role   = "roles/storage.admin"
  member = "serviceAccount:${local.atlantis_gsa_email}"
}

resource "google_service_account_iam_member" "atlantis_workload_identity" {
  service_account_id = "projects/${local.project_id}/serviceAccounts/${local.atlantis_gsa_email}"
  role               = "roles/iam.workloadIdentityUser"
  member             = local.atlantis_ksa_member
}
