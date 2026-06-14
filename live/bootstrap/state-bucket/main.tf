resource "google_storage_bucket" "terraform_state" {
  name                        = "teste-projet-496019-tf-state"
  location                    = "US"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  force_destroy               = false

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_iam_member" "github_actions_state_admin" {
  bucket = google_storage_bucket.terraform_state.name
  role   = "roles/storage.admin"
  member = "serviceAccount:github-actions-deployer@teste-projet-496019.iam.gserviceaccount.com"
}
