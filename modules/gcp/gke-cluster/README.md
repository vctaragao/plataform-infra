# gke-cluster

Manages the shared GKE cluster currently used by this repository.

This module is intentionally shaped around the existing cluster instead of trying to be a fully generic cluster abstraction on day one.

Inputs:
- `project_id`: GCP project ID
- `name`: cluster name
- `location`: cluster zone/region
- `network`: VPC network self link
- `subnetwork`: subnetwork self link
- `cluster_secondary_range_name`: secondary range used for pod IPs

Outputs:
- `name`
- `location`
- `endpoint`
