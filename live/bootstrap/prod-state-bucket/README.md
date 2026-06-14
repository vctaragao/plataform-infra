# bootstrap/prod-state-bucket

Bootstraps the shared GCS bucket used by the prod Terraform stacks for remote state.

State bucket:
- `gs://teste-prod-499414-tf-state`

This stack is the only one that should run before the prod remote backend exists.

After bootstrapping, this stack also uses the same GCS backend so CI can run `terraform plan` against it.

Initial bootstrap must be run outside Atlantis because Atlantis cannot initialize a GCS backend that points at a bucket which does not exist yet.

First apply sequence:

```bash
env -u GOOGLE_APPLICATION_CREDENTIALS terraform -chdir=live/bootstrap/prod-state-bucket init -backend=false -reconfigure
env -u GOOGLE_APPLICATION_CREDENTIALS terraform -chdir=live/bootstrap/prod-state-bucket apply
terraform -chdir=live/bootstrap/prod-state-bucket init -migrate-state
```
