terraform {
  backend "gcs" {
    bucket = "teste-prod-499414-tf-state"
    prefix = "live/prod/us-central1/artifact-registry"
  }
}
