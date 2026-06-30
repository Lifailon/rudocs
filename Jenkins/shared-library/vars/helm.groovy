def kubeConfigGenerate(
    String contextName,
    String clusterUrl,
    String namespace,
    String token
) {
    return """
apiVersion: v1
kind: Config
current-context: ${contextName}
preferences: {}

clusters:
- name: ${contextName}-ctx
  cluster:
    server: ${clusterUrl}
    insecure-skip-tls-verify: true

users:
- name: ${contextName}-usr
  user:
    token: ${token}

contexts:
- name: ${contextName}
  context:
    cluster: ${contextName}-ctx
    namespace: ${namespace}
    user: ${contextName}-usr
"""
}

def upgradeCommandGenerate(
    String appName,
    String chartPath,
    String valuesPath,
    String contextName,
    String namespace,
    String timeout,
    boolean dryRun,
    boolean atomic,
    boolean force
) {
    if (!appName?.trim() || !chartPath?.trim()) {
        error "Error: required parameters were not passed"
    }
    if (!valuesPath?.trim()) {
        valuesPath = "${chartPath}/values.yaml"
    }
    if (!contextName?.trim()) {
        contextName = "jenkins"
    }
    def args = [
        "helm upgrade ${appName} ${chartPath}",
        "--install",
        "--values ${valuesPath}",
        "--set appName=${appName}",
        "--kube-context ${contextName}",
        "--insecure-skip-tls-verify",
        "--cleanup-on-fail",
        "--create-namespace"
    ]
    if (namespace?.trim()) {
        args << "--namespace ${namespace.trim()}"
    }
    if (timeout?.trim()) {
        args << "--timeout ${timeout}"
    }
    if (dryRun)     args << "--dry-run"
    if (atomic)     args << "--atomic"
    if (force)      args << "--force"
    return args.join(" ")
}