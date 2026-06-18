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

def K8S_TOKEN = ""

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
        // KUBECONFIG = "${WORKSPACE}/kubeconfig.yaml"
        KUBECTLPATH = tool(
            name: 'kubectl-1.36.0',
            type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
        )
        PATH = "${KUBECTLPATH}:${env.PATH}"
    }
    parameters {
        separator(
            name: "separatorCredentials",
            sectionHeader: "Credentials",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        credentials(
            name: 'tokenCred',
            credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.StringCredentialsImpl',
            defaultValue: 'k3s-token',
            description: 'Token for access to Kubernetes API'
        )
        separator(
            name: "separatorVault",
            sectionHeader: "Vault",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        booleanParam(
            name: "vault",
            defaultValue: false,
            description: 'Use Vault to get a token'
        )
        string(
            name: "vaultUrl",
            defaultValue: "http://192.168.3.101:8200"
        )
        string(
            name: "vaultPath",
            defaultValue: "jenkins/k3s",
            description: "Path to secrets in Vault (where the token or config key with kubeconfig contents is stored)"
        )
        credentials(
            name: "vaultAppRole",
            credentialType: "com.datapipe.jenkins.vault.credentials.VaultAppRoleCredential",
            defaultValue: "k3s-approle",
            description: "AppRole for read access to secrets from Vault"
        )
        separator(
            name: "separatorKubernetes",
            sectionHeader: "Kubernetes",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        string(
            name: "url",
            defaultValue: "https://192.168.3.101:6443"
        )
        string(
            name: "namespace",
            defaultValue: "kube-system"
        )
        text(
            name: "commands",
            description: "Commands to execute (each command on a new line)",
            defaultValue: """kubectl get nodes
kubectl get pods
kubectl top pods"""
        )
    }
    stages {
        stage("Get Kubernetes token from Jenkins Credentials") {
            when {
                expression { ! params.vault }
            }
            steps {
                script {
                    log.stage()
                    withCredentials([
                        string(
                            credentialsId: "${params.tokenCred}",
                            variable: "kubetoken"
                        )]) {
                        K8S_TOKEN = kubetoken
                    }
                }
            }
        }
        stage("Get Kubernetes token from Vault") {
            when {
                expression { params.vault }
            }
            steps {
                script {
                    log.stage()
                    // Конфигурация для подключения к Vault
                    def vaultConfiguration = [
                        vaultUrl:           params.vaultUrl,
                        vaultCredentialId:  params.vaultAppRole,
                        engineVersion:      2
                    ]
                    // Массив для извлечения секретов
                    def vaultSecrets  = [
                        [
                            path: params.vaultPath,
                            engineVersion: 2,
                            secretValues: [
                                // [
                                //     envVar: "kubeconfig",
                                //     vaultKey: "config"
                                // ],
                                [
                                    envVar: "kubetoken",    // название переменной
                                    vaultKey: "token"       // ключ в Vault
                                ]
                            ]
                        ]
                    ]
                    // Метод извлечения секретов из Vault
                    withVault(
                        [
                            configuration:  vaultConfiguration,
                            vaultSecrets:   vaultSecrets
                        ]
                    ) {
                        // Записываем содержимое конфигурации в файл
                        // writeFile(
                        //     file: "${WORKSPACE}/kubeconfig.yaml",
                        //     text: kubeconfig
                        // )
                        // Передаем содержимое токена в глобальную переменную
                        K8S_TOKEN = kubetoken
                    }
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
        stage("Run kubectl commands") {
            steps {
                script {
                    log.stage()
                    def commands = params.commands.split("\n")
                    for (cmd in commands) {
                        cmd = cmd.replaceAll("kubectl", "").trim()
                        log.warn("▶ kubectl ${cmd}")
                        def results = sh(
                            script: """
                                set +x
                                kubectl --insecure-skip-tls-verify \
                                    --kubeconfig=/dev/null \
                                    --server=${params.url} \
                                    --namespace=${params.namespace} \
                                    --token=${K8S_TOKEN} \
                                    ${cmd}
                            """,
                            returnStatus: false,
                            returnStdout: true
                        )
                        log.success(results)
                    }
                }
            }
        }
    }
}