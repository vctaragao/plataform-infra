variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "service_accounts" {
  description = "Service accounts to manage, keyed by account_id."
  type = map(object({
    display_name = string
    description  = string
  }))
}
