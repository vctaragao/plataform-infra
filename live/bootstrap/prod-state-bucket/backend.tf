terraform {
  backend "gcs" {
    bucket = "teste-prod-499414-tf-state"
    prefix = "live/bootstrap/prod-state-bucket"
  }
}
