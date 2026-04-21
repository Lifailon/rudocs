# dozzle

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 10.4.0](https://img.shields.io/badge/AppVersion-10.4.0-informational?style=flat-square)

Realtime log viewer for Docker containers and K8s pods

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.env | object | `{"DOZZLE_AUTH_PROVIDER":"simple","DOZZLE_MODE":"k8s"}` | Container environment variables |
| app.image | string | `"amir20/dozzle"` | Path to the image in the format: <registryUrl/userName/appName> |
| app.imagePullPolicy | string | `"Always"` | Always download the latest image from the registry |
| app.name | string | `"dozzle"` | Application name |
| app.namespace | string | `"monitoring"` | Namespace used |
| app.probes | object | `{"liveness":{"exec":{"command":["/dozzle","healthcheck"]},"failureThreshold":3,"initialDelaySeconds":30,"periodSeconds":10,"timeoutSeconds":5}}` | Configuration health checks |
| app.replicas | int | `1` | Number of active replicas |
| app.resources | object | `{"limits":{"cpu":"200m","memory":"128Mi"},"requests":{"cpu":"100m","memory":"64Mi"}}` | Resource configuration |
| app.revisionCount | int | `1` | Number of ReplicaSets to rollback |
| app.version | string | `"v10.4"` | Image tag |
| ingress.className | string | `"traefik"` | Ingress controller |
| ingress.enabled | bool | `true` | Ingess enabled |
| ingress.host | string | `"dozzle.k8s.local"` | External name |
| rbac.create | bool | `true` | Create a new SA |
| rbac.sa | string | `"dozzle-pod-viewer-sa"` | Use the specified SA in deployment or when creating a new RBAC |
| service.annotations | object | `{"metallb.universe.tf/address-pool":"default-pool","metallb.universe.tf/loadBalancerIPs":"192.168.3.202"}` | Using MetalLB (optional) |
| service.nodePort | int | `30080` | Open port on nodes |
| service.port | int | `80` | Service port |
| service.targetPort | int | `8080` | Container port on pod |
| service.type | string | `"LoadBalancer"` | Service mode |

