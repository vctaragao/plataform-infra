# artifact-registry

Manages a single Artifact Registry repository.

Inputs:
- `project_id`: GCP project ID
- `location`: repository location
- `repository_id`: repository ID
- `format`: repository format, defaults to `DOCKER`
- `mode`: repository mode, defaults to `STANDARD_REPOSITORY`
- `cleanup_policy_dry_run`: whether cleanup policies stay in dry-run mode
- `immutable_tags`: Docker-only flag for immutable tags

Outputs:
- `repository_id`
- `name`
