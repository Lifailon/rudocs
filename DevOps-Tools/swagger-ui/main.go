package main

import (
	"encoding/json"
	"log"
	"net/http"
	"os"

	"github.com/swaggest/swgui/v5emb"
	"gopkg.in/yaml.v3"
)

func main() {
	// Проверяем и получаем путь к файлу из аргументов
	if len(os.Args) < 2 {
		log.Fatal("Path to the JSON or YAML file was not provided")
	}
	filePath := os.Args[1]

	// Читаем содержимое файла в переменную
	data, err := os.ReadFile(filePath)
	if err != nil {
		log.Fatalf("Failed to read %s file: %v", filePath, err)
	}

	var object any

	// Конвертируем YAML или JSON в объект
	err = yaml.Unmarshal(data, &object)
	if err != nil {
		log.Fatalf("Invalid JSON or YAML file, %v", err)
	}

	// Конвертируем объект обратно в JSON
	jsonData, err := json.Marshal(object)
	if err != nil {
		log.Fatalf("Failed to convert to JSON: %v", err)
	}

	// Путь к интефрейсу документации
	docsEndpoint := "/docs/"
	// Путь к файлу спецификации на веб-сервере
	fileEndpoint := "/docs/openapi.json"

	docsHandler := v5emb.New(
		"API Documentation",
		fileEndpoint,
		docsEndpoint,
	)
	http.Handle(docsEndpoint, docsHandler)

	fileHandler := func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.Write(jsonData)
	}
	http.HandleFunc(fileEndpoint, fileHandler)

	// Переадресация корневого пути в конечную точку docs UI
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		http.Redirect(w, r, docsEndpoint, http.StatusFound)
	})

	port := "8866"
	log.Printf("Swagger Docs UI from %s started on http://127.0.0.1:%s%s", filePath, port, docsEndpoint)
	http.ListenAndServe(":"+port, nil)
}
