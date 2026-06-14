# prod/us-central1/network

Creates the shared VPC and subnet used by the prod GKE cluster in `us-central1`.

Current resources:
- VPC network `platform-vpc`
- Subnetwork `platform-us-central1`
- Secondary range `gke-prod-pods`
- Secondary range `gke-prod-services`

Backend:
- bucket: `teste-prod-499414-tf-state`
- prefix: `live/prod/us-central1/network`

This is a foundational stack and should be applied before the prod GKE cluster stack.
