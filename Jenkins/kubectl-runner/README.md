# Kubectl Runner

Универсальный Jenkins Pipeline для выполнения команд в кластере Kubernetes.

Для подключения к кластерам Kubernetes используется Token, который извлекается из Vault с помощью AppRole.

Для установки [kubectl](https://github.com/kubernetes/kubectl) на сборщике Jenkins используется Custom Tools:

```bash
mkdir -p ./bin
curl https://dl.k8s.io/release/v1.36.0/bin/linux/amd64/kubectl -sSLo ./bin/kubectl
chmod +x ./bin/kubectl
```

- Параметры:

![](img/params.jpg)

- Лог выполнения:

![](img/log.jpg)