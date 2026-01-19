$contexts = $(kubectl config view -o json | ConvertFrom-json).contexts |
    Select-Object   name,
                    @{n='Сluster';e={$_.context.cluster}},
                    @{n='User';e={$_.context.user}},
                    @{n='Namespace';e={$_.context.namespace}}

$context = $contexts | Out-ConsoleGridView -Title "Kubernetes context list" -OutputMode Single

kubectl config use-context $context.name