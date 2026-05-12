discovery.docker "linux" {
  host = "unix:///var/run/docker.sock"
}

discovery.relabel "local_containers" {
  targets = discovery.docker.linux.targets
  rule {
    action = "replace"
    source_labels = ["__meta_docker_container_name"]
    target_label = "service_name"
  }
}

pyroscope.write "staging" {
  endpoint {
    url = "http://pyroscope:4040"
  }
}

pyroscope.ebpf "default" {
  forward_to   = [ pyroscope.write.staging.receiver ]
  targets      = discovery.relabel.local_containers.output
}