# gatus

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 5.35.0](https://img.shields.io/badge/AppVersion-5.35.0-informational?style=flat-square)

Automated developer-oriented Status Page with Alerting

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.annotations."reloader.stakater.com/auto" | string | `"true"` |  |
| app.config.TELEGRAM_API_KEY | string | `""` |  |
| app.config.TELEGRAM_CHAT_ID | string | `""` |  |
| app.config.WEB_UI_AUTH | bool | `false` |  |
| app.config.WEB_UI_PASSWORD | string | `"JDJ5JDA5JGdXQ2VjM3hkb2o2ZWN5enAwbnlCT09aMUdLUEYxM2FOM3ZBVGRSdkJiNTljWVhQSU5xYzh1"` |  |
| app.config.WEB_UI_USERNAME | string | `"admin"` |  |
| app.env.HTTPS_PROXY | string | `"http://192.168.3.105:20171"` |  |
| app.env.HTTP_PROXY | string | `"http://192.168.3.105:20171"` |  |
| app.env.NO_PROXY | string | `"kubernetes.default,svc.cluster.local,cluster.local,localhost,10.96.0.1,127.0.0.1,192.168.3.0/24"` |  |
| app.image | string | `"twinproduction/gatus"` |  |
| app.imagePullPolicy | string | `"Always"` |  |
| app.name | string | `"gatus"` |  |
| app.namespace | string | `"monitoring"` |  |
| app.probes.liveness.failureThreshold | int | `3` |  |
| app.probes.liveness.httpGet.path | string | `"/health"` |  |
| app.probes.liveness.httpGet.port | int | `8080` |  |
| app.probes.liveness.initialDelaySeconds | int | `30` |  |
| app.probes.liveness.periodSeconds | int | `10` |  |
| app.probes.liveness.timeoutSeconds | int | `5` |  |
| app.replicas | int | `1` |  |
| app.resources.limits.cpu | string | `"200m"` |  |
| app.resources.limits.memory | string | `"128Mi"` |  |
| app.resources.requests.cpu | string | `"100m"` |  |
| app.resources.requests.memory | string | `"64Mi"` |  |
| app.revisionCount | int | `1` |  |
| app.version | string | `"v5.35.0"` |  |
| app.volume.hostPath.enabled | bool | `false` |  |
| app.volume.hostPath.nodeSelector."kubernetes.io/hostname" | string | `"hv-us-101"` |  |
| app.volume.hostPath.path | string | `"/k8s_data/gatus_data"` |  |
| app.volume.pvc.claimName | string | `"local-path-pvc"` |  |
| app.volume.pvc.enabled | bool | `true` |  |
| ingress.className | string | `"traefik"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.host | string | `"gatus.k8s.local"` |  |
| service.annotations."metallb.universe.tf/address-pool" | string | `"default-pool"` |  |
| service.annotations."metallb.universe.tf/loadBalancerIPs" | string | `"192.168.3.205"` |  |
| service.nodePort | int | `30081` |  |
| service.port | int | `80` |  |
| service.targetPort | int | `8080` |  |
| service.type | string | `"LoadBalancer"` |  |

