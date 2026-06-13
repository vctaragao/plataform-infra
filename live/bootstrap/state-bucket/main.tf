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
