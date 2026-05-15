def remote = [:]

def binName = ""
def binPath = ""
def binFullPath = ""

def archAgent = ""
def getArch = """
    ARCH=\$(uname -m)
    case \$ARCH in
        x86_64|amd64)   echo amd64 ;;
        aarch64)        echo arm64 ;;
    esac
"""

def colorGreen = "\033[32m"
def colorReset = "\033[0m"

pipeline {
    agent any
    options {
        ansiColor('xterm')
        timestamps()
        timeout(time: 10, unit: 'MINUTES')
    }
    parameters {
        string(
            name: 'repository',
            defaultValue: 'lifailon/lazyjournal',
            description: 'The address of the GitHub repository from which to download the binary.\nFormat: <USERNAME/REPOSITORY> or the binary name for uninstall'
        )
        reactiveChoice(
            name: 'tags',
            description: 'Select version (tag) on GitHub.',
            choiceType: 'PT_SINGLE_SELECT',
            filterable: true,
            filterLength: 1,
            script: [
                $class: 'GroovyScript',
                script: [
                    sandbox: true,
                    script: '''
                        import groovy.json.JsonSlurper
                        def selectedRepo = repository
                        def apiUrl = "https://api.github.com/repos/${selectedRepo}/tags"
                        def conn = new URL(apiUrl).openConnection()
                        conn.setRequestProperty("User-Agent", "Jenkins")
                        def response = conn.getInputStream().getText()
                        def json = new JsonSlurper().parseText(response)
                        def versionsCount = json.size()
                        def data = []
                        for (int i = 0; i < versionsCount; i++) {
                            data += json.name[i]
                        }
                        return data
                    '''
                ]
            ],
            referencedParameters: 'repository'
        )
        booleanParam(
            name: "uninstall",
            defaultValue: false,
            description: 'Delete binary on remote hosts.'
        )
        string(
            name: 'binPath',
            defaultValue: './.local/bin',
            description: 'Path to install on remote host (by default "./.local/bin").'
        )
        text(
            name: 'addresses',
            defaultValue: '192.168.3.101\n192.168.3.105\n192.168.3.106',
            description: 'List of remote host addresses for install.'
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
    }
    environment {
        GITHUB_USERNAME="zyedidia"
        GITHUB_REPOSITORY="eget"
        SSH_KEY_FILE = "/tmp/ssh_key_${UUID.randomUUID().toString()}"
    }
    stages {
        stage('Get ssh credentials') {
            steps {
                script {
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
        stage('Delete binary on remote hosts') {
            when {
                expression { params.uninstall }
            }
            steps {
                script {
                    // Извлекаем название исполняемого файла
                    binName = params.repository.split('/')[1] ? params.repository.split('/')[1] : params.repository
                    // Определяем режим работы в название сборки
                    currentBuild.displayName = "#${BUILD_NUMBER} ${binName}: uninstall"
                    // Проверяем путь из параметра или присваиваем значение по умолчанию
                    binPath = params.binPath ? params.binPath : "./.local/bin"
                    // Формируем полный путь до исполняемого файла
                    binFullPath = binPath.replaceAll("/\$", "") + "/" + binName
                    // Получаем массив из списка хостов
                    def addressList = params.addresses.split('\n').collect{it.trim()}.findAll{it}
                    // Проходимся по хостам
                    for (int i = 0; i < addressList.size(); i++) {
                        // Извлекаем и заполняем имя хоста для подключения
                        def address = addressList[i]
                        remote.name = address
                        remote.host = address
                        catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE') {
                            // Удаляем файл
                            sshCommand remote: remote, command: "rm -f ${binFullPath}"
                        }
                    }
                }
            }
        }
        stage('Install eget') {
            when {
                expression { ! params.uninstall }
            }
            steps {
                script {
                    // Определяем режим работы в название сборки
                    def buildName = params.repository.split("/")[1]
                    currentBuild.displayName = "#${BUILD_NUMBER} ${buildName}: ${params.tags}"
                    // Определяем архитектуру на сборщике
                    archAgent = sh(
                        script: getArch,
                        returnStdout: true
                    ).trim()
                    // Унифицированный способ для загрузки исполняемого файла из репозитория GitHub
                    sh """
                        GITHUB_REPO_URL=https://github.com/${env.GITHUB_USERNAME}/${env.GITHUB_REPOSITORY}/releases
                        GITHUB_LATEST_VERSION=\$(curl -L -sS -H 'Accept: application/json' \$GITHUB_REPO_URL/latest | sed -e 's/.*"tag_name":"\\([^"]*\\)".*/\\1/')
                        DOWNLOAD_BIN_URL="\$GITHUB_REPO_URL/download/\$GITHUB_LATEST_VERSION/${env.GITHUB_REPOSITORY}-\$(echo \$GITHUB_LATEST_VERSION | sed 's/v//')-linux_${archAgent}.tar.gz"
                        ls -lh
                        curl -sSL "\$DOWNLOAD_BIN_URL" -o ${env.GITHUB_REPOSITORY}.tar.gz
                        ls -lh
                        tar -xzf ${env.GITHUB_REPOSITORY}.tar.gz
                        ls -lh ${env.GITHUB_REPOSITORY}-*
                        cp ${env.GITHUB_REPOSITORY}-*/${env.GITHUB_REPOSITORY} ${env.GITHUB_REPOSITORY}
                        ls -lh
                        rm -rf eget-* eget.*
                        ls -lh
                        chmod +x ${env.GITHUB_REPOSITORY}
                        ./${env.GITHUB_REPOSITORY} -v
                    """
                }
            }
        }
        stage('Download binary from GitHub repository') {
            when {
                expression { ! params.uninstall }
            }
            steps {
                script {
                    binName = params.repository.split('/')[1]
                    // Загружаем исполняемый файл для двух архитектур
                    sh """
                        ./${env.GITHUB_REPOSITORY} ${params.repository} --tag ${params.tags} --system linux/amd64 --to ${binName}-amd64
                        ./${env.GITHUB_REPOSITORY} ${params.repository} --tag ${params.tags} --system linux/arm64 --to ${binName}-arm64
                        ls -lhR;
                        chmod +x ./${binName}-${archAgent}
                    """
                    // Проверяем версию
                    def version = sh(
                        script: "./${binName}-${archAgent} -v || ./${binName}-${archAgent} --version || ./${binName}-${archAgent} version",
                        returnStdout: true
                    ).trim()
                    echo "Version on Jenkins Agent: "+colorGreen+version+colorReset
                }
            }
        }
        stage('Transfer binary on remote hosts') {
            when {
                expression { ! params.uninstall }
            }
            steps {
                script {
                    binPath = params.binPath ? params.binPath : "./.local/bin"
                    binFullPath = binPath.replaceAll("/\$", "") + "/" + binName
                    // Игнорируем ошибки
                    catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE') {
                        def addressList = params.addresses.split('\n').collect{it.trim()}.findAll{it}
                        for (int i = 0; i < addressList.size(); i++) {
                            def address = addressList[i]
                            remote.name = address
                            remote.host = address
                            // Определяем архитектуру на удаленном хосте
                            def archRemoteHost = sshCommand remote: remote, command: getArch
                            // Создаем целевую директорию для установки (если отсутствует)
                            sshCommand remote: remote, command: "mkdir -p ${binPath}"
                            // Копируем файл на удаленный хост
                            sshPut remote: remote, from: "${binName}-${archRemoteHost}", into: binFullPath
                            // Выдаем права на выполнение и проверяем версию
                            def version = sshCommand remote: remote, command: """
                                chmod +x ${binFullPath} > /dev/null;
                                ${binFullPath} -v || ${binFullPath} --version || ${binFullPath} version
                            """
                            echo "Version on ${address}: "+colorGreen+version+colorReset
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
                    ls -lh 
                    rm -f "${env.SSH_KEY_FILE} ${env.GITHUB_REPOSITORY} ${binName}-*"
                    ls -lh
                """
            }
        }
    }
}