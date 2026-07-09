# Kubernetes Cluster Info

Универсальный Jenkins Pipeline для получения информации о состояние всех компонентов и ресурсов в кластере Kubernetes.

Поддерживает:

- `nodes` - получение информации о состояние нод в кластере (статус, роли, время работы и версию)
- `components` - получение информации о состояние компонентов кластера (etcd, scheduler, controller-manager и других)
- `top` - отображает текущую утилизацию ресурсов (процессору и памяти) по нодам и подам
- `resources` - отображает состояние всех ресурсов в кластере (поды, сервисы, задания, хранилища, сетевые контроллеры и другие)
- `events` - получить информация обо всех событиях для всех ресурсов в кластере
- `dump` - снятие дампа с информаций о кластере и загрузкой в артифакты сборки

Пример вывода:

```log
13:19:25  Получаем информацию о состояние нод в кластере (статус, роли, время работы и версию)
[Pipeline] sh
13:19:25  + kubectl get nodes --insecure-skip-tls-verify=true --all-namespaces
[Pipeline] echo
13:19:25  NAME                STATUS   ROLES           AGE     VERSION
13:19:25  k3s-control-plane   Ready    control-plane   3d21h   v1.34.1+k3s1
13:19:25  k3s-worker-01       Ready    <none>          3d21h   v1.34.1+k3s1
13:19:25  
[Pipeline] echo
13:19:25  Получаем информацию о состояние компонентов кластера (etcd, scheduler, controller-manager и другие)
[Pipeline] sh
13:19:26  + kubectl get componentstatuses --insecure-skip-tls-verify=true --all-namespaces
13:19:26  Warning: v1 ComponentStatus is deprecated in v1.19+
[Pipeline] echo
13:19:26  NAME                 STATUS    MESSAGE   ERROR
13:19:26  etcd-0               Healthy   ok        
13:19:26  scheduler            Healthy   ok        
13:19:26  controller-manager   Healthy   ok        
13:19:26  
[Pipeline] echo
13:19:26  Получаем информацию о состояние готовности всех компонентов в кластере
[Pipeline] sh
13:19:26  + kubectl get --raw /readyz?verbose --insecure-skip-tls-verify=true --all-namespaces
[Pipeline] echo
13:19:26  [+]ping ok
[Pipeline] echo
13:19:26  [+]log ok
[Pipeline] echo
13:19:26  [+]etcd ok
[Pipeline] echo
13:19:27  [+]etcd-readiness ok
[Pipeline] echo
13:19:27  [+]informer-sync ok
[Pipeline] echo
13:19:27  [+]poststarthook/start-apiserver-admission-initializer ok
[Pipeline] echo
13:19:27  [+]poststarthook/generic-apiserver-start-informers ok
[Pipeline] echo
13:19:27  [+]poststarthook/priority-and-fairness-config-consumer ok
[Pipeline] echo
13:19:27  [+]poststarthook/priority-and-fairness-filter ok
[Pipeline] echo
13:19:27  [+]poststarthook/storage-object-count-tracker-hook ok
[Pipeline] echo
13:19:27  [+]poststarthook/start-apiextensions-informers ok
[Pipeline] echo
13:19:27  [+]poststarthook/start-apiextensions-controllers ok
[Pipeline] echo
13:19:27  [+]poststarthook/crd-informer-synced ok
[Pipeline] echo
13:19:27  [+]poststarthook/start-system-namespaces-controller ok
[Pipeline] echo
13:19:27  [+]poststarthook/start-cluster-authentication-info-controller ok
[Pipeline] echo
13:19:28  [+]poststarthook/start-kube-apiserver-identity-lease-controller ok
[Pipeline] echo
13:19:28  [+]poststarthook/start-kube-apiserver-identity-lease-garbage-collector ok
[Pipeline] echo
13:19:28  [+]poststarthook/start-legacy-token-tracking-controller ok
[Pipeline] echo
13:19:28  [+]poststarthook/start-service-ip-repair-controllers ok
[Pipeline] echo
13:19:28  [+]poststarthook/rbac/bootstrap-roles ok
[Pipeline] echo
13:19:28  [+]poststarthook/scheduling/bootstrap-system-priority-classes ok
[Pipeline] echo
13:19:28  [+]poststarthook/priority-and-fairness-config-producer ok
[Pipeline] echo
13:19:28  [+]poststarthook/bootstrap-controller ok
[Pipeline] echo
13:19:28  [+]poststarthook/start-kubernetes-service-cidr-controller ok
[Pipeline] echo
13:19:28  [+]poststarthook/aggregator-reload-proxy-client-cert ok
[Pipeline] echo
13:19:28  [+]poststarthook/start-kube-aggregator-informers ok
[Pipeline] echo
13:19:29  [+]poststarthook/apiservice-status-local-available-controller ok
[Pipeline] echo
13:19:29  [+]poststarthook/apiservice-status-remote-available-controller ok
[Pipeline] echo
13:19:29  [+]poststarthook/apiservice-registration-controller ok
[Pipeline] echo
13:19:29  [+]poststarthook/apiservice-discovery-controller ok
[Pipeline] echo
13:19:29  [+]poststarthook/kube-apiserver-autoregistration ok
[Pipeline] echo
13:19:29  [+]autoregister-completion ok
[Pipeline] echo
13:19:29  [+]poststarthook/apiservice-openapi-controller ok
[Pipeline] echo
13:19:29  [+]poststarthook/apiservice-openapiv3-controller ok
[Pipeline] echo
13:19:29  [+]shutdown ok
[Pipeline] echo
13:19:29  readyz check passed
[Pipeline] echo
13:19:29  Получаем текущую утилизацию ресурсов на нодах
[Pipeline] sh
13:19:30  + kubectl top nodes --insecure-skip-tls-verify=true
[Pipeline] echo
13:19:30  NAME                CPU(cores)   CPU(%)   MEMORY(bytes)   MEMORY(%)   
13:19:30  k3s-control-plane   46m          2%       850Mi           3%          
13:19:30  k3s-worker-01       18m          0%       513Mi           1%          
13:19:30  
[Pipeline] echo
13:19:30  Получаем текущую утилизацию ресурсов на подах
[Pipeline] sh
13:19:30  + kubectl top pods --insecure-skip-tls-verify=true --all-namespaces
[Pipeline] echo
13:19:30  NAMESPACE     NAME                                      CPU(cores)   MEMORY(bytes)   
13:19:30  kube-system   coredns-7896679cc-cmqc6                   2m           72Mi            
13:19:30  kube-system   headlamp-66b6b6b567-2j7tv                 1m           62Mi            
13:19:30  kube-system   local-path-provisioner-578895bd58-5kgnm   1m           49Mi            
13:19:30  kube-system   metrics-server-7b9c9c4b9c-vxk82           5m           81Mi            
13:19:30  kube-system   svclb-traefik-3bc282c5-f98vl              0m           2Mi             
13:19:30  kube-system   svclb-traefik-3bc282c5-mrkkr              0m           1Mi             
13:19:30  kube-system   traefik-6f986b958c-j957j                  1m           150Mi           
13:19:30  monitoring    dozzle-6f6b78b7bd-c2b75                   4m           72Mi            
13:19:30  
[Pipeline] echo
13:19:30  Получаем состояние всех ресурсов в кластере (поды, сервисы, задания и другие)
[Pipeline] sh
13:19:31  + kubectl get all --insecure-skip-tls-verify=true --all-namespaces
[Pipeline] echo
13:19:31  NAMESPACE     NAME                                          READY   STATUS      RESTARTS      AGE
13:19:31  kube-system   pod/coredns-7896679cc-cmqc6                   1/1     Running     1 (27h ago)   3d21h
13:19:31  kube-system   pod/headlamp-66b6b6b567-2j7tv                 1/1     Running     1 (27h ago)   3d19h
13:19:31  kube-system   pod/helm-install-traefik-5j49n                0/1     Completed   1             3d21h
13:19:31  kube-system   pod/helm-install-traefik-crd-2pkm4            0/1     Completed   0             3d21h
13:19:31  kube-system   pod/local-path-provisioner-578895bd58-5kgnm   1/1     Running     1 (27h ago)   3d21h
13:19:31  kube-system   pod/metrics-server-7b9c9c4b9c-vxk82           1/1     Running     1 (27h ago)   3d21h
13:19:31  kube-system   pod/svclb-dozzle-service-d3caf483-54ltk       0/1     Pending     0             26h
13:19:31  kube-system   pod/svclb-dozzle-service-d3caf483-mhm2r       0/1     Pending     0             26h
13:19:31  kube-system   pod/svclb-headlamp-1eba9475-9tqms             0/1     Pending     0             3d19h
13:19:31  kube-system   pod/svclb-headlamp-1eba9475-n4dx8             0/1     Pending     0             3d19h
13:19:31  kube-system   pod/svclb-traefik-3bc282c5-f98vl              2/2     Running     2 (27h ago)   3d21h
13:19:31  kube-system   pod/svclb-traefik-3bc282c5-mrkkr              2/2     Running     2 (27h ago)   3d21h
13:19:31  kube-system   pod/traefik-6f986b958c-j957j                  1/1     Running     1 (27h ago)   3d21h
13:19:31  monitoring    pod/dozzle-6f6b78b7bd-c2b75                   1/1     Running     0             26h
13:19:31  
13:19:31  NAMESPACE     NAME                     TYPE           CLUSTER-IP      EXTERNAL-IP             PORT(S)                      AGE
13:19:31  default       service/kubernetes       ClusterIP      10.43.0.1       <none>                  443/TCP                      3d21h
13:19:31  kube-system   service/headlamp         LoadBalancer   10.43.126.56    <pending>               80:30001/TCP                 3d19h
13:19:31  kube-system   service/kube-dns         ClusterIP      10.43.0.10      <none>                  53/UDP,53/TCP,9153/TCP       3d21h
13:19:31  kube-system   service/metrics-server   ClusterIP      10.43.116.242   <none>                  443/TCP                      3d21h
13:19:31  kube-system   service/traefik          LoadBalancer   10.43.31.125    172.19.0.2,172.19.0.3   80:31754/TCP,443:30820/TCP   3d21h
13:19:31  monitoring    service/dozzle-service   LoadBalancer   10.43.196.165   <pending>               80:30080/TCP                 26h
13:19:31  
13:19:31  NAMESPACE     NAME                                           DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
13:19:31  kube-system   daemonset.apps/svclb-dozzle-service-d3caf483   2         2         0       2            0           <none>          26h
13:19:31  kube-system   daemonset.apps/svclb-headlamp-1eba9475         2         2         0       2            0           <none>          3d19h
13:19:31  kube-system   daemonset.apps/svclb-traefik-3bc282c5          2         2         2       2            2           <none>          3d21h
13:19:31  
13:19:31  NAMESPACE     NAME                                     READY   UP-TO-DATE   AVAILABLE   AGE
13:19:31  kube-system   deployment.apps/coredns                  1/1     1            1           3d21h
13:19:31  kube-system   deployment.apps/headlamp                 1/1     1            1           3d19h
13:19:31  kube-system   deployment.apps/local-path-provisioner   1/1     1            1           3d21h
13:19:31  kube-system   deployment.apps/metrics-server           1/1     1            1           3d21h
13:19:31  kube-system   deployment.apps/traefik                  1/1     1            1           3d21h
13:19:31  monitoring    deployment.apps/dozzle                   1/1     1            1           26h
13:19:31  
13:19:31  NAMESPACE     NAME                                                DESIRED   CURRENT   READY   AGE
13:19:31  kube-system   replicaset.apps/coredns-7896679cc                   1         1         1       3d21h
13:19:31  kube-system   replicaset.apps/headlamp-66b6b6b567                 1         1         1       3d19h
13:19:31  kube-system   replicaset.apps/local-path-provisioner-578895bd58   1         1         1       3d21h
13:19:31  kube-system   replicaset.apps/metrics-server-7b9c9c4b9c           1         1         1       3d21h
13:19:31  kube-system   replicaset.apps/traefik-6f986b958c                  1         1         1       3d21h
13:19:31  monitoring    replicaset.apps/dozzle-6f6b78b7bd                   1         1         1       26h
13:19:31  
13:19:31  NAMESPACE     NAME                                 STATUS     COMPLETIONS   DURATION   AGE
13:19:31  kube-system   job.batch/helm-install-traefik       Complete   1/1           37s        3d21h
13:19:31  kube-system   job.batch/helm-install-traefik-crd   Complete   1/1           36s        3d21h
13:19:31  
[Pipeline] echo
13:19:31  Получаем состояние всех хранилищ в кластере
[Pipeline] sh
13:19:31  + kubectl get pv,pvc,storageclasses --insecure-skip-tls-verify=true --all-namespaces
[Pipeline] echo
13:19:31  NAMESPACE   NAME                                               PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
13:19:31              storageclass.storage.k8s.io/local-path (default)   rancher.io/local-path   Delete          WaitForFirstConsumer   false                  3d21h
13:19:31  
[Pipeline] echo
13:19:32  Получаем состояние сетевых контроллеров
[Pipeline] sh
13:19:32  + kubectl get ingress,ingressclasses,networkpolicies --insecure-skip-tls-verify=true --all-namespaces
[Pipeline] echo
13:19:32  NAMESPACE     NAME                                         CLASS     HOSTS                ADDRESS                 PORTS   AGE
13:19:32  kube-system   ingress.networking.k8s.io/headlamp-ingress   traefik   headlamp.k8s.local   172.19.0.2,172.19.0.3   80      3d19h
13:19:32  monitoring    ingress.networking.k8s.io/dozzle-ingress     traefik   dozzle.k8s.local     172.19.0.2,172.19.0.3   80      26h
13:19:32  
13:19:32  NAMESPACE   NAME                                     CONTROLLER                      PARAMETERS   AGE
13:19:32              ingressclass.networking.k8s.io/traefik   traefik.io/ingress-controller   <none>       3d21h
13:19:32  
[Pipeline] echo
13:19:32  Получаем список всех конфигураций и секретов
[Pipeline] sh
13:19:32  + kubectl get configmaps,secrets --insecure-skip-tls-verify=true --all-namespaces
[Pipeline] echo
13:19:32  NAMESPACE         NAME                                                             DATA   AGE
13:19:32  default           configmap/kube-root-ca.crt                                       1      3d21h
13:19:32  kube-node-lease   configmap/kube-root-ca.crt                                       1      3d21h
13:19:32  kube-public       configmap/kube-root-ca.crt                                       1      3d21h
13:19:32  kube-system       configmap/chart-content-traefik                                  0      3d21h
13:19:32  kube-system       configmap/chart-content-traefik-crd                              0      3d21h
13:19:32  kube-system       configmap/cluster-dns                                            2      3d21h
13:19:32  kube-system       configmap/coredns                                                2      3d21h
13:19:32  kube-system       configmap/extension-apiserver-authentication                     6      3d21h
13:19:32  kube-system       configmap/kube-apiserver-legacy-service-account-token-tracking   1      3d21h
13:19:32  kube-system       configmap/kube-root-ca.crt                                       1      3d21h
13:19:32  kube-system       configmap/local-path-config                                      4      3d21h
13:19:32  monitoring        configmap/kube-root-ca.crt                                       1      3d18h
13:19:32  
13:19:32  NAMESPACE     NAME                                         TYPE                                  DATA   AGE
13:19:32  kube-system   secret/chart-values-traefik                  helmcharts.helm.cattle.io/values      1      3d21h
13:19:32  kube-system   secret/chart-values-traefik-crd              helmcharts.helm.cattle.io/values      0      3d21h
13:19:32  kube-system   secret/headlamp-admin-token                  kubernetes.io/service-account-token   3      3d19h
13:19:32  kube-system   secret/k3s-control-plane.node-password.k3s   Opaque                                1      3d21h
13:19:32  kube-system   secret/k3s-serving                           kubernetes.io/tls                     2      3d21h
13:19:32  kube-system   secret/k3s-worker-01.node-password.k3s       Opaque                                1      3d21h
13:19:32  kube-system   secret/sh.helm.release.v1.traefik-crd.v1     helm.sh/release.v1                    1      3d21h
13:19:32  kube-system   secret/sh.helm.release.v1.traefik.v1         helm.sh/release.v1                    1      3d21h
13:19:32  monitoring    secret/dozzle-secrets                        Opaque                                1      26h
13:19:32  monitoring    secret/sh.helm.release.v1.dozzle.v1          helm.sh/release.v1                    1      26h
13:19:32  
[Pipeline] echo
13:19:32  Получаем информацию обо всех событиях для всех ресурсов в кластере
[Pipeline] sh
13:19:33  + kubectl get events --insecure-skip-tls-verify=true --all-namespaces --sort-by=.metadata.creationTimestamp
13:19:33  + awk /Warning/ {print "" $0 ""; next} /Normal/ {print "" $0 ""; next} {print}
13:19:33  NAMESPACE     LAST SEEN   TYPE      REASON             OBJECT                                    MESSAGE
13:19:33  kube-system   23m         Warning   FailedScheduling   pod/svclb-headlamp-1eba9475-9tqms         0/2 nodes are available: 1 node(s) didn't have free ports for the requested pod ports, 1 node(s) didn't satisfy plugin(s) [NodeAffinity]. no new claims to deallocate, preemption: 0/2 nodes are available: 1 Preemption is not helpful for scheduling, 1 node(s) didn't have free ports for the requested pod ports.
13:19:33  kube-system   23m         Warning   FailedScheduling   pod/svclb-headlamp-1eba9475-n4dx8         0/2 nodes are available: 1 node(s) didn't have free ports for the requested pod ports, 1 node(s) didn't satisfy plugin(s) [NodeAffinity]. no new claims to deallocate, preemption: 0/2 nodes are available: 1 Preemption is not helpful for scheduling, 1 node(s) didn't have free ports for the requested pod ports.
13:19:33  kube-system   23m         Warning   FailedScheduling   pod/svclb-dozzle-service-d3caf483-54ltk   0/2 nodes are available: 1 node(s) didn't have free ports for the requested pod ports, 1 node(s) didn't satisfy plugin(s) [NodeAffinity]. no new claims to deallocate, preemption: 0/2 nodes are available: 1 Preemption is not helpful for scheduling, 1 node(s) didn't have free ports for the requested pod ports.
13:19:33  kube-system   23m         Warning   FailedScheduling   pod/svclb-dozzle-service-d3caf483-mhm2r   0/2 nodes are available: 1 node(s) didn't have free ports for the requested pod ports, 1 node(s) didn't satisfy plugin(s) [NodeAffinity]. no new claims to deallocate, preemption: 0/2 nodes are available: 1 Preemption is not helpful for scheduling, 1 node(s) didn't have free ports for the requested pod ports.
```