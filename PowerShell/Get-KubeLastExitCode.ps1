$pods = kubectl get pods -o name
$list = New-Object System.Collections.Generic.List[System.Object]
foreach ($pod in $pods) {
    $pod = $pod.Replace("pod/", "")
    $containers = kubectl get pod $pod -o jsonpath="{range .status.containerStatuses[*]}{.name}{','}{.lastState.terminated.exitCode}{'\n'}{end}"
    foreach ($container in $containers) {
        $containerArr = $container.Split(",")
        $list.Add([PSCustomObject]@{
                Pod       = $pod
                Container = $containerArr[0]
                Status    = $(
                    if ($containerArr[1]) {
                        $containerArr[1]
                    }
                    else {
                        "-"
                    }
                )
            })
    }
}
$list