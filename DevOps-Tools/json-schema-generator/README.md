## JSON Schema Generator

**JSON Schema** - это стандарт и декларативный язык описания структуры данных в формате `JSON`, который определяет, какие ключи, значения и типы данных могут находиться в `JSON` или `YAML` файле.

При описание конфигурации в IDE будет отображаться список полей, доступных для заполнения в рамках контракта, заданного в схеме.

Входной файл:

```yaml
name: app
replicas: 1
version: 1.5
enabled: true
env:
  - log=debug
args:
  - port
  - 80
conf:
  enabled: true
```

Запуск генерации:

```bash
go run main.go values.yaml
```

Вывод:

```json
{
  "additionalProperties": false,
  "properties": {
    "args": {
      "items": {
        "oneOf": [
          {
            "type": "string"
          },
          {
            "type": "integer"
          }
        ]
      },
      "type": "array"
    },
    "conf": {
      "additionalProperties": false,
      "properties": {
        "enabled": {
          "type": "boolean"
        }
      },
      "type": "object"
    },
    "enabled": {
      "type": "boolean"
    },
    "env": {
      "items": {
        "type": "string"
      },
      "type": "array"
    },
    "name": {
      "type": "string"
    },
    "replicas": {
      "type": "integer"
    },
    "version": {
      "type": "number"
    }
  },
  "type": "object"
}
```

В Helm-чартах Kubernetes стандартом является размещение файла `values.schema.json` в корневой директории чарта, рядом с `values.yaml` по умолчанию.

Пример генерация схемы для переменных чартов в данном репозитории:

```bash
go run main.go ..\..\Kubernetes\diun\values.yaml > ..\..\Kubernetes\diun\values.schema.yaml
go run main.go ..\..\Kubernetes\dozzle\values.yaml > ..\..\Kubernetes\dozzle\values.schema.yaml
go run main.go ..\..\Kubernetes\gatus\values.yaml > ..\..\Kubernetes\gatus\values.schema.yaml
```