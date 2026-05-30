# Kustomize Deploy

Универсальный Jenkins Pipeline для развертвывания манифестов в кластере Kubernetes из репозитория GitHub с помощью [Kustomize](https://github.com/kubernetes-sigs/kustomize).

Активный параметр `project` сканирует указанный репозиторий на наличие файлов `kustomization.yaml` и выводит список директорий.

Поддерживает несколько режимов работы (развертвывание, replace и удаление) и настройку опций `kubectl`.

Для подключения к кластерам Kubernetes используется файл `kubeconfig` из Jenkins Credentials.

Для установки [kubectl](https://github.com/kubernetes/kubectl) на сборщике Jenkins используется Custom Tools:

```bash
mkdir -p ./bin
curl -sSL https://dl.k8s.io/release/v1.36.0/bin/linux/amd64/kubectl -o ./bin/kubectl
chmod +x ./bin/kubectl
```

- Параметры:

![](img/params.jpg)

- Лог развертвывания:

![](img/deploy.jpg)