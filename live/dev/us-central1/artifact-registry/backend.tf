terraform {
  backend "gcs" {
    bucket = "teste-projet-496019-tf-state"
    prefix = "live/dev/us-central1/artifact-registry"
  }
}
