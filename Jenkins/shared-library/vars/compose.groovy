def generate(Map params = [:]) {
    def serviceName   = (params.serviceName ?: "").trim()
    def containerName = (params.containerName ?: "").trim()
    def image         = (params.image ?: "").trim()
    def restartMode   = (params.restartMode ?: "").trim()
    def user          = (params.user ?: "").trim()
    def command       = (params.command ?: "").trim()
    def ports         = (params.ports ?: "")
    def environment   = (params.environment ?: "")
    def volumes       = (params.volumes ?: "")

    if (!serviceName || !image) {
        error "Required parameters were not passed: serviceName or image"
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

    if (user) {
        composeContent += "    user: ${user}\n"
    }
    if (command) {
        composeContent += "    command: ${command}\n"
    }
    
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
