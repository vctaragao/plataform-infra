# bootstrap/state-bucket

Bootstraps the shared GCS bucket used by the other Terraform stacks for remote state.

State bucket:
- `gs://teste-projet-496019-tf-state`

This stack is the only one that should run before the dev remote backend exists.

After bootstrapping, this stack also uses the same GCS backend so CI can run `terraform plan` against it.
