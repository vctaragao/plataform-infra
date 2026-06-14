# prod

Production Terraform environment for this repository.

Stacks:
- `global/project-services`
- `global/service-accounts`
- `us-central1/artifact-registry`

The prod GKE stack is intentionally deferred until the prod project network and secondary IP ranges are bootstrapped.

CI plans for these stacks run through the `Terraform Plan` GitHub Actions workflow using the `production` GitHub Environment.

Trigger a plan by commenting `.plan` on an open pull request from this repository.
