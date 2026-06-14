output "emails" {
  description = "Service account emails keyed by account_id."
  value       = { for account_id, account in google_service_account.accounts : account_id => account.email }
}
