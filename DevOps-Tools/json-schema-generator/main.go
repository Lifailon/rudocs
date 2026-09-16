package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"

	"go.yaml.in/yaml/v3"
)

// Функция для парсинга типов данных и наполнения схемы
func jsonSchemaGenerate(object any) map[string]any {
	schema := make(map[string]any)
	switch obj := object.(type) {
	case nil:
		schema["type"] = "null"
	// Булевые значения (true/false)
	case bool:
		schema["type"] = "boolean"
	// Строки
	case string:
		schema["type"] = "string"
	// Целые и беззнаковые (только положительные) числа
	case int, int8, int16, int32, int64, uint, uint8, uint16, uint32, uint64:
		schema["type"] = "integer"
	// Дробные (с плавающей точкой) числа
	case float32, float64:
		schema["type"] = "number"
	// Если массив, собираем все уникальные типы данных из элементов массива
	case []any:
		schema["type"] = "array"
		if len(obj) > 0 {
			//
			var uniqueTypes []map[string]any
			typeUsed := make(map[string]bool)
			for _, item := range obj {
				// Извлекаем тип данных через функцию
				itemType := jsonSchemaGenerate(item)
				// Конвертируем тип данных из объекта в строку
				jsonBytes, _ := json.Marshal(itemType)
				schemaStr := string(jsonBytes)
				// Проверяем, что тип данных не использовался ранее
				if !typeUsed[schemaStr] {
					typeUsed[schemaStr] = true
					uniqueTypes = append(uniqueTypes, itemType)
				}
			}
			// Заполняем смешанный массив, если уникальных типов больше одного
			if len(uniqueTypes) > 1 {
				schema["items"] = map[string]any{
					"oneOf": uniqueTypes,
				}
			} else {
				schema["items"] = uniqueTypes[0]
			}
		} else {
			schema["items"] = map[string]any{}
		}
	// Если объект
	case map[string]any:
		schema["type"] = "object"
		schema["additionalProperties"] = false
		props := make(map[string]any)
		for key, value := range obj {
			props[key] = jsonSchemaGenerate(value)
		}
		schema["properties"] = props
	}
	return schema
}

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
	if err := yaml.Unmarshal(data, &object); err != nil {
		log.Fatalf("Invalid JSON or YAML file, %v", err)
	}

	// Генерируем схему (сначала всегда срабатывает условие объекта)
	schema := jsonSchemaGenerate(object)

	// Конвертируем схема в json
	out, _ := json.MarshalIndent(schema, "", "  ")

	fmt.Println(string(out))
}
