# bootstrap/state-bucket

Bootstraps the shared GCS bucket used by the other Terraform stacks for remote state.

State bucket:
- `gs://teste-projet-496019-tf-state`

This stack is the only one that should run before the remote backend exists.
