# $env:KUBE_EDITOR = "code --wait"
$env:KUBE_EDITOR = "`"$env:ProgramFiles\Git\usr\bin\nano.exe`""

$CTX = kubectl config current-context

$items = $(kubectl get all --all-namespaces -o json | ConvertFrom-json).items | 
    Select-Object   @{n='Date';e={$_.metadata.creationTimestamp}},
                    @{n='Context';e={$CTX}},
                    @{n='Namespace';e={$_.metadata.namespace}},
                    @{n='Kind';e={$_.kind}},
                    @{n='Pode';e={$_.metadata.name}},
                    @{n='Node';e={$_.spec.nodeName}} |
    Sort-Object -Descending Date

$item = $items | Out-ConsoleGridView -Title "Kubernetes all items" -OutputMode Single

kubectl --context $CTX --namespace $item.Namespace edit "$($item.Kind)/$($item.Pode)"