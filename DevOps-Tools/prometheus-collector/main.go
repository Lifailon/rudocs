package main

import (
	"log"
	"net/http"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/collectors"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

func metricsServer(port, endpoint string) {
	reg := prometheus.NewRegistry()
	reg.MustRegister(
		collectors.NewGoCollector(),
		collectors.NewProcessCollector(collectors.ProcessCollectorOpts{}),
	)
	http.Handle(endpoint, promhttp.HandlerFor(reg, promhttp.HandlerOpts{}))
	log.Printf("Metrics server started on http://127.0.0.1:%s/%s\n", port, endpoint)
	go http.ListenAndServe(":"+port, nil)
}

func main() {
	port := "8866"
	endpoint := "/metrics"
	metricsServer(port, endpoint)
	log.Println("Press Ctrl+C to exit")
	for {
		time.Sleep(1 * time.Second)
	}
}
