locals {
  project_id            = "teste-projet-496019"
  github_actions_member = "serviceAccount:github-actions-deployer@teste-projet-496019.iam.gserviceaccount.com"

  service_accounts = {
    github-actions-deployer = {
      display_name = "github-actions-deployer"
      description  = "SA for github actions"
    }
    google-sheets-mcp = {
      display_name = "google-sheets-mcp"
      description  = "Conta de serviço para se comunicar com google sheets"
    }
  }

  github_actions_project_roles = toset([
    "roles/iam.serviceAccountViewer",
    "roles/serviceusage.serviceUsageViewer",
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
