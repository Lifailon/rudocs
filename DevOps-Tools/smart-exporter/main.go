package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"runtime"
	"strings"
)

type SMART struct {
	diskName     string
	temperature  string
	powerOnCount string
	powerOnHours string
}

func getDiskList(smartPath string) ([]string, error) {
	var dirArr []string
	dirs, err := os.ReadDir(smartPath)
	if err != nil {
		return dirArr, err
	}
	for _, dir := range dirs {
		if dir.IsDir() {
			dirArr = append(dirArr, dir.Name())
		}
	}
	return dirArr, nil
}

func readScv(csvPath string) (string, error) {
	var value string
	data, err := os.ReadFile(csvPath)
	if err != nil {
		return value, err
	}
	dataString := strings.TrimSpace(string(data))
	lines := strings.Split(dataString, "\n")
	lastLine := lines[len(lines)-1]
	csvArr := strings.Split(lastLine, ",")
	value = csvArr[len(csvArr)-1]
	return value, nil
}

func getMetrics(smartPath string, diskList []string) []string {
	var smartMetrics = map[string]*SMART{}

	for _, diskName := range diskList {
		var diskPath string = smartPath + "/" + diskName + "/"

		var tempPath string = diskPath + "Temperature.csv"
		temp, err := readScv(tempPath)
		if err != nil {
			log.Fatal(err)
		}

		tempPath = diskPath + "PowerOnCount.csv"
		powerOnCount, err := readScv(tempPath)
		if err != nil {
			log.Printf("Error read file: %s\n", err)
		}

		tempPath = diskPath + "PowerOnHours.csv"
		powerOnHours, err := readScv(tempPath)
		if err != nil {
			log.Printf("Error read file: %s\n", err)
		}

		smartMetrics[diskName] = &SMART{}
		smartMetrics[diskName].diskName = strings.ReplaceAll(diskName, " ", "-")
		smartMetrics[diskName].temperature = temp
		smartMetrics[diskName].powerOnCount = powerOnCount
		smartMetrics[diskName].powerOnHours = powerOnHours
	}

	var metrics []string = []string{}

	for _, metric := range smartMetrics {
		metricsData := prometheusFormat(
			"disk_temperature",
			"gauge",
			"Disk temperature in Celsius",
			metric.diskName,
			metric.temperature,
		)
		metrics = append(metrics, metricsData...)

		metricsData = prometheusFormat(
			"disk_power_on_count",
			"counter",
			"Count of launch",
			metric.diskName,
			metric.powerOnCount,
		)
		metrics = append(metrics, metricsData...)

		metricsData = prometheusFormat(
			"disk_power_on_hours",
			"counter",
			"Count of running in hours",
			metric.diskName,
			metric.powerOnHours,
		)

		metrics = append(metrics, "")
	}

	return metrics
}

func prometheusFormat(metricName, typeData, helpText, diskName string, value any) []string {
	var metricsText []string

	metricsText = append(metricsText, "# HELP "+metricName+" "+helpText)
	metricsText = append(metricsText, "# TYPE "+metricName+" "+typeData)
	metricsLine := fmt.Sprintf(
		"%s{diskName=\"%s\"} %v",
		metricName, diskName, value,
	)
	metricsText = append(metricsText, metricsLine)

	return metricsText
}

func main() {
	getOS := runtime.GOOS
	var smartPath string = "C:/Program Files/CrystalDiskInfo/Smart"
	if getOS != "windows" {
		smartPath = strings.Replace(smartPath, "C:", "/mnt/c", 1)
	}

	diskList, err := getDiskList(smartPath)
	if err != nil {
		log.Fatal(err)
	}

	metricsObject := getMetrics(smartPath, diskList)

	var metricsText string
	for _, m := range metricsObject {
		// fmt.Println(m)
		metricsText += m + "\n"
	}

	handler := func(response http.ResponseWriter, request *http.Request) {
		fmt.Fprintln(response, metricsText)
	}

	http.HandleFunc("/", handler)

	port := "8866"
	log.Printf("SMART Exporter is listening on http://localhost:%s\n", port)
	log.Println("Press Ctrl+C to exit")

	err = http.ListenAndServe(":"+port, nil)
	if err != nil {
		log.Println("Error starting the server:", err)
	}
}
