def stage() {
    echo "\n\u001B[35m=== [STAGE: ${STAGE_NAME}] ===\u001B[0m\n"
}

def info(Object text) {
    echo "\u001B[34m${text}\u001B[0m"
}

def success(Object text) {
    echo "\u001B[32m${text}\u001B[0m"
}

def warn(Object text) {
    echo "\u001B[33m${text}\u001B[0m"
}

def error(Object text) {
    echo "\u001B[31m${text}\u001B[0m"
}

def uncolor(Object text) {
    echo "${text}"
}

def cmd(String script) {
    def result = sh(
        script: script,
        returnStdout: true
    ).trim()
    success(result)
    return result
}

def objectYaml(Object object) {
    def result = writeYaml(
        data: object,
        returnText: true 
    )
    success(result)
    return result
}

def objectJson(Object object) {
    def result = writeJSON(
        json: object,
        returnText: true,
        pretty: 4
    )
    success(result)
    return result
}

def rawJson(String text) {
    def result = readJSON(text: text)
    success(result)
    return result
}

def rawYaml(String text) {
    def result = readYaml(text: text)
    success(result)
    return result
}

def fileJson(String path) {
    def result = readJSON(file: path)
    success(result)
    return result
}

def fileYaml(String path) {
    def result = readYaml(file: path)
    success(result)
    return result
}
