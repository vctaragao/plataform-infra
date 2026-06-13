output "repository_id" {
  description = "Repository ID."
  value       = google_artifact_registry_repository.this.repository_id
}

output "name" {
  description = "Full repository name."
  value       = google_artifact_registry_repository.this.name
}
