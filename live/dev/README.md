# dev

Current active Terraform environment for this repository.

Stacks:
- `global/project-services`
- `global/service-accounts`
- `us-central1/artifact-registry`
- `us-central1-a/gke-cluster`

CI plans for these stacks run through the `Terraform Dev Plan` GitHub Actions workflow using the `development` GitHub Environment.

Trigger a plan by commenting `.plan` on an open pull request from this repository.
