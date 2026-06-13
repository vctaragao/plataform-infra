module "images" {
  source = "../../../../modules/gcp/artifact-registry"

  project_id             = "teste-projet-496019"
  location               = "us-central1"
  repository_id          = "images"
  format                 = "DOCKER"
  cleanup_policy_dry_run = true
  immutable_tags         = false
}
