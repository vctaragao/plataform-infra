# prod/global/service-accounts

Manages shared service accounts for the prod environment.

Current resources:
- `github-actions-deployer`
- `terraform-prod`

This is a foundational stack and should be applied before prod stacks that impersonate `terraform-prod`.

Backend:
- bucket: `teste-prod-499414-tf-state`
- prefix: `live/prod/global/service-accounts`
