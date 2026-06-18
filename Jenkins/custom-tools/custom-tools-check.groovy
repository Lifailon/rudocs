pipeline {
    agent any
    parameters {
        booleanParam(
            name: "nodejs",
            defaultValue: false
        )
        booleanParam(
            name: "docker-cli",
            defaultValue: false
        )
        booleanParam(
            name: "docker-compose",
            defaultValue: false
        )
        booleanParam(
            name: "docker-buildx",
            defaultValue: false
        )
        booleanParam(
            name: "kubectl",
            defaultValue: false
        )
        booleanParam(
            name: "helm",
            defaultValue: false
        )
    }
    stages {
        stage("Check tools") {
            steps {
                script {
                    def binPaths = []

                    if (params.nodejs) {
                        def toolPath = tool(
                            name: 'node-js-24.17.0',
                            type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
                        )
                        binPaths.add(toolPath)
                    }
                    if (params['docker-cli']) {
                        def toolPath = tool(
                            name: 'docker-cli-29.5.0',
                            type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
                        )
                        binPaths.add(toolPath)
                    }
                    if (params['docker-compose']) {
                        def toolPath = tool(
                            name: 'docker-compose-5.1.0',
                            type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
                        )
                        binPaths.add(toolPath)
                    }
                    if (params['docker-buildx']) {
                        def toolPath = tool(
                            name: 'docker-buildx-0.34.1',
                            type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
                        )
                        binPaths.add(toolPath)
                    }
                    if (params.kubectl) {
                        def toolPath = tool(
                            name: 'kubectl-1.36.0',
                            type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
                        )
                        binPaths.add(toolPath)
                    }
                    if (params.helm) {
                        def toolPath = tool(
                            name: 'helm-4.2.0',
                            type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
                        )
                        binPaths.add(toolPath)
                    }

                    binPaths.add(env.PATH)
                    env.PATH = binPaths.join(':')

                    if (params.nodejs) {
                        sh "node -v"
                        sh "npm -v"
                        sh "npx -v"
                    } else {
                        echo "nodejs skipped"
                    }
                    if (params['docker-cli']) {
                        sh "docker version || true"
                    } else {
                        echo "docker-cli skipped"
                    }
                    if (params['docker-compose']) {
                        sh "docker-compose version || true"
                        sh "docker compose version || true"
                    } else {
                        echo "docker-compose skipped"
                    }
                    if (params['docker-buildx']) {
                        sh "docker buildx version || true"
                        sh "docker buildx ls || true"
                    } else {
                        echo "docker-buildx skipped"
                    }
                    if (params.kubectl) {
                        sh "kubectl version --client --output=json || true"
                    } else {
                        echo "kubectl skipped"
                    }
                    if (params.helm) {
                        sh "helm version || true"
                    } else {
                        echo "helm skipped"
                    }
                }
            }
        }
    }
}
