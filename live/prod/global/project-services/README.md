# prod/global/project-services

Enables and manages the set of Google APIs required by the prod environment.

This is a foundational stack and should be applied before the prod network, Artifact Registry, or GKE stacks.

Backend:
- bucket: `teste-prod-499414-tf-state`
- prefix: `live/prod/global/project-services`
