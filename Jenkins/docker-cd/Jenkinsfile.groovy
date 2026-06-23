@Library([
    'rudocs-shared-library@main'
]) _

def remote = [:]
def composeContent = ""

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
            name: 'command',
            defaultValue: '',
            description: 'Launch command.'
        )
        string(
            name: 'user',
            defaultValue: '1000:1000',
            description: 'UID:GID.'
        )
        text(
            name: 'groups',
            defaultValue: '110',
            description: 'GID.'
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
                    def composeFile = compose.generate(
                        serviceName: params.stackName,
                        image: params.image,
                        restartMode: params.restartMode,
                        command: params.command,
                        user: params.user,
                        groups: params.groups,
                        environment: params.environment,
                        volumes: params.volumes,
                    )
                    log.success(composeFile)
                    currentBuild.description = composeFile
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