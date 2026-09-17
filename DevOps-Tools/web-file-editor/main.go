package main

import (
	"io"
	"log"
	"net/http"
	"os"
	"path/filepath"
)

// Карта для сопоставления расширения файла с языком программирования
var extToLang = map[string]string{
	// Configs
	".yaml": "yaml", ".yml": "yaml", ".json": "json", ".toml": "ini",
	".ini": "ini", ".conf": "ini", ".config": "ini", ".cfg": "ini", ".env": "ini",
	".xml": "xml", ".svg": "xml",
	"Dockerfile": "dockerfile", ".sql": "sql",
	// Docs
	".md": "markdown", ".markdown": "markdown", ".mdx": "mdx",
	// Frontend
	".html": "html", ".htm": "html", ".css": "css", ".scss": "scss",
	".less": "less", ".sass": "scss",
	".js": "javascript", ".mjs": "javascript", ".cjs": "javascript",
	".jsx": "javascript", ".ts": "typescript", ".tsx": "typescript",
	// Backend
	".go": "go", ".rs": "rust", ".py": "python", ".rb": "ruby", ".php": "php",
	".java": "java", ".kt": "kotlin", ".kts": "kotlin", ".cs": "csharp",
	".c": "cpp", ".h": "cpp", ".cpp": "cpp", ".cc": "cpp", ".cxx": "cpp", ".hpp": "cpp",
	".swift": "swift", ".scala": "scala",
	".lua": "lua", ".pl": "perl", ".dart": "dart", ".r": "r",
	// Shell
	".sh": "shell", ".bash": "shell", ".zsh": "shell",
	".ps1": "powershell", ".psm1": "powershell", ".psd1": "powershell",
	".bat": "bat", ".cmd": "bat",
}

func main() {
	// Забираем путь к файлу из аргумента
	if len(os.Args) < 2 {
		log.Fatal("File path not provided")
	}
	filePath := os.Args[1]

	// Парсим название и расширение файла для извлечения языка
	fileName := filepath.Base(filePath)
	ext := filepath.Ext(fileName)
	lang := extToLang[ext]
	if lang == "" {
		lang = extToLang[fileName]
	}
	if lang == "" {
		lang = "plaintext"
	}

	// UI endpoint
	editHandler := func(response http.ResponseWriter, request *http.Request) {
		log.Printf("Request from %s %s\n", request.RemoteAddr, request.UserAgent())
		response.Header().Set("Content-Type", "text/html; charset=utf-8")
		http.ServeFile(response, request, "index.html")
	}

	// API endpoint
	fileHandler := func(response http.ResponseWriter, request *http.Request) {
		// Если метод запроса GET, читаем файл и отдаем в ответе
		if request.Method == http.MethodGet {
			// Передаем заголовок
			response.Header().Set("X-File-Lang", lang)
			// Читаем файл
			data, err := os.ReadFile(filePath)
			// Если ошибка чтения, создаем пустой файл
			if err != nil {
				response.Write([]byte(""))
				return
			}
			// Отдаем файл в теле ответа
			response.Write(data)
		}

		// Если метод запроса POST, читаем содержимое тела запроса и сохраняем в файл
		if request.Method == http.MethodPost {
			log.Println("Save config file")
			body, _ := io.ReadAll(request.Body)
			err := os.WriteFile(filePath, body, 0644)
			if err != nil {
				log.Println("Write error:", err)
				http.Error(response, "Error", 500)
				return
			}
			// Возвращяем код 200
			response.WriteHeader(http.StatusOK)
		}
	}

	// Привязываем пути к обработчикам запросов
	http.HandleFunc("/", editHandler)
	http.HandleFunc("/api", fileHandler)

	port := "8866"
	log.Printf("Editor is listening on http://localhost:%s\n", port)
	log.Println("Press Ctrl+C to exit")

	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		log.Println("Error starting the server:", err)
	}
}
