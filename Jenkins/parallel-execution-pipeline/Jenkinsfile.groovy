def remote = [:]

def resetColor = '\033[0m'
def colors = [
    '\033[32m', // Зеленый
    '\033[34m', // Синий
    '\033[33m', // Желный
    '\033[36m', // Голубой
    '\033[31m', // Красный
    '\033[35m', // Пурпурный
]

pipeline {
    agent any
    options {
        ansiColor('xterm') // https://plugins.jenkins.io/ansicolor
        timestamps()
        timeout(time: 10, unit: 'MINUTES')
    }
    parameters {
        text(
            name: 'addresses',
            defaultValue: '192.168.3.105\n192.168.3.106',
            description: 'List of remote host addresses.'
        )
        booleanParam(
            name: "multiHosts",
            defaultValue: false,
            description: 'Executing commands on multiple hosts in parallel (by default parallel execution of commands on first host).'
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
            defaultValue: 'sleep 6 && echo Complete sleep 6 sec on $(hostname)\nsleep 8 && echo Complete sleep 8 sec on $(hostname)\nsleep 4 && echo Complete sleep 4 sec on $(hostname)',
            description: 'List of commands from a new line.'
        )
        booleanParam(
            name: "color",
            defaultValue: true,
            description: 'Enable output coloring (used OpenSSH client on Agent).'
        )
    }
    environment {
        SSH_KEY_FILE = "/tmp/ssh_key_${UUID.randomUUID().toString()}"
    }
    stages {
        // Извлечение данных для авторизации по ключу
        stage('Get ssh credentials') {
            steps {
                script {
                    withCredentials(
                        [
                            // https://plugins.jenkins.io/ssh-steps
                            sshUserPrivateKey(
                                credentialsId: params.credentials,
                                usernameVariable: 'SSH_USER',
                                keyFileVariable: 'SSH_KEY',
                                passphraseVariable: ''
                            )
                        ]
                    ) {
                        // Записываем содержимое приватного ключа во временный файл для использования в следующих шагах
                        writeFile(
                            file: env.SSH_KEY_FILE,
                            text: readFile(SSH_KEY)
                        )
                        sh "chmod 600 ${env.SSH_KEY_FILE}"
                        // remote.name = params.address
                        // remote.host = params.address
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
        // Параллельное выполнение команд на первом хосте
        stage('Parallel execution of commands on first host') {
            when {
                expression { ! params.multiHosts }
            }
            steps {
                script {
                    // Формируем массив из списка хостов (удаляем пробелы и пустые значения во всех элементах массива)
                    def addressList = params.addresses.split('\n').collect{it.trim()}.findAll{it}
                    // Извлекаем первый хост из массива и заполняем имя для подключения
                    def address = addressList[0]
                    remote.name = address
                    remote.host = address
                    // Создаем карту для хранения массива команд
                    def mapParallelCommands = [:]
                    // Разбиваем текстовый параметр команд на массив из строк
                    def commandsList = params.commands.split('\n').collect{it.trim()}.findAll{it}
                    // Формируем массив команд с параметрами запуска в ssh
                    for (int i = 0; i < commandsList.size(); i++) {
                        // Извлекаем команду
                        def cmd = commandsList[i]
                        // Извлекаем порядковый номер индекса в цикличном массиве цветов для покраски вывода
                        def color = colors[i % colors.size()]
                        // Заполняем карту
                        mapParallelCommands["Command ${i+1}"] = {
                            try {
                                if ( params.color ) {
                                    // Дублирует вывод с покраской
                                    // def output = sshCommand remote: remote, command: cmd
                                    // echo "${color}${output}${resetColor}"
                                    def output = sh(
                                        script: """
                                            ssh -o StrictHostKeyChecking=no \\
                                                -i '${SSH_KEY_FILE}' \\
                                                -p ${remote.port} \\
                                                ${remote.user}@${address} \\
                                                '${cmd}'
                                        """,
                                        returnStdout: true
                                    )
                                    // Добавляем покраску для вывод
                                    echo "${color}${output}${resetColor}"
                                } else {
                                    sshCommand remote: remote, command: cmd
                                }
                            } catch (err) {
                                echo "${color}Error: ${err}${resetColor}"
                            }
                        }
                    }
                    // Запускаем параллельное выполнение всех команд
                    parallel mapParallelCommands
                    sleep 1
                }
            }
        }
        // Последовательное выполнение команд параллельно на нескольких хостах
        stage('Executing commands on multiple hosts in parallel') {
            when {
                expression { params.multiHosts }
            }
            steps {
                script {
                    // Создаем пустую карту из списка хостов с одной командой в каждом значение
                    def mapParallelCommands = [:]  
                    // Получаем массив из списка команд и хостов
                    def commandsList = params.commands.split('\n').collect{it.trim()}.findAll{it}
                    def addressList = params.addresses.split('\n').collect{it.trim()}.findAll{it}
                    // Проходимся по хостам
                    for (int i = 0; i < addressList.size(); i++) {
                        // Извлекаем имя хоста для подключения
                        def address = addressList[i]
                        def color = colors[i % colors.size()]
                        // Заполняем карту с циклом из всех команд (сихнронное выполнение) для параллельного выполнения на каждом хосте
                        mapParallelCommands[address] = {
                            // Запускаем команды синхронно
                            for (int ci = 0; ci < commandsList.size(); ci++) {
                                // Обновляем имя хоста для каждой команды
                                remote.name = address
                                remote.host = address
                                // Извлекаем и выполняем команду
                                def cmd = commandsList[ci]
                                try {
                                    if ( params.color ) {
                                        def output = sh(
                                            script: """
                                                ssh -o StrictHostKeyChecking=no \\
                                                    -i '${SSH_KEY_FILE}' \\
                                                    -p ${remote.port} \\
                                                    ${remote.user}@${address} \\
                                                    '${cmd}'
                                            """,
                                            returnStdout: true
                                        )
                                        echo "${color}${output}${resetColor}"
                                    } else {
                                        sshCommand remote: remote, command: cmd
                                    }
                                } catch (err) {
                                    echo "${color}Error: ${err}${resetColor}"
                                }
                            }
                        }
                    }
                    // Запускаем цикл из набора команд параллельно на каждом хосте
                    parallel mapParallelCommands
                    sleep 1
                }
            }
        }
    }
    post {
        always {
            script {
                // Удалить временный файл с содержимым закрытого ключа на агенте
                sh "rm -f ${env.SSH_KEY_FILE}"
            }
        }
    }
}