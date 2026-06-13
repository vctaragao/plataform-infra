locals {
  project_id = "teste-projet-496019"

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
}

module "service_accounts" {
  source = "../../../../modules/gcp/service-account"

  project_id       = local.project_id
  service_accounts = local.service_accounts
}
