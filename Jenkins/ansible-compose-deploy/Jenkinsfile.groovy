pipeline {
    agent {
        label 'linux' // Jenkins Agent with Ansible installed
    }
    options {
        ansiColor('xterm')
        timestamps()
        timeout(time: 10, unit: 'MINUTES')
    }
    parameters {
        credentials(
            name: 'credentials',
            credentialType: 'com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey',
            required: true,
            description: 'SSH Username with private key from Jenkins Credentials for ssh connection.'
        )
        choice(
            name: 'ansible_limit',
            choices: [
                'ARM',
                'AMD'
            ],
            description: 'Select host group in inventory file.'
        )
        string(
            name: 'ansible_port',
            defaultValue: '22',
            description: 'Port for connecting to remote hosts.'
        )
        activeChoice(
            name: 'containers',
            choiceType: 'PT_CHECKBOX',
            filterable: true,
            filterLength: 1,
            script: [
                $class: 'GroovyScript',
                script: [
                    sandbox: true,
                    script: '''
                        return [
                            'node_exporter',
                            'cadvisor',
                            'logporter',
                            'loki_promtail',
                            'dozzle',
                            'beszel',
                            'watchtower'
                        ]
                    '''
                ]
            ]
        )
        string(
            name: 'loki_server',
            defaultValue: 'http://192.168.3.105:3100'
        )
        password(
            name: 'beszel_key'
        )
        password(
            name: 'telegram_bot_api_key'
        )
        password(
            name: 'telegram_chat_id'
        )
    }
    stages {
        stage('Git checkout') {
            steps {
                script {
                    checkout scmGit(
                        branches: [[name: "main"]],
                        userRemoteConfigs: [[url: "https://github.com/Lifailon/parallel-execution-pipeline"]]
                    )
                    sh(script: "rm -rf ./inventories ./playbooks")
                    sh(script:
                        "mv -f " +
                        "./mon-agent-stack-deploy/inventories " +
                        "./mon-agent-stack-deploy/playbooks " +
                        "./mon-agent-stack-deploy/ansible.cfg " +
                        "./"
                    )
                    sh(script: "ls -lh")
                }
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                script {
                    echo "Selected containers: ${params.containers}"
                    def containersArr = params.containers.split(',')
                    def containersParams = [
                        node_exporter: containersArr.contains('node_exporter'),
                        cadvisor: containersArr.contains('cadvisor'),
                        logporter: containersArr.contains('logporter'),
                        loki_promtail: containersArr.contains('loki_promtail'),
                        dozzle: containersArr.contains('dozzle'),
                        beszel: containersArr.contains('beszel'),
                        watchtower: containersArr.contains('watchtower')
                    ]
                    echo "Selected containers: $containersParams"
                    ansiblePlaybook(
                        // playbook: "/home/jenkins/workspace/ansible/playbooks/deploy.yml",
                        // inventory: "/home/jenkins/workspace/ansible/inventories/inventory.ini",
                        playbook: "./playbooks/deploy.yml",
                        inventory: "./inventories/inventory.ini",
                        limit: params.ansible_limit,
                        extraVars: [
                            ansible_port: params.ansible_port,
                            node_exporter: containersParams.node_exporter,
                            cadvisor: containersParams.cadvisor,
                            logporter: containersParams.logporter,
                            loki_promtail: containersParams.loki_promtail,
                            loki_server: params.loki_server,
                            dozzle: containersParams.dozzle,
                            beszel: containersParams.beszel,
                            beszel_key: params.beszel_key,
                            watchtower: containersParams.watchtower,
                            telegram_bot_api_key: params.telegram_bot_api_key,
                            telegram_chat_id: params.telegram_chat_id
                        ],
                        credentialsId: credentials,
                        colorized: true
                    )
                }
            }
        }
    }
}