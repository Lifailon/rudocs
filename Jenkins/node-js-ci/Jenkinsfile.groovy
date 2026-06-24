pipeline {
    agent any
    options {
        ansiColor('xterm')
        timestamps()
        timeout(time: 60, unit: 'MINUTES')
    }
    parameters {
        string(
            name: "repoUrl",
            defaultValue: ""
        )
        string(
            name: "branch",
            defaultValue: ""
        )
        string(
            name: "port",
            defaultValue: "3000"
        )
        booleanParam(
            name: "clean-install",
            defaultValue: true,
        )
        booleanParam(
            name: "lint",
            defaultValue: false
        )
        booleanParam(
            name: "test",
            defaultValue: false
        )
        booleanParam(
            name: "build",
            defaultValue: false,
        )
        booleanParam(
            name: "run",
            defaultValue: false,
        )
        booleanParam(
            name: "build-docker-image",
            defaultValue: true
        )
        booleanParam(
            name: "publish-docker-image",
            defaultValue: false
        )
        booleanParam(
            name: "run-docker-container",
            defaultValue: false
        )
    }
    stages {
        stage("Install and check tools") {
            steps {
                script {
                    def binPaths = []
                    def nodePath = tool(
                        name: 'node-js-24.17.0',
                        type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
                    )
                    binPaths.add(nodePath)
                    def dockerPath = tool(
                        name: 'docker-cli-29.5.0',
                        type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
                    )
                    binPaths.add(dockerPath)
                    binPaths.add(env.PATH)
                    env.PATH = binPaths.join(':')
                    sh "node -v"
                    sh "npm -v"
                    sh "npx -v"
                    sh "docker version || true"
                }
            }
        }
        stage('Git checkout') {
            steps {
                script {
                    def branch = params.branch ? params.branch : "main"
                    checkout scmGit(
                        branches: [[name: branch]],
                        userRemoteConfigs: [[url: params.repoUrl]],
                        extensions: [[
                            $class: 'RelativeTargetDirectory',
                            relativeTargetDir: 'src'
                        ]]
                    )
                    sh "ls -lh"
                }
            }
        }
        stage('Install dependencies') {
            steps {
                script {
                    dir('src') {
                        if (params['clean-install']) {
                            sh "npm clean-install"
                        } else {
                            sh "npm install"
                        }
                    }
                }
            }
        }
        stage('ESLint check') {
            when {
                expression { params.lint }
            }
            steps {
                script {
                    dir('src') {
                        sh "npm run lint"
                    }
                }
            }
        }
        stage('Unit tests') {
            when {
                expression { params.test }
            }
            steps {
                script {
                    dir('src') {
                        sh "npm run test:run"
                    }
                }
            }
        }
        stage('Local build') {
            when {
                expression { params.build }
            }
            steps {
                script {
                    dir('src') {
                        sh "npm run build"
                    }
                }
            }
        }
        stage('Local run') {
            when {
                expression { params.run }
            }
            steps {
                script {
                    dir('src') {
                        try {
                            sh "npm run dev"
                        } finally {
                            sh "npx kill-port ${params.port} || true"
                        }
                    }
                }
            }
        }
        stage('Copy files for docker build') {
            steps {
                script {
                    dir('src') {
                        timeout(
                            time: 30,
                            unit: 'SECONDS'
                        ) {
                            sh "HTTPS_PROXY=http://192.168.3.110:2080 curl -sSL https://raw.githubusercontent.com/Lifailon/rudocs/refs/heads/main/Jenkins/node-js-ci/nginx/Dockerfile -o Dockerfile"
                            sh "HTTPS_PROXY=http://192.168.3.110:2080 curl -sSL https://raw.githubusercontent.com/Lifailon/rudocs/refs/heads/main/Jenkins/node-js-ci/nginx/nginx.conf -o nginx.conf"
                        }
                        // sh "cp Jenkins/node-js-ci/nginx/Dockerfile Jenkins/node-js-ci/nginx/nginx.conf src/"
                    }
                }
            }
        }
        stage('Docker image build') {
            when {
                expression { params['build-docker-image'] || params['publish-docker-image'] || params['run-docker-container'] }
            }
            steps {
                script {
                    dir('src') {
                        def imageName = params.repoUrl.tokenize('/').last().replace('.git', '')
                        def imageTag = params.branch
                        env.imageFullName = "${imageName}:${imageTag}"
                        sh "HTTPS_PROXY=http://192.168.3.110:2080 docker build --load -t ${env.imageFullName} ."
                    }
                }
            }
        }
        stage('Login to Docker Hub') {
            when {
                expression { params['publish-docker-image'] }
            }
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: params.credentials, 
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )]) {
                    script {
                        sh "echo \"\$DOCKER_PASSWORD\" | docker login -u \"\$DOCKER_USERNAME\" --password-stdin"
                    }
                }
            }
        }
        stage('Publish to Docker Hub') {
            when {
                expression { params['publish-docker-image'] }
            }
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: params.credentials, 
                        usernameVariable: 'DOCKER_USERNAME'
                    )]) {
                    script {
                        sh "docker tag ${env.imageFullName} ${DOCKER_USERNAME}/${env.imageFullName}"
                        sh "docker push ${DOCKER_USERNAME}/${env.imageFullName}"
                    }
                }
            }
        }
        stage('Docker container run') {
            when {
                expression { params['run-docker-container'] }
            }
            steps {
                script {
                    env.containerName = "jenkins-build-${env.BUILD_NUMBER}"
                    try {
                        sh "docker run -d -p ${params.port}:${params.port} --name ${env.containerName} ${env.imageFullName}"
                        sleep(time: 5, unit: "SECONDS")
                        sh "curl --fail http://localhost:${params.port}"
                        sh "docker logs ${env.containerName} -f"
                    } finally {
                        sh "docker stop ${env.containerName} || true"
                        sh "docker rm ${env.containerName} || true"
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}