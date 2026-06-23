def generate(Map params = [:]) {
    def serviceName   = (params.serviceName ?: "").trim()
    def containerName = (params.containerName ?: "").trim()
    def image         = (params.image ?: "").trim()
    def restartMode   = (params.restartMode ?: "").trim()
    def command       = (params.command ?: "").trim()
    def user          = (params.user ?: "").trim()
    def groups        = (params.groups ?: "")
    def ports         = (params.ports ?: "")
    def environment   = (params.environment ?: "")
    def volumes       = (params.volumes ?: "")

    if (!serviceName || !image) {
        error "Required parameters were not passed: serviceName or image"
    }

    def groupsArr = ""
    if (groups.trim()) {
        groupsArr += "    group_add:\n"
        for (line in groups.stripIndent().readLines()) {
            if (line.trim()) {
                groupsArr += "      - ${line.trim()}\n"
            }
        }
    }

    def portsArr = ""
    if (ports.trim()) {
        portsArr += "    ports:\n"
        for (line in ports.stripIndent().readLines()) {
            if (line.trim()) {
                portsArr += "      - \"${line.trim()}\"\n"
            }
        }
    }

    def envArr = ""
    if (environment.trim()) {
        envArr += "    environment:\n"
        for (line in environment.stripIndent().readLines()) {
            if (line.trim()) {
                envArr += "      - ${line.trim()}\n"
            }
        }
    }

    def volumesArr = ""
    if (volumes.trim()) {
        volumesArr += "    volumes:\n"
        for (line in volumes.stripIndent().readLines()) {
            if (line.trim()) {
                volumesArr += "      - ${line.trim()}\n"
            }
        }
    }

    def cn = containerName ?: serviceName
    def restartModes = ["unless-stopped", "always", "on-failure", "no"]
    def rm = restartModes.contains(restartMode) ? restartMode : "unless-stopped"

    def composeContent = "services:\n"
    composeContent += "  ${serviceName}:\n"
    composeContent += "    image: ${image}\n"
    composeContent += "    container_name: ${cn}\n"
    composeContent += "    restart: ${rm}\n"

    if (command) {
        composeContent += "    command: ${command}\n"
    }

    if (user) {
        composeContent += "    user: ${user}\n"
    }
    
    composeContent += groupsArr
    composeContent += portsArr
    composeContent += envArr
    composeContent += volumesArr

    return composeContent
}

def up(
    String file = "docker-compose.yml",
    boolean detach = true,
    boolean recreate = false,
    boolean build = false
) {
    def command = "docker compose -f ${file} up --remove-orphans"
    if (detach) {
        command += " -d"
    }
    if (recreate) {
        command += " --force-recreate"
    }
    if (build) {
        command += " --build"
    }
    sh command
}

def down(
    String file = "docker-compose.yml",
    boolean volumes = false,
    String rmi = "none"
) {
    def command = "docker compose -f ${file} down --remove-orphans"
    if (volumes) {
        command += " -v"
    }
    if (rmi == "local" || rmi == "all") {
        command += " --rmi ${rmi}"
    }
    sh command
}

def logs(
    String tail = "all",
    boolean color = true,
    boolean prefix = true,
    boolean timestamps = true
) {
    def command = "docker compose logs -n ${tail}"
    if (!color) {
        command += " --no-color"
    }
    if (!prefix) {
        command += " --no-log-prefix"
    }
    if (timestamps) {
        command += " -t"
    }
    sh command
}
