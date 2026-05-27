def remote = [:]
def composeContent = ""

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
    agent any
    options {
        ansiColor('xterm')
        timestamps()
        timeout(time: 10, unit: 'MINUTES')
    }
    parameters {
        string(
            name: 'image',
            defaultValue: 'lifailon/jenkins-agent:latest',
            description: 'Image name and tag to download from a registry (e.g. Docker Hub).'
        )
        string(
            name: 'stackName',
            defaultValue: 'jenkins-agent',
            description: 'Service and container name.'
        )
        string(
            name: 'stackPath',
            defaultValue: 'docker/jenkins-agent',
            description: 'Directory name or full path to store the stack.'
        )
        choice(
            name: 'restartMode',
            choices: [
                'unless-stopped',
                'always',
                'on-failure',
                'no'
            ],
            description: 'Container restart policy.'
        )
        string(
            name: 'uid',
            defaultValue: '1000:1000',
            description: 'UID:GID.'
        )
        string(
            name: 'command',
            defaultValue: '',
            description: 'Launch command.'
        )
        text(
            name: 'ports',
            defaultValue: '',
            description: 'List of ports in the format host:container (e.g. 8080:80).'
        )
        text(
            name: 'environment',
            defaultValue: 'JENKINS_SERVER_URL=http://192.168.3.101:8010\nJENKINS_AGENT_NAME=remote-agent-01\nJENKINS_SECRET=',
            description: 'List of environment variables.'
        )
        text(
            name: 'volumes',
            defaultValue: './jenkins_agent:/home/jenkins\n/var/run/docker.sock:/var/run/docker.sock',
            description: 'List of volumes.'
        )
        separator(
            name: "sepDep",
            sectionHeader: "Deployment",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        booleanParam(
            name: "deploy",
            defaultValue: false
        )
        string(
            name: 'address',
            defaultValue: '192.168.3.105',
            description: 'Remote host address for deployment.'
        )
        credentials(
            name: 'credentials',
            description: 'SSH Username with private key from Jenkins Credentials for ssh connection.',
            credentialType: 'com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey',
            required: true
        )
        string(
            name: 'user',
            defaultValue: '',
            description: 'Username for ssh connection (by default from credentials parameter).'
        )
        string(
            name: 'port',
            defaultValue: '',
            description: 'Port for ssh connection (by default 22).'
        )
        text(
            name: 'commands',
            defaultValue: 'mkdir -p jenkins_agent\nchown -R 1000:1000 jenkins_agent',
            description: 'List of commands to execute before deployment in the context of the specified directory.'
        )
    }
    environment {
        SSH_KEY_FILE = "/tmp/ssh_key_${UUID.randomUUID().toString()}"
    }
    stages {
        stage('Generating docker-compose file') {
            when {
                expression { params.image && params.stackName }
            }
            steps {
                script {
                    log.stage()
                    currentBuild.displayName = "#${BUILD_NUMBER} ${params.stackName}"
                    composeContent = "services:\n"
                    composeContent += "  ${params.stackName.trim()}:\n"
                    composeContent += "    image: ${params.image.trim()}\n"
                    composeContent += "    container_name: ${params.stackName.trim()}\n"
                    composeContent += "    restart: ${params.restartMode}\n"
                    if (params.uid?.trim()) {
                        composeContent += "    user: ${params.uid.trim()}\n"
                    }
                    if (params.command?.trim()) {
                        composeContent += "    command: ${params.command.trim()}\n"
                    }
                    if (params.ports?.trim()) {
                        composeContent += "    ports:\n"
                        params.ports.stripIndent().tokenize('\n').each { port ->
                            if (port.trim()) {
                                composeContent += "      - \"${port.trim()}\"\n"
                            }
                        }
                    }
                    if (params.environment?.trim()) {
                        composeContent += "    environment:\n"
                        params.environment.stripIndent().tokenize('\n').each { env ->
                            if (env.trim()) {
                                composeContent += "      - ${env.trim()}\n"
                            }
                        }
                    }
                    if (params.volumes?.trim()) {
                        composeContent += "    volumes:\n"
                        params.volumes.stripIndent().tokenize('\n').each { volume ->
                            if (volume.trim()) {
                                composeContent += "      - ${volume.trim()}\n"
                            }
                        }
                    }
                    log.success(composeContent)
                    currentBuild.description = composeContent
                }
            }
        }
        stage('Get ssh credentials') {
            when {
                expression { params.deploy && params.address && params.credentials }
            }
            steps {
                script {
                    log.stage()
                    currentBuild.displayName = "#${BUILD_NUMBER} ${params.stackName} => ${params.address}"
                    withCredentials(
                        [
                            sshUserPrivateKey(
                                credentialsId: params.credentials,
                                usernameVariable: 'SSH_USER',
                                keyFileVariable: 'SSH_KEY',
                                passphraseVariable: ''
                            )
                        ]
                    ) {
                        writeFile(
                            file: env.SSH_KEY_FILE,
                            text: readFile(SSH_KEY)
                        )
                        sh "chmod 600 ${env.SSH_KEY_FILE}"
                        remote.name = params.address
                        remote.host = params.address
                        remote.user = params.user ? params.user : SSH_USER
                        remote.port = params.port ? params.port.toInteger() : 22
                        remote.identityFile = env.SSH_KEY_FILE
                        remote.allowAnyHosts = true
                    }
                    echo "SSH username: ${remote.user}"
                    echo "SSH port: ${remote.port}"
                }
            }
        }
        stage('Deploy docker-compose file') {
            when {
                expression { params.deploy && params.address && params.credentials }
            }
            steps {
                script {
                    log.stage()
                    sshCommand(
                        remote: remote,
                        command: "mkdir -p ${params.stackPath}"
                    )
                    writeFile(
                        file: 'docker-compose.yml',
                        text: composeContent
                    )
                    sshPut(
                        remote: remote,
                        from: 'docker-compose.yml',
                        into: params.stackPath
                    )
                    def commandsArr = params.commands.split('\n')
                    for (cmd in commandsArr) {
                        sshCommand(
                            remote: remote,
                            command: "cd ${params.stackPath} && ${cmd}"
                        )
                    }
                    sshCommand(
                        remote: remote,
                        command: "bash -ic 'cd ${params.stackPath} && docker-compose up -d || docker compose up -d --force-recreate'"
                    )
                    sleep(
                        time: 10,
                        unit: 'SECONDS'
                    )
                    sshCommand(
                        remote: remote,
                        command: "bash -ic 'docker logs ${params.stackName}'"
                    )
                }
            }
        }
    }
}