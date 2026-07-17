def env() {
    env.getEnvironment().each { key, value ->
        if (value.startsWith("http")) {
            echo "\u001B[32m${key}\u001B[0m: ${value}"
        } else {
            echo "\u001B[32m${key}\u001B[0m: \u001B[34m${value}\u001B[0m"
        }
    }
}

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

def secret(Object text) {
    def textStr = text.toString()
    warn("${textStr[0]} ${textStr[1..-1]}")
}

def cmd(String script) {
    def result = sh(
        script: script,
        returnStdout: true
    ).trim()
    success(result)
    return result
}

def json(Object data) {
    def objectJson = (data instanceof String) ? readJSON(text: data) : data
    def result = writeJSON(
        json: objectJson,
        returnText: true,
        pretty: 4
    )
    success(result)
    return objectJson
}

def yaml(Object data) {
    def objectYaml = (data instanceof String) ? readYaml(text: data) : data
    def result = writeYaml(
        data: objectYaml,
        returnText: true 
    )
    success(result)
    return objectYaml
}

def file(String path) {
    if (fileExists(path)) {
        def result = readFile(file: path)
        success(result)
        return result
    } else {
        error("File not found")
    }
}

def fileJson(String path) {
    if (fileExists(path)) {
        def result = readJSON(file: path)
        json(result)
        return result
    } else {
        error("File not found")
    }
}

def fileYaml(String path) {
    if (fileExists(path)) {
        def result = readYaml(file: path)
        yaml(result)
        return result
    } else {
        error("File not found")
    }
}

def pathJson(def data, String path) {
    def objectJson = (data instanceof String) ? readJSON(text: data) : data
    def value = path.split('\\.').inject(objectJson) { object, key -> object?."${key}" }
    if (value != null) {
        if (value instanceof Map || value instanceof List) {
            json(value)
        } else {
            success(value.toString())
        }
    }
    return value
}
