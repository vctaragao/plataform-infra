# service-account

Manages one or more Google service accounts in a project.

Inputs:
- `project_id`: GCP project ID
- `service_accounts`: map keyed by `account_id` with `display_name` and `description`

Outputs:
- `emails`: map of service account emails keyed by `account_id`
