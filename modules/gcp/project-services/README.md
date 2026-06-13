# project-services

Manages the enabled Google APIs for a project using a single `for_each`-based `google_project_service` resource.

Inputs:
- `project_id`: GCP project ID or project number used by the provider for these services
- `services`: set of API service names to manage

Outputs:
- `services`: set of managed service names
