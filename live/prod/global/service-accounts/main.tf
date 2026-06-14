locals {
  project_id            = "teste-prod-499414"
  github_actions_member = "serviceAccount:github-actions-deployer@${local.project_id}.iam.gserviceaccount.com"
  atlantis_member       = "serviceAccount:atlantis-deployer@teste-projet-496019.iam.gserviceaccount.com"
  terraform_prod_gsa    = "terraform-prod@${local.project_id}.iam.gserviceaccount.com"

  service_accounts = {
    github-actions-deployer = {
      display_name = "github-actions-deployer"
      description  = "SA for github actions"
    }
    terraform-prod = {
      display_name = "terraform-prod"
      description  = "SA impersonated by Atlantis and CI for prod Terraform changes"
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
    "roles/compute.networkAdmin",
    "roles/compute.viewer",
    "roles/container.admin",
    "roles/iam.serviceAccountAdmin",
    "roles/serviceusage.serviceUsageAdmin",
  ])

  terraform_prod_project_roles = toset([
    "roles/artifactregistry.admin",
    "roles/compute.networkAdmin",
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
  member  = local.atlantis_member
}

resource "google_project_iam_member" "terraform_prod_project_roles" {
  for_each = local.terraform_prod_project_roles

  project = local.project_id
  role    = each.value
  member  = "serviceAccount:${local.terraform_prod_gsa}"
}

resource "google_service_account_iam_member" "terraform_prod_github_actions_impersonation" {
  service_account_id = "projects/${local.project_id}/serviceAccounts/${local.terraform_prod_gsa}"
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = local.github_actions_member
}

resource "google_service_account_iam_member" "terraform_prod_atlantis_impersonation" {
  service_account_id = "projects/${local.project_id}/serviceAccounts/${local.terraform_prod_gsa}"
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = local.atlantis_member
}
