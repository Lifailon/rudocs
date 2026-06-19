def stage() {
    echo "\n\u001B[35m=== [STAGE: ${STAGE_NAME}] ===\u001B[0m\n"
}

def info(Object text) {
    echo "\u001B[34m${text}\u001B[0m"
}

def warn(Object text) {
    echo "\u001B[33m${text}\u001B[0m"
}

def success(Object text) {
    echo "\u001B[32m${text}\u001B[0m"
}

def error(Object text) {
    echo "\u001B[31m${text}\u001B[0m"
}

def uncolor(Object text) {
    echo "${text}"
}
