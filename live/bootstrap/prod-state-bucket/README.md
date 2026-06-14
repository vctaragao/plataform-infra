# bootstrap/prod-state-bucket

Bootstraps the shared GCS bucket used by the prod Terraform stacks for remote state.

State bucket:
- `gs://teste-prod-499414-tf-state`

This stack is the only one that should run before the prod remote backend exists.

After bootstrapping, this stack also uses the same GCS backend so CI can run `terraform plan` against it.
