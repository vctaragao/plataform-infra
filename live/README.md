# Terraform Live Stacks

Environment-specific Terraform stacks live here.

Layout:
- `bootstrap/`: one-time foundational stacks such as the remote state bucket
- `dev/`: the current active environment for this repository

Each stack directory under `live/` is an independent Terraform state and should be planned and applied separately.
