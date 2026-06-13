output "services" {
  description = "Services managed by this stack."
  value       = toset(keys(google_project_service.enabled))
}
