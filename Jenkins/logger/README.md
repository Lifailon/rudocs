# Telegram Notify

Jenkins Pipeline для отладки функции `log` из библиотеки `rudocs-shared-library`.

Примеры использования методов с описанием:

```groovy
// Логируем текущий шаг (в начале каждого steps внутри stage)
log.stage()
// Логируем все доступные переменные окружения на сборщике Jenkins
log.env()

try {
    // Логируем содержимое секрета
    withCredentials([string(
    credentialsId: 'telegram-token', variable: 'TOKEN'
    )]) {
    echo TOKEN
    log.secret(TOKEN)
    }
    // Логируем произвольный текст синим цветом
    log.info("Проверяем версию helm")
    // Логируем вывод команды зеленым цветом и извлекаем вывод в переменную
    def version = log.cmd("helm version")
} catch (Exception e) {
    // Логируем предупреждения желтым цветом
    log.warn("Ошибка получения версии")
    // Логируем текст ошибки красным цветом
    log.error(e.getMessage())
    currentBuild.result = 'UNSTABLE'
}

// Методы json и yaml принимает валидный текст или объект
// Преобразовываем текст в объект и логируем содержимое json в отформатированном виде
def text = '{"name": "dozzle", "enabled": true, "replicas": 2}'
def object = log.json(text)
if (object.enabled) {
    log.success("${object.name}: ${object.enabled}")
    log.info("Количество реплик:")
    log.pathJson(text, "replicas")
}

// Логируем содержимое объекта в формате yaml
log.yaml(object)

// Записываем содержимое объекта в файл
writeFile(
    text: text,
    file: "data.json"
)
// Логируем содержимое файла
log.file("data.json")
// Логируем содержимое в json формате
log.fileJson("data.json")
```
