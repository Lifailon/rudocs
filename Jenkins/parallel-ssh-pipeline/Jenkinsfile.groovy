pipeline {
    agent any
    options {
        ansiColor('xterm')
        timeout(time: 10, unit: 'MINUTES')
    }
    parameters {
        text(
            name: 'hostlist',
            defaultValue: 'lifailon@192.168.3.101:2121\nlifailon@192.168.3.105:2121\nlifailon@192.168.3.106:2121',
            description: 'List of remote host addresses.\nFormat: <USERNAME@HOSTNAME:PORT>.'
        )
        credentials(
            name: 'credentials',
            description: 'SSH Username with private key from Jenkins Credentials for ssh connection.',
            credentialType: 'com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey',
            required: true
        )
        text(
            name: 'commands',
            defaultValue: 'uname -a\nuptime\nfree -hL\ndf -h /\ntop -bn2 | grep "Cpu(s)"',
            description: 'List of commands from a new line.'
        )
        booleanParam(
            name: "color",
            defaultValue: true,
            description: 'Enable output coloring.'
        )
    }
    environment {
        SSH_KEY_FILE = "/tmp/ssh_key_${UUID.randomUUID().toString()}"
    }
    stages {
        stage('Get ssh key') {
            steps {
                script {
                    withCredentials(
                        [
                            sshUserPrivateKey(
                                credentialsId: params.credentials,
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
                    }
                }
            }
        }
        stage('Install pussh') {
            steps {
                script {
                    sh """
                        curl -s https://raw.githubusercontent.com/bearstech/pussh/refs/heads/master/pussh -o pussh
                        chmod +x ./pussh
                    """
                }
            }
        }
        stage('Run pussh') {
            steps {
                script {
                    def hostlist = params.hostlist.split('\n').collect{it.trim()}.findAll{it}.join(',')
                    def commandsArray = params.commands.split('\n').collect{it.trim()}.findAll{it}
                    for (command in commandsArray) {
                        if (params.color) {
                            sh """
                                ./pussh -c \\
                                -s '-o StrictHostKeyChecking=no -i ${SSH_KEY_FILE}' \\
                                -h ${hostlist} \\
                                ${command}
                            """
                        } else {
                            sh """
                                ./pussh \\
                                -s '-o StrictHostKeyChecking=no -i ${SSH_KEY_FILE}' \\
                                -h ${hostlist} \\
                                ${command}
                            """
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                sh """
                    rm -f ./pussh ${SSH_KEY_FILE}
                    ls -lhR
                """
            }
        }
    }
}