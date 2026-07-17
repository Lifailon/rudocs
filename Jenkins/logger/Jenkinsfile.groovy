@Library([
    'rudocs-shared-library@main'
]) _

pipeline {
    agent any
    options {
        ansiColor('xterm')
    }
    stages {
        stage('Check log library') {
            steps {
                script {
                    log.info("Логируем текущий шаг (в начале каждого steps внутри stage)")
                    log.stage()
                    log.info("Логируем все доступные переменные окружения на сборщике Jenkins")
                    log.env()
                    try {
                        log.info("Логируем содержимое секрета")
                        withCredentials([string(
                        credentialsId: 'telegram-token', variable: 'TOKEN'
                        )]) {
                        echo TOKEN
                        log.secret(TOKEN)
                        }
                        log.info("Проверяем версию helm (логируем вывод команды зеленым цветом и извлекаем вывод в переменную)")
                        def version = log.cmd("helm version")
                    } catch (Exception e) {
                        log.info("Логируем предупреждения желтым цветом")
                        log.warn("Ошибка получения версии")
                        log.info("Логируем текст ошибки красным цветом")
                        log.error(e.getMessage())
                        currentBuild.result = 'UNSTABLE'
                    }
                    log.info("Методы json и yaml принимает валидный текст или объект")
                    log.info("Преобразовываем текст в объект и логируем содержимое json в отформатированном виде")
                    def text = '{"name": "dozzle", "enabled": true, "replicas": 2}'
                    def object = log.json(text)
                    if (object.enabled) {
                        log.success("${object.name}: ${object.enabled}")
                        log.info("Количество реплик:")
                        log.pathJson(text, "replicas")
                    }
                    log.info("Логируем содержимое объекта в формате yaml")
                    log.yaml(object)
                    log.info("Записываем содержимое объекта в файл")
                    writeFile(
                        text: text,
                        file: "data.json"
                    )
                    log.info("Логируем содержимое файла")
                    log.file("data.json")
                    log.info("Логируем содержимое в json формате")
                    log.fileJson("data.json")
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
