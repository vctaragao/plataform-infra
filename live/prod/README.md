# prod

Production Terraform environment for this repository.

Stacks:
- `global/project-services`
- `global/service-accounts`
- `us-central1/network`
- `us-central1/artifact-registry`
- `us-central1-a/gke-cluster`

Bootstrap/apply order:
1. `global/project-services`
2. `global/service-accounts`
3. `us-central1/network`
4. `us-central1/artifact-registry`
5. `us-central1-a/gke-cluster`

CI plans for these stacks run through the `Terraform Plan` GitHub Actions workflow using the `production` GitHub Environment.

Trigger a plan by commenting `.plan` on an open pull request from this repository.
