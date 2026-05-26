import groovy.json.JsonSlurperClassic

def parseJson(jsonData) {
    def slurper = new JsonSlurperClassic()
    try {
        return slurper.parseText(jsonData) as Map
    } catch (e) {
        return null
    }
}

def getBuildUserId() {
    def cause = currentBuild.rawBuild.getCause(hudson.model.Cause.UserIdCause)
    if (cause != null) {
        return cause.getUserId()
    } else {
        return "jenkins"
    }
}

def log = {
    def m = [:]
    m.stage = { echo "\n\u001B[35m=== [STAGE: ${STAGE_NAME}] ===\u001B[0m\n" }
    m.info = { text -> echo "\u001B[34m${text}\u001B[0m" }
    m.warn = { text -> echo "\u001B[33m${text}\u001B[0m" }
    m.success = { text -> echo "\u001B[32m${text}\u001B[0m" }
    m.error = { text -> echo "\u001B[31m${text}\u001B[0m" }
    m.uncolor = { text -> echo "${text}" }
    return m
}()

pipeline {
    agent {
        label "linux"
    }
    options {
        ansiColor("xterm")
        timestamps()
        timeout(time: 10, unit: "MINUTES")
    }
    parameters {
        string(
            name: "url",
            defaultValue: "https://httpbingo.org/hidden-basic-auth/user/password"
        )
        choice(
            name: "method",
            choices: [
                "GET",
                "POST",
                "PATCH",
                "PUT",
                "DELETE"
            ]
        )
        text(
            name: 'headers',
            description: "Request headers in JSON format",
            defaultValue: '''{
    "Authorization": "Basic dXNlcjpwYXNzd29yZA=="
}'''
        )
        text(
            name: 'body',
            description: "Request body in any format"
        )
        string(
            name: "requestCount",
            description: "The number of parallel requests in the range from 1 to 10",
            defaultValue: "1"
        )
    }
    stages {
        stage("API request") {
            steps {
                script {
                    log.stage()
                    // Карта для хранения списка одинаковых задач
                    def jobs = [:]
                    // Количество параллельных задач
                    def raw = params.requestCount ?: "1"
                    int count = raw.isInteger() ? raw.toInteger() : 1
                    int minCount = Math.max(1, count)
                    int jobsCount = Math.min(minCount, 10)
                    for (int i = 1; i <= jobsCount; i++) {
                        // Избегаем замыкания
                        def index = i
                        // Заполняем карту задач
                        jobs["Request_#${index}"] = {
                            // Массив заголовков
                            def headersArray = []
                            // Добавляем в заголовки имя пользователя, кто запускает Jenkins
                            def buildUserId = getBuildUserId()
                            headersArray.add("-H \"jenkinsUser: ${buildUserId}\"")
                            // Парсим заголовки
                            def headersMap = parseJson(params.headers)
                            if (headersMap != null) {
                                for (header in headersMap) {
                                    def key = header.key
                                    def value = header.value
                                    headersArray.add("-H \"${key}: ${value}\"")
                                }
                            }
                            // Собираем заголовки
                            def headersString = headersArray.join(' ')
                            // Добавляем заголовки по умолчанию, если они не были переданы
                            if (!(headersString =~ /(?i)Content-Type:/).find()) {
                                headersString += " -H \"Content-Type: application/json\""
                            }
                            // Проверяем метод, тело и отправляем запрос
                            def responseCode
                            if (params.method != "GET" && params.body != null && !params.body.trim().isEmpty() ) {
                                // Экранируем двойные кавычки в теле запроса (для ключей и их значений в формате json)
                                def bodyData = params.body.replace('"', '\\"')
                                // Отправляем запрос
                                responseCode = sh(
                                    script: """
                                        curl -sS "${params.url}" \\
                                            -X ${params.method} \\
                                            ${headersString} \\
                                            --data "${bodyData}" \\
                                            -o rebody.json \\
                                            -w %{http_code} || true
                                    """,
                                    returnStatus: false,
                                    returnStdout: true
                                )
                            } else {
                                responseCode = sh(
                                    script: """
                                        curl -sS "${params.url}" \\
                                            -X ${params.method} \\
                                            ${headersString} \\
                                            -o rebody.json \\
                                            -w %{http_code} || true
                                    """,
                                    returnStatus: false,
                                    returnStdout: true
                                )
                            }
                            // Проверяем код ответа
                            if (responseCode == 200 || responseCode == "200") {
                                log.success("Response code: ${responseCode}\n")
                                responseCode = "✅ ${responseCode} "
                            } else {
                                log.warn("Response code: ${responseCode}\n")
                                responseCode = "⚠ ${responseCode} "
                            }
                            // Обновляем название сборки
                            currentBuild.displayName = "#${BUILD_NUMBER} ${responseCode}"
                            // Обновляем описание сборки
                            currentBuild.description = params.method
                            currentBuild.description += " ${params.url}"
                            // Читаем ответ из файла
                            def responseData = ""
                            try {
                                responseData = readFile("${WORKSPACE}/rebody.json")
                            } catch (err) {
                                error "Ошибка чтения ответа"
                            }
                            // Проверяем ответ на ошибки
                            try {
                                // Форматируем ответ в формате json
                                jsonData = writeJSON(
                                    json: responseData,
                                    returnText: true,
                                    pretty: 4
                                )
                                // Красим вывод
                                log.success(jsonData)
                            } catch (err) {
                                log.warn(err.getMessage())
                                log.error(responseData)
                            }
                        }
                    }
                    parallel jobs
                }
            }
        }
    }
    post {
        always {
            script {
                log.stage()
                cleanWs()
            }
        }
    }
}