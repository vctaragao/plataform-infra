module "teste_prod_cluster" {
  source = "../../../../modules/gcp/gke-cluster"

  project_id                   = "teste-prod-499414"
  name                         = "teste-prod-cluster"
  location                     = "us-central1-a"
  network                      = "projects/teste-prod-499414/global/networks/platform-vpc"
  subnetwork                   = "projects/teste-prod-499414/regions/us-central1/subnetworks/platform-us-central1"
  cluster_secondary_range_name = "gke-prod-pods"
}
