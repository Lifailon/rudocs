package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"os"
	"strings"
	"text/template"

	"go.yaml.in/yaml/v3"
)

func main() {
	// 1. Объявляем флаги командной строки
	var configPath string
	var templatePath string
	configPathDescription := "path to configuration file in JSON format"
	templatePathDescription := "path to template file"
	flag.StringVar(&configPath, "config", "", configPathDescription)
	flag.StringVar(&configPath, "c", "", configPathDescription)
	flag.StringVar(&templatePath, "template", "", templatePathDescription)
	flag.StringVar(&templatePath, "t", "", templatePathDescription)
	flag.Parse()

	// Проверяем обязательные аргументы
	if templatePath == "" {
		fmt.Fprintln(os.Stderr, "Error: path to template was not passed")
		flag.Usage()
		os.Exit(1)
	}

	// 2. Создаем общую карту для данных шаблона
	templateData := map[string]any{
		"config": make(map[string]any),
		"env":    make(map[string]string),
	}

	// 3. Собираем переменные окружения по умолчанию
	envMap := templateData["env"].(map[string]string)
	for _, env := range os.Environ() {
		pair := strings.SplitN(env, "=", 2)
		if len(pair) == 2 {
			envMap[pair[0]] = pair[1]
		}
	}

	// 4. Читаем и парсим JSON или YAML, если передана конфигурация
	if configPath != "" {
		jsonBytes, err := os.ReadFile(configPath)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error reading configuration: %v\n", err)
			os.Exit(1)
		}
		configMap := templateData["config"].(map[string]any)
		lowerPath := strings.ToLower(configPath)
		// Проверяем расширение файла и выбираем нужный парсер
		if strings.HasSuffix(lowerPath, ".yaml") || strings.HasSuffix(lowerPath, ".yml") {
			if err := yaml.Unmarshal(jsonBytes, &configMap); err != nil {
				fmt.Fprintf(os.Stderr, "Error YAML validation: %v\n", err)
				os.Exit(1)
			}
		} else {
			if err := json.Unmarshal(jsonBytes, &configMap); err != nil {
				fmt.Fprintf(os.Stderr, "Error JSON validation: %v\n", err)
				os.Exit(1)
			}
		}
	}

	// 5. Парсим файл шаблона
	tmpl, err := template.ParseFiles(templatePath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error template parsing: %v\n", err)
		os.Exit(1)
	}

	// 6. Рендерим результат в стандартный вывод (stdout)
	err = tmpl.Execute(os.Stdout, templateData)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error template rendering: %v\n", err)
		os.Exit(1)
	}
}
