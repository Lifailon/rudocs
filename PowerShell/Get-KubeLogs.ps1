$CTX = kubectl config current-context

$items = $(kubectl get pods --all-namespaces -o json | ConvertFrom-json).items | ForEach-Object {
    $pod = $_
    $pod.status.containerStatuses | ForEach-Object {
        $container = $_
        [PSCustomObject]@{
            Date            = $pod.metadata.creationTimestamp
            Context         = $CTX
            Namespace       = $pod.metadata.namespace
            Kind            = $pod.kind
            Node            = $pod.spec.nodeName
            Pode            = $pod.metadata.name
            Container       = $container.name
            Ready           = $container.ready
            Starter         = $container.started
            RestartCount    = $container.restartCount
            Image           = $container.image
        }
    }
}

$item = $items | Out-GridView -Title "Kubernetes all items" -OutputMode Single

kubectl --context $CTX --namespace $item.Namespace logs $item.Pode -c $item.Container -f --tail 10 | Out-GridView

# $containerName = "dozzle"
# docker logs $containerName -f 2>&1 | ForEach-Object {$_ | ConvertFrom-Json} | Out-GridView
# docker logs $containerName -f 2>&1 | Select-Object -ExpandProperty Exception | Select-Object Message | Out-GridView