# platform-infra

Shared platform resources for Kubernetes infrastructure.

## Terraform

Terraform is organized using a `modules/` plus `live/` layout.

- `modules/` contains reusable GCP infrastructure modules
- `live/bootstrap/` contains one-time bootstrap stacks such as the Terraform state bucket
- `live/dev/` contains the dev environment stacks, split by responsibility and state
- `live/prod/` contains the prod environment stacks, split by responsibility and state

Current Terraform stacks:
- `live/dev/global/project-services`
- `live/dev/global/service-accounts`
- `live/dev/us-central1/artifact-registry`
- `live/dev/us-central1-a/gke-cluster`
- `live/bootstrap/prod-state-bucket`
- `live/prod/global/project-services`
- `live/prod/global/service-accounts`
- `live/prod/us-central1/network`
- `live/prod/us-central1/artifact-registry`
- `live/prod/us-central1-a/gke-cluster`

Prod currently uses a separate Terraform state bucket.

Recommended prod bootstrap order:
1. `live/bootstrap/prod-state-bucket`
2. `live/prod/global/project-services`
3. `live/prod/global/service-accounts`
4. `live/prod/us-central1/network`
5. `live/prod/us-central1/artifact-registry`
6. `live/prod/us-central1-a/gke-cluster`

The first prod state bucket apply must be done outside Atlantis with backend disabled because the target GCS backend does not exist yet.

Useful commands:

```bash
make tf-fmt
make tf-validate
make tf-plan STACK=live/dev/global/project-services
make tf-plan STACK=live/dev/global/service-accounts
make tf-plan STACK=live/dev/us-central1/artifact-registry
make tf-plan STACK=live/dev/us-central1-a/gke-cluster
make tf-plan STACK=live/prod/global/project-services
make tf-plan STACK=live/prod/global/service-accounts
make tf-plan STACK=live/prod/us-central1/network
make tf-plan STACK=live/prod/us-central1/artifact-registry
make tf-plan STACK=live/prod/us-central1-a/gke-cluster
```

For local Terraform work, use your user credentials instead of the `google-sheets-mcp` service account key:

```bash
env -u GOOGLE_APPLICATION_CREDENTIALS terraform -chdir=live/dev/global/project-services plan
```

GitHub Actions:
- `Terraform Checks` runs `fmt` and `validate`
- `Terraform Plan` runs a real `terraform plan` against the bootstrap, `live/dev`, and `live/prod` stacks using Workload Identity from the matching GitHub Environment
- trigger it by commenting `.plan` on an open pull request from this repository
- each stack posts or updates its own plan comment on the PR
- full plan output remains available as a workflow artifact for each stack

Required GitHub Environment vars for both `development` and `production`:
- `WORKLOAD_IDENTITY_PROVIDER`
- `SERVICE_ACCOUNT`

Atlantis uses a single runtime identity but routes Terraform operations per stack. The GCS backend still uses the runtime identity directly, so the prod state bucket grants direct access to the Atlantis service account while the Terraform provider impersonates `terraform-dev` or `terraform-prod` for resource changes.

Because of that bootstrap constraint, `live/bootstrap/prod-state-bucket` is intentionally excluded from Atlantis and the PR plan workflow until the bucket exists.

The legacy generated import layout at the repo root has been retired in favor of the `live/` and `modules/` structure.

## Kong shared gateway

This repo manages the shared Gateway API resources that app repos can attach to when routing traffic through Kong.

Current shared resources:
- `Namespace` `kong`
- `GatewayClass` `kong`
- `Gateway` `shared-kong-gateway`

The Kong Ingress Controller itself is not installed by this repo. Install it separately first.

### Prerequisites

1. Kong Ingress Controller installed in namespace `kong`
2. Gateway API CRDs installed in the cluster

### Apply

```bash
kubectl apply -k k8s/kong
```

### GitHub Actions

This repo includes a workflow that:
- applies `k8s/kong` to the `production` environment on every push to `main`
- applies `k8s/kong` to the `development` environment when someone comments `.deploy` on a pull request

Configure these GitHub Environment variables in both the `production` and `development` environments:
- `GKE_CLUSTER`
- `GKE_LOCATION`
- `WORKLOAD_IDENTITY_PROVIDER`
- `SERVICE_ACCOUNT`

The workflow uses Workload Identity to authenticate to GKE and then runs:

```bash
kubectl apply -k k8s/kong
```

For pull request deployments, the workflow checks out the pull request HEAD commit and only allows `.deploy` from open pull requests in the same repository.

### Verify

```bash
kubectl get gatewayclass kong
kubectl get gateway -n kong shared-kong-gateway
kubectl describe gateway -n kong shared-kong-gateway
kubectl get svc -n kong kong-gateway-proxy
```

### App repo integration

Application repos should reference the shared gateway from their `HTTPRoute` resources.

Example parent ref:

```yaml
parentRefs:
  - name: shared-kong-gateway
    namespace: kong
```

The shared gateway currently allows routes from all namespaces for simplicity:

```yaml
allowedRoutes:
  namespaces:
    from: All
```

This can be tightened later once the set of app namespaces is stable.
