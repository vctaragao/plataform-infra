module "teste_cluster_manual_2" {
  source = "../../../../modules/gcp/gke-cluster"

  project_id                   = "teste-projet-496019"
  name                         = "teste-cluster-manual-2"
  location                     = "us-central1-a"
  network                      = "projects/teste-projet-496019/global/networks/default"
  subnetwork                   = "projects/teste-projet-496019/regions/us-central1/subnetworks/default"
  cluster_secondary_range_name = "gke-teste-cluster-manual-2-pods-4b47136f"
}
