resource "google_compute_network" "platform" {
  name                    = "platform-vpc"
  project                 = "teste-prod-499414"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "platform_us_central1" {
  name          = "platform-us-central1"
  project       = "teste-prod-499414"
  region        = "us-central1"
  network       = google_compute_network.platform.id
  ip_cidr_range = "10.20.0.0/20"

  secondary_ip_range {
    range_name    = "gke-prod-pods"
    ip_cidr_range = "10.24.0.0/16"
  }

  secondary_ip_range {
    range_name    = "gke-prod-services"
    ip_cidr_range = "10.25.0.0/20"
  }
}
