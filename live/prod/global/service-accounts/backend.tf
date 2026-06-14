terraform {
  backend "gcs" {
    bucket = "teste-prod-499414-tf-state"
    prefix = "live/prod/global/service-accounts"
  }
}
