def remote = [:]

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
        timeout(time: 60, unit: 'MINUTES')
    }
    environment {
        SSH_KEY_FILE = "/tmp/ssh_key_${UUID.randomUUID().toString()}"
        DOCKER_CLI_HOME = tool(
            name: "docker-cli-29.5.0",
            type: "com.cloudbees.jenkins.plugins.customtools.CustomTool"
        )
        BUILDX_HOME = tool(
            name: "docker-buildx-0.34.1",
            type: "com.cloudbees.jenkins.plugins.customtools.CustomTool"
        )
        PATH = "${env.DOCKER_CLI_HOME}:${env.BUILDX_HOME}:${env.PATH}"
    }
    parameters {
        string(
            name: 'repoUrl',
            defaultValue: 'https://github.com/Lifailon/rudocs',
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
        string(
            name: 'shaCommit',
            defaultValue: '',
            description: 'Switch to the specified commit.'
        )
        string(
            name: 'pathDockerfile',
            defaultValue: 'Docker-Compose/ci-cd-stack/jenkins/Dockerfile',
            description: 'Path to the Dockerfile in the repository.'
        )
        string(
            name: 'imageName',
            defaultValue: 'lifailon/jenkins-agent:latest',
            description: 'Image name and tag.'
        )
        booleanParam(
            name: "lint",
            defaultValue: false,
            description: 'Checking built-in linters.'
        )
        booleanParam(
            name: "hadolint",
            defaultValue: false,
            description: 'Checking hadolint.'
        )
        booleanParam(
            name: "buildx",
            defaultValue: false,
            description: 'Build multi-platform image for amd64 and arm64.'
        )
        booleanParam(
            name: "recreateBuilder",
            defaultValue: false,
            description: 'Create builder for first run or recreate for clear cache.'
        )
        string(
            name: 'platforms',
            defaultValue: 'linux/amd64,linux/arm64',
            description: 'List platforms for build.'
        )
        booleanParam(
            name: "publish",
            defaultValue: false,
            description: 'Publishing an image to Docker Hub.'
        )
        credentials(
            name: 'credentials',
            description: 'Username with password from Jenkins Credentials for login to Docker Hub.',
            credentialType: 'com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl',
            defaultValue: ''
        )
    }
    stages {
        stage('Git checkout') {
            steps {
                script {
                    log.stage()
                    def branch = params.branch ? params.branch : "main"
                    checkout scmGit(
                        branches: [[name: branch]],
                        userRemoteConfigs: [[url: params.repoUrl]]
                    )
                    echo "Check Dockerfile:"
                    sh(script: "ls ${params.pathDockerfile}")
                    def buildMode = "[build only]"
                    if (params.publish) {
                        buildMode = "[build and publish]"
                    } else {
                    }
                    def url = params.repoUrl ?: ''
                    def repoName = url.contains('/') ? url.substring(url.lastIndexOf('/') + 1) : url
                    currentBuild.displayName = "#${BUILD_NUMBER} ${repoName} ${buildMode}"
                }
            }
        }
        stage('Git switch to the specified commit') {
            when {
                expression { params.shaCommit != '' }
            }
            steps {
                script {
                    log.stage()
                    sh(script: "git checkout ${ params.shaCommit }")
                }
            }
        }
        stage('Dockerfile basic linters check') {
            when {
                expression { params.lint }
            }
            steps {
                script {
                    log.stage()
                    sh(script: "docker build --check -f ${ params.pathDockerfile } .")
                }
            }
        }
        stage('Dockerfile hadolint check') {
            when {
                expression { params.hadolint }
            }
            steps {
                script {
                    log.stage()
                    sh(script: "docker run --rm -i hadolint/hadolint:latest < ${ params.pathDockerfile }")
                }
            }
        }
        stage('Build image') {
            steps {
                script {
                    log.stage()
                    sh(script: "DOCKER_BUILDKIT=0 docker build -t ${params.imageName} -f ${ params.pathDockerfile } .")
                }
            }
        }
        stage('Login to Docker Hub') {
            when {
                expression { params.publish }
            }
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: params.credentials, 
                        usernameVariable: 'DOCKER_USERNAME', 
                        passwordVariable: 'DOCKER_PASSWORD')
                ]) {
                    script {
                        log.stage()
                        sh "echo \"\$DOCKER_PASSWORD\" | docker login -u \"\$DOCKER_USERNAME\" --password-stdin"
                    }
                }
            }
        }
        stage('Recreate builder') {
            when {
                expression { params.buildx && params.recreateBuilder }
            }
            steps {
                script {
                    log.stage()
                    sh(script: """
                        docker buildx rm jenkins-builder || true
                        docker buildx create --name jenkins-builder --driver docker-container --use --bootstrap
                    """)
                }
            }
        }
        stage('Build and publish to Docker Hub') {
            when {
                expression { params.publish }
            }
            steps {
                script {
                    log.stage()
                    if (params.buildx) {
                        sh(script: "docker buildx build --builder jenkins-builder --platform ${params.platforms} -t ${params.imageName} --push -f ${ params.pathDockerfile } .")
                    } else {
                        sh(script: "docker push ${params.imageName}")
                    }
                }
            }
        }
    }
}