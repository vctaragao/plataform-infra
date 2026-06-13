resource "google_artifact_registry_repository" "this" {
  cleanup_policy_dry_run = var.cleanup_policy_dry_run
  format                 = var.format
  location               = var.location
  mode                   = var.mode
  project                = var.project_id
  repository_id          = var.repository_id

  dynamic "docker_config" {
    for_each = var.format == "DOCKER" ? [1] : []

    content {
      immutable_tags = var.immutable_tags
    }
  }
}
