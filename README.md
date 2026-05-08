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
