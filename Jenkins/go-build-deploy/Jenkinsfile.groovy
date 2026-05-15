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

def appVersion = ""
def getVersion = "go run ./... -v 2>/dev/null || go run ./... --version"

def archList = ["amd64","arm64"]
def osList = ["linux","darwin","openbsd","freebsd","windows"]

def colorGreen = "\033[32m"
def colorReset = "\033[0m"

def parseVersion(text) {
    def matcher = (text =~ /(\d+\.\d+(?:\.\d+)?)/)
    return matcher.find() ? matcher.group(1) : "unknown"
}

pipeline {
    agent {
        label 'linux' // Jenkins Agent with Go installed
    }
    options {
        ansiColor('xterm')
        timestamps()
        timeout(time: 10, unit: 'MINUTES')
    }
    parameters {
        string(
            name: 'repoUrl',
            defaultValue: 'https://github.com/Lifailon/lazyjournal',
            description: 'Url address for copying repository using Git.'
        )
        reactiveChoice(
            name: 'branch',
            description: 'Select branch.',
            choiceType: 'PT_RADIO',
            filterable: false,
            script: [
                $class: 'GroovyScript',
                script: [
                    sandbox: true,
                    script: '''
                        import groovy.json.JsonSlurper

                        def repo = repoUrl.replaceAll("https://github.com/","https://api.github.com/repos/")
                        def url = "${repo}/branches"
                        def URL = new URL(url)
                        def connection = URL.openConnection()
                        connection.requestMethod = 'GET'
                        connection.setRequestProperty("Accept", "application/vnd.github.v3+json")
                        def response = connection.inputStream.text

                        def json = new JsonSlurper().parseText(response)
                        def branches = json.collect { it.name }
                        return branches as List
                    '''
                ]
            ],
            referencedParameters: 'repoUrl'
        )
        booleanParam(
            name: "update",
            defaultValue: false,
            description: 'Update dependencies.'
        )
        choice(
            name: 'testMode',
            choices: ['skip', 'selected','all'],
            description: 'Select test mode.'
        )
        string(
            name: 'testName',
            defaultValue: '',
            description: 'Enter the test name separated by commas.'
        )
        booleanParam(
            name: "lint",
            defaultValue: false,
            description: 'Install and run all linter check (golangci, gocritic and gosec).'
        )
        booleanParam(
            name: "tmux",
            defaultValue: false,
            description: 'Check application launch in TMUX.'
        )
        booleanParam(
            name: "build",
            defaultValue: false,
            description: 'Build binary for all platforms.'
        )
        booleanParam(
            name: "upload",
            defaultValue: false,
            description: 'Upload all binary to Artifacts.'
        )
        booleanParam(
            name: "deploy",
            defaultValue: false,
            description: 'Upload binary to remote hosts.'
        )
        text(
            name: 'addresses',
            defaultValue: '192.168.3.105\n192.168.3.106',
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
        string(
            name: 'binPath',
            defaultValue: './.local/bin',
            description: 'Path to install binary on remote hosts. (by default "./.local/bin").'
        )
    }
    environment {
        SSH_KEY_FILE = "/tmp/ssh_key_${UUID.randomUUID().toString()}"
    }
    stages {
        stage('Git checkout') {
            steps {
                script {
                    def branch = params.branch ? params.branch : "main"
                    checkout scmGit(
                        branches: [[name: branch]],
                        userRemoteConfigs: [[url: params.repoUrl]]
                    )
                    sh(script: "ls -lh")
                }
            }
        }
        stage('Preparing application') {
            steps {
                script {
                    def urlSplit = params.repoUrl.split("/")
                    binName = urlSplit[urlSplit.size() - 1]
                    currentBuild.displayName = "#${BUILD_NUMBER} ${binName} (${params.branch})"
                    echo "App name: ${colorGreen}${binName}${colorReset}"
                    sh(script: """
                        go fmt ./...
                        go vet ./...
                        go get ./...
                        go mod tidy
                        go mod verify
                        go build -o /dev/null -v ./...
                    """)
                    def currentVersion = sh(
                        script: getVersion,
                        returnStdout: true
                    ).trim()
                    echo "App raw version: ${colorGreen}${currentVersion}${colorReset}"
                    appVersion = parseVersion(currentVersion)
                    echo "App version for binary name: ${colorGreen}${appVersion}${colorReset}"
                    def getHelp = sh(
                        script: "go run ./... -h 2>/dev/null || go run ./... --help",
                        returnStdout: true
                    ).trim()
                    echo "App help:\n${getHelp}"
                }
            }
        }
        stage('Update dependencies') {
            when {
                expression { params.update }
            }
            steps {
                script {
                    def checkCurrentVersion = sh(
                        script: """
                            go get -u ./...
                            ${getVersion}
                        """,
                        returnStdout: true
                    )
                    echo "Check raw version: ${colorGreen}${checkCurrentVersion}${colorReset}"
                }
            }
        }
        stage('Get test list and run selected test') {
            steps {
                script {
                    def testList = sh(
                        script: "go test -list . ./...",
                        returnStdout: true
                    )
                    echo colorGreen+"Test list:\n\n"+testList+colorReset
                    if (params.testMode == "all") {
                        echo "Run ${colorGreen}all${colorReset} tests"
                        // sh(script: "go test -v -cover ./...")
                    } else if (params.testMode == "selected" && params.testName.trim().size() > 0) {
                        def testName = params.testName.trim().replaceAll(/\s*,\s*/, ",")
                        echo "Run selected tests: ${colorGreen}${testName}${colorReset}"
                        // sh(script: "go test -v -cover --run ${testName} ./...")
                    } else {
                        echo "Testing skipped"
                    }
                }
            }
        }
        stage('Linter check') {
            when {
                expression { params.lint }
            }
            steps {
                script {
                    def linterInstallJobs = [:]
                    linterInstallJobs["golangci"] = {
                        sh(
                            script: "go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest"
                        )
                    }
                    linterInstallJobs["gocritic"] = {
                        sh(
                            script: "go install github.com/go-critic/go-critic/cmd/gocritic@latest"
                        )
                    }
                    linterInstallJobs["gosec"] = {
                        sh(
                            script: "go install github.com/securego/gosec/v2/cmd/gosec@latest"
                        )
                    }
                    parallel linterInstallJobs
                    def linterCheckJobs = [:]
                    linterCheckJobs["golangci"] = {
                        sh(
                            script: "$HOME/go/bin/golangci-lint run ./main.go"
                        )
                    }
                    linterCheckJobs["gocritic"] = {
                        sh(
                            script: "$HOME/go/bin/gocritic check -enableAll ./main.go"
                        )
                    }
                    linterCheckJobs["gosec"] = {
                        sh(
                            script: "$HOME/go/bin/gosec -severity=high ./..."
                        )
                    }
                    parallel linterCheckJobs
                }
            }
        }
        stage('Check application launch in TMUX') {
            when {
                expression { params.tmux }
            }
            steps {
                script {
                    sh(script: """
                            tmux new-session -d -s test-session "go run ./..."
                            sleep 1
                            tmux capture-pane -p
                            tmux kill-session -t test-session
                        """
                    )
                }
            }
        }
        stage('Build binary for all platforms') {
            when {
                expression { params.build }
            }
            steps {
                script {
                    sh(script: "rm -rf bin && mkdir -p bin")
                    def parallelBuildJobs = [:]
                    for (arch in archList) {
                        for (os in osList) {
                            def currentArch = arch
                            def currentOS = os
                            def ext = ""
                            if (os == "windows") {
                                ext = ".exe" 
                            }
                            def buildFileName = "${binName}-${appVersion}-${currentOS}-${currentArch}${ext}"
                            parallelBuildJobs[buildFileName] = {
	                    	    echo "Build file: ${colorGreen}${buildFileName}${colorReset}"
                                sh(
                                    script: "CGO_ENABLED=0 GOOS=${currentOS} GOARCH=${currentArch} go build -o bin/${buildFileName}"
                                )
                            }
                        }
                    }
                    parallel parallelBuildJobs
                    sh(script: "ls -lh bin")
                    archAgent = sh(
                        script: getArch,
                        returnStdout: true
                    ).trim()
                    def binNameAgent = "${binName}-${appVersion}-linux-${archAgent}"
                    def binVersion = sh(
                        script: """
                            chmod +x ./bin/${binNameAgent}
                            ./bin/${binNameAgent} -v 2>/dev/null || ./bin/${binNameAgent} --version
                        """,
                        returnStdout: true
                    ).trim()
                    echo "Binary raw version on Agent: ${colorGreen}${binVersion}${colorReset}"
                }
            }
        }
        stage('Upload all binary to Artifacts') {
            when {
                expression { params.upload }
            }
            steps {
                script {
                    archiveArtifacts artifacts: "bin/**/*", allowEmptyArchive: true
                }
            }
        }
        stage('Get ssh credentials') {
            when {
                expression { params.build && params.deploy }
            }
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
        stage('Deploy binary on remote hosts') {
            when {
                expression { params.build && params.deploy }
            }
            steps {
                script {
                    binPath = params.binPath ? params.binPath : "./.local/bin"
                    binFullPath = binPath.replaceAll("/\$", "") + "/" + binName
                    catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE') {
                        def addressList = params.addresses.split('\n').collect{it.trim()}.findAll{it}
                        for (int i = 0; i < addressList.size(); i++) {
                            def address = addressList[i]
                            remote.name = address
                            remote.host = address
                            def archRemoteHost = sshCommand remote: remote, command: getArch
                            sshCommand remote: remote, command: "mkdir -p ${binPath}"
                            sshPut remote: remote, from: "./bin/${binName}-${appVersion}-linux-${archRemoteHost}", into: binFullPath
                            def version = sshCommand remote: remote, command: """
                                chmod +x ${binFullPath} > /dev/null;
                                ${binFullPath} -v 2> /dev/null || ${binFullPath} --version
                            """
                            echo "Deploy on ${colorGreen}${address}${colorReset} in ${colorGreen}${binFullPath}${colorReset}"
                            echo "Binary raw version on ${address}: ${colorGreen}${version}${colorReset}"
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
                    rm -rf "./* ${env.SSH_KEY_FILE}"
                    ls -lh
                """
            }
        }
    }
}