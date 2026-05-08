# platform-infra

Shared platform resources for Kubernetes infrastructure.

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
