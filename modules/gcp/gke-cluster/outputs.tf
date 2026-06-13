output "name" {
  description = "Cluster name."
  value       = google_container_cluster.this.name
}

output "location" {
  description = "Cluster location."
  value       = google_container_cluster.this.location
}

output "endpoint" {
  description = "Cluster endpoint."
  value       = google_container_cluster.this.endpoint
}
