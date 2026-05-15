def remote = [:]

pipeline {
    agent {
        label 'linux' // Jenkins Agent with ping and nc installed (optional)
    }
    parameters {
        string(
            name: 'address',
            defaultValue: '192.168.3.105',
            description: 'IP or FQDN remote host.'
        )
        credentials(
            name: 'credentials',
            defaultValue: '',
            description: 'Username with password from Jenkins Credentials for ssh connection.',
            credentialType: 'com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl',
            required: true
        )
        string(
            name: 'port',
            defaultValue: '',
            description: 'SSH port (by default 22).'
        )
        booleanParam(
            name: 'checkHost',
            defaultValue: true,
            description: 'Checking host availability (icmp and tcp).'
        )
        booleanParam(
            name: 'getUsers',
            defaultValue: true,
            description: 'Get list of current users in the remote system.'
        )
    }
    stages {
        stage('Checking host availability (icmp and tcp)') {
            when {
                expression { params.checkHost }
            }
            steps {
                script {
                    def check = sh(
                        script: """
                            ping -c 1 ${params.address} > /dev/null || exit 1
                            nc -z ${params.address} ${params.port} || exit 2
                        """,
                        returnStatus: true
                    )
                    if (check == 1) {
                        error("Host ${params.address} unavailable (icmp ping)")
                    } else if (check == 2) {
                        error("Port ${params.port} closed (tcp check)")
                    } else {
                        echo "Host ${params.address} available and port ${params.port} open"
                    }
                }
            }
        }
        stage('Get ssh credentials') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: params.credentials, usernameVariable: 'SSH_USER', passwordVariable: 'SSH_PASS')]) {
                        remote.name = params.address
                        remote.host = params.address
                        remote.port = params.port ? params.port.toInteger() : 22
                        remote.user = env.SSH_USER
                        remote.password = env.SSH_PASS
                        remote.allowAnyHosts = true
                    }
                }
            }
        }
        stage('Update user list and parameters') {
            when {
                expression { params.getUsers }
            }
            steps {
                script {
                    currentBuild.displayName = "#${BUILD_NUMBER} get user list on ${params.address}"
                    def users = sshCommand(
                        remote: remote,
                        command: "echo \$(ls /home)"
                    )
                    def usersList = users.trim().split("\\s")
                    usersList += "root"
                    def usersListChoice = usersList.toList()
                    properties([
                        parameters([
                            string(
                                name: 'address',
                                defaultValue: '192.168.3.105',
                                description: 'IP or FQDN remote host.'
                            ),
                            credentials(
                                name: 'credentials',
                                defaultValue: "${params.credentials}",
                                description: 'Username with password from Jenkins Credentials for ssh connection.',
                                credentialType: 'com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl',
                                required: true
                            ),
                            string(
                                name: 'port',
                                defaultValue: "${remote.port}",
                                description: 'SSH port (by default 22).'
                            ),
                            booleanParam(
                                name: 'checkHost',
                                defaultValue: false,
                                description: 'Checking host availability (icmp and tcp).'
                            ),
                            booleanParam(
                                name: 'getUsers',
                                defaultValue: false,
                                description: 'Get list of current users in the remote system.'
                            ),
                            choice(
                                name: 'userList',
                                choices: usersListChoice,
                                description: 'List of available users'
                            ),
                            password(
                                name: 'sshKey',
                                description: 'Public ssh key for add to authorized_keys.'
                            ),
                            booleanParam(
                                name: 'rewriteKey',
                                defaultValue: false,
                                description: 'Overwrite current keys in authorized_keys file.'
                            )
                        ])
                    ])
                }
            }
        }
        stage('Update authorized_keys') {
            when {
                expression { !params.getUsers && params.sshKey }
            }
            steps {
                script {
                    currentBuild.displayName = "#${BUILD_NUMBER} update keys on ${params.address}"
                    writeFile(
                        file: "key.txt",
                        text: "${params.sshKey}\n"
                    )
                    sshPut(
                        remote: remote,
                        from: "key.txt",
                        into: "./.ssh/key.txt"
                    )
                    def selectedUser = params.userList
                    def path = ""
                    if (selectedUser == "root") {
                        path = "/root/.ssh/authorized_keys"
                    } else {
                        path = "/home/${selectedUser}/.ssh/authorized_keys"
                    }
                    def teeCommand = ""
                    if (params.rewriteKey) {
                        teeCommand = "tee"
                    } else {
                        teeCommand = "tee -a"
                    }
                    sshCommand(
                        remote: remote,
                        command: """
                            mkdir -p .ssh;
                            cat ./.ssh/key.txt | $teeCommand $path > /dev/null
                            rm ./.ssh/key.txt
                            ls -lh ./.ssh
                        """
                    )
                    properties([
                        parameters([
                            string(
                                name: 'address',
                                defaultValue: '192.168.3.105',
                                description: 'IP or FQDN remote host.'
                            ),
                            credentials(
                                name: 'credentials',
                                defaultValue: '',
                                description: 'Username with password from Jenkins Credentials for ssh connection.',
                                credentialType: 'com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl',
                                required: true
                            ),
                            string(
                                name: 'port',
                                defaultValue: '',
                                description: 'SSH port (by default 22).'
                            ),
                            booleanParam(
                                name: 'checkHost',
                                defaultValue: true,
                                description: 'Checking host availability (icmp and tcp).'
                            ),
                            booleanParam(
                                name: 'getUsers',
                                defaultValue: true,
                                description: 'Get list of current users in the remote system.'
                            )
                        ])
                    ])
                }
            }
        }
    }
    post {
        always {
            script {
                sh "rm -f key.txt"
            }
        }
    }
}