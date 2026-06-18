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
    agent {
        label 'linux && (amd64 || arm64)'
    }
    options {
        ansiColor("xterm")
        timestamps()
        timeout(time: 10, unit: "MINUTES")
    }
    environment {
        KUBECONFIG = "${WORKSPACE}/kubeconfig.yaml"
        KUBECTLPATH = tool(
            name: 'kubectl-1.36.0',
            type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
        )
        PATH = "${KUBECTLPATH}:${env.PATH}"
    }
    parameters {
        string(
            name: "repository",
            defaultValue: "Lifailon/rudocs"
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

def url = "https://api.github.com/repos/${repository}/branches"
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
            referencedParameters: 'repository'
        )
        reactiveChoice(
            name: 'project',
            choiceType: 'PT_SINGLE_SELECT',
            filterable: false,
            filterLength: 1,
            script: [
                $class: 'GroovyScript',
                script: [
                    sandbox: true,
                    script: '''
import groovy.json.JsonSlurper
def url = "https://api.github.com/repos/${repository}/git/trees/main?recursive=1"
try {
    def URL = new URL(url)
    def connection = URL.openConnection()
    connection.requestMethod = 'GET'
    if (connection.responseCode == 200) {
        def response = connection.inputStream.text
        def json = new JsonSlurper().parseText(response)
        def dirs = json.tree.findAll { it ->
            it.type == 'blob' && it.path.endsWith("/kustomization.yaml")
        }.collect { it ->
            def lastSlash = it.path.lastIndexOf("/")
            return it.path.substring(0, lastSlash)
        }
        return dirs.isEmpty() ? ["No kustomization directories found"] : dirs
    } else {
        return ["Error: GitHub API returned status ${connection.responseCode}"]
    }
} catch (Exception e) {
    return ["Error: ${e.message}"]
}
                    '''
                ]
            ],
            referencedParameters: 'repository'
        )
        separator(
            name: "deploymentMode",
            sectionHeader: "Deployment mode",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        reactiveChoice(
            name: "mode",
            choiceType: "PT_RADIO",
            filterable: false,
            referencedParameters: "context",
            script: [
                $class: "GroovyScript",
                script: [
                    sandbox: true,
                    script: '''
                        return [
                            "Apply",
                            "Replace",
                            "Uninstall"
                        ]
                    '''
                ]
            ]
        )
        separator(
            name: "kubectlOptions",
            sectionHeader: "Kubectl options",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        booleanParam(
            name: "addLabels",
            defaultValue: true,
            description: "Add labels using the commonLabels annotation to use the prune option"
        )
        booleanParam(
            name: "dryRunClient",
            defaultValue: false,
            description: "Output the final manifest and check the rendering on the client (yaml syntax)"
        )
        booleanParam(
            name: "dryRunServer",
            defaultValue: false,
            description: "Check deployment on server without applying changes to the cluster"
        )
        booleanParam(
            name: "force",
            defaultValue: false,
            description: "Resolves conflicts by force"
        )
        booleanParam(
            name: "wait",
            defaultValue: false,
            description: "Waits for all pods in the Deployment to be ready"
        )
        booleanParam(
            name: "prune",
            defaultValue: false,
            description: "Removes resources from the cluster that are not in the repository (available when using the addLabels parameter during deployment)"
        )
        separator(
            name: "kubeconfigOptions",
            sectionHeader: "Kubeconfig file from Jenkins Credentials or Parameter",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        credentials(
            name: 'kubeconfigFile',
            credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl',
            defaultValue: 'kubeconfig-file'
        )
        base64File 'UPLOAD_KUBECONFIG_FILE'
    }
    stages {
        stage('Git checkout') {
            steps {
                script {
                    log.stage()
                    def branch = params.branch ? params.branch : "main"
                    checkout scmGit(
                        branches: [[name: branch]],
                        userRemoteConfigs: [[url: "https://github.com/${params.repository}"]]
                    )
                    currentBuild.displayName = "#${BUILD_NUMBER} ${params.mode} ${params.project}"
                    sh "ls -lh ${params.project}"
                }
            }
        }
        stage("Check tools") {
            steps {
                script {
                    log.stage()
                    def results = sh(
                        script: "kubectl version --output=json || true",
                        returnStatus: false,
                        returnStdout: true
                    )
                    log.info(results)
                }
            }
        }
        stage("Dry-run client") {
            when {
                expression { params.dryRunClient }
            }
            steps {
                script {
                    log.stage()
                    try {
                        def template = sh(
                            script: "kubectl kustomize ${params.project}",
                            returnStatus: false,
                            returnStdout: true
                        )
                        log.info(template)
                        def render = sh(
                            script: "kubectl kustomize Kubernetes/${params.project} | kubectl replace --dry-run=client --insecure-skip-tls-verify --validate=false -f -",
                            returnStatus: false,
                            returnStdout: true
                        ).trim()
                        log.success(render)
                    } catch (Exception e) {
                        log.error(e.message)
                    }
                }
            }
        }
        stage("Get kubeconfig file from Jenkins Credentials or Parameter") {
            when {
                expression { ! params.dryRunClient }
            }
            steps {
                script {
                    log.stage()
                    def kubeconfigReady = false
                    withFileParameter(
                        name: "UPLOAD_KUBECONFIG_FILE",
                        allowNoFile: true
                    ) {
                        def KUBECONFIG = readFile(
                            file: UPLOAD_KUBECONFIG_FILE
                        )
                        if (KUBECONFIG.trim().length() > 0) {
                            log.info("Get kubeconfig from File Parameter")
                            writeFile(
                                file: "${WORKSPACE}/kubeconfig.yaml",
                                text: KUBECONFIG
                            )
                            kubeconfigReady = true
                        }
                    }
                    if (!kubeconfigReady) {
                        log.info("Get kubeconfig from Jenkins File Credentials")
                        withCredentials([
                            file(
                                credentialsId: params.kubeconfigFile,
                                variable: "KUBECONFIG_PATH"
                            )
                        ]) {
                            def KUBECONFIG = readFile(
                                file: KUBECONFIG_PATH
                            )
                            writeFile(
                                file: "${WORKSPACE}/kubeconfig.yaml",
                                text: KUBECONFIG
                            )
                        }
                    }
                }
            }
        }
        stage("Check kubernetes cluster info") {
            when {
                expression { ! params.dryRunClient }
            }
            steps {
                script {
                    log.stage()
                    def results = sh(
                        script: "kubectl cluster-info --insecure-skip-tls-verify",
                        returnStatus: false,
                        returnStdout: true
                    )
                    log.info(results)
                }
            }
        }
        stage("Deploy to kubernetes cluster") {
            when {
                expression { ! params.dryRunClient }
            }
            steps {
                script {
                    log.stage()
                    dir(params.project) {
                        def projectName = params.project.replaceAll("/", "_").trim()
                        if (params.addLabels) {
                            sh """
                                echo "" >> kustomization.yaml
                                echo "commonLabels:" >> kustomization.yaml
                                echo "  app.kubernetes.io/project: ${projectName}" >> kustomization.yaml
                                echo "  app.kubernetes.io/managed-by: jenkins" >> kustomization.yaml
                            """
                        }
                        def kubectlOptions = "--insecure-skip-tls-verify"
                        if (params.dryRunServer) {
                            kubectlOptions += " --dry-run=server"
                        }
                        if (params.force) {
                            kubectlOptions += " --force"
                        }
                        if (params.wait) {
                            kubectlOptions += " --wait"
                        }
                        if (params.prune && params.addLabels) {
                            kubectlOptions += " --prune -l app.kubernetes.io/project=${projectName}"
                        }
                        if (params.mode == "Apply") {
                            sh "kubectl kustomize . | kubectl apply ${kubectlOptions} -f -"
                        } else if (params.mode == "Replace") {
                            sh "kubectl kustomize . | kubectl replace ${kubectlOptions} -f -"
                        } else {
                            sh "kubectl kustomize . | kubectl delete ${kubectlOptions} -f -"
                        }
                    }
                }
            }
        }
    }
}