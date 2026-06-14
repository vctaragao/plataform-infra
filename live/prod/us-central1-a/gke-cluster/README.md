# prod/us-central1-a/gke-cluster

Manages the prod GKE cluster in `us-central1-a`.

Current resources:
- cluster `teste-prod-cluster`

Backend:
- bucket: `teste-prod-499414-tf-state`
- prefix: `live/prod/us-central1-a/gke-cluster`

This stack depends on `prod/us-central1/network` being applied first.
