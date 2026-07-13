@Library([
    'rudocs-shared-library@main'
]) _

pipeline {
    agent any
    options {
        ansiColor("xterm")
        timestamps()
        timeout(time: 10, unit: "MINUTES")
        buildDiscarder(
            logRotator(
                numToKeepStr: '15',
                daysToKeepStr: '',
                artifactNumToKeepStr: '5',
                artifactDaysToKeepStr: ''
            )
        )
    }
    environment {
        KUBECONFIG = "${WORKSPACE}/kubeconfig.yaml"
        KUBECTLPATH = tool(
            name: "kubectl-1.36.0",
            type: "com.cloudbees.jenkins.plugins.customtools.CustomTool"
        )
        KREWPATH = tool(
            name: "krew-0.5.0",
            type: "com.cloudbees.jenkins.plugins.customtools.CustomTool"
        )
        PATH = "${KUBECTLPATH}:${KREWPATH}:${HOME}/.krew/bin:${env.PATH}"
    }
    parameters {
        base64File 'UPLOAD_KUBECONFIG_FILE'
        credentials(
            name: 'kubeconfigFile',
            credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl',
            defaultValue: 'kubeconfig-file'
        )
        string(
            name: 'since',
            defaultValue: '365d',
            description: 'Filter resources by creation time'
        )
        booleanParam(
            name: 'upload',
            defaultValue: true,
            description: 'Upload all yaml manifests into artifacts'
        )
        booleanParam(
            name: 'clean',
            defaultValue: true,
            description: 'Clean system resources from manifests'
        )
        booleanParam(
            name: 'split',
            defaultValue: true,
            description: 'Split manifests into files'
        )
    }
    stages {
        stage("Get kubeconfig file") {
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
                            log.info("Загружаем файл kubeconfig из параметра Jenkins")
                            writeFile(
                                file: "${WORKSPACE}/kubeconfig.yaml",
                                text: KUBECONFIG
                            )
                            kubeconfigReady = true
                        }
                    }
                    if (!kubeconfigReady) {
                        log.info("Загружаем файл kubeconfig из Jenkins File Credentials")
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
        stage("Check tools") {
            steps {
                script {
                    log.stage()
                    log.info("Проверяем версию kubectl")
                    def results = sh(
                        script: "kubectl version --output=json || true",
                        returnStdout: true
                    )
                    log.success(results)
                    log.info("Проверяем версию krew")
                    results = sh(
                        script: "krew version",
                        returnStdout: true
                    )
                    log.success(results)
                    log.info("Устанавливаем плагины")
                    results = sh(
                        script: """
                            krew install get-all neat
                            krew list
                        """,
                        returnStdout: true
                    )
                    log.success(results)
                    log.info("Проверяем версию плагина neat")
                    results = sh(
                        script: "kubectl neat version",
                        returnStdout: true
                    )
                    log.success(results)
                }
            }
        }
        stage("Get all resources") {
            steps {
                script {
                    log.stage()
                    def resources = sh(
                        script: "kubectl get-all --insecure-skip-tls-verify=true --since ${params.since}",
                        returnStdout: true
                    )
                    log.success(resources)
                }
            }
        }
        stage("Upload manifests into artifacts") {
            when {
                expression { params.upload }
            }
            steps {
                script {
                    log.stage()
                    def rawYaml = sh(
                        script: "kubectl get-all --insecure-skip-tls-verify=true --since ${params.since} -o yaml",
                        returnStdout: true
                    )
                    writeFile(
                        file: "manifests-raw.yaml",
                        text: rawYaml
                    )
                    archiveArtifacts(
                        artifacts: "manifests-raw.yaml",
                        allowEmptyArchive: true
                    )
                    if (params.clean) {
                        def manifests = rawYaml.split(/(?m)^---$/)
                        def cleanYaml = ""
                        log.info("Найдено ресурсов в кластере: ${manifests.size()}")
                        int backupCount = 0
                        int skipCount = 0
                        int failCount = 0
                        if (params.split) {
                            sh "mkdir -p manifests-backup"
                        }
                        for (manifest in manifests) {
                            def trimManifest = manifest.trim()
                            if (!trimManifest) {
                                continue
                            }
                            if (trimManifest.contains("ownerReferences:")) {
                                skipCount++
                                continue
                            }
                            try {
                                writeFile(
                                    file: 'manifest.yaml',
                                    text: trimManifest
                                )
                                def yamlFromNeat = sh(
                                    script: "kubectl neat < manifest.yaml",
                                    returnStdout: true
                                ).trim()
                                if (yamlFromNeat) {
                                    cleanYaml += "---\n" + yamlFromNeat + "\n"
                                    backupCount++
                                    if (params.split) {
                                        try {
                                            def parsedYaml = new org.yaml.snakeyaml.Yaml().load(yamlFromNeat)
                                            if (parsedYaml && parsedYaml instanceof Map) {
                                                def kind = parsedYaml.get('kind') ?: "unknown"
                                                def metaMap = parsedYaml.get('metadata') ?: [:]
                                                def name = metaMap.get('name') ?: "unknown"
                                                def namespace = metaMap.get('namespace') ?: "unknown"
                                                def fileName = "${namespace}-${kind}-${name}".toLowerCase().replaceAll(/[^a-z0-9\._\-]/, "") + ".yaml"
                                                writeFile(
                                                    file: "manifests-backup/${fileName}",
                                                    text: yamlFromNeat
                                                )
                                            }
                                        } catch (Exception yamlEx) {
                                            log.warn(yamlEx.message)
                                        }
                                    }
                                }
                            } catch (Exception e) {
                                log.error("Ошибка обработки манифеста через neat: ${e.message}")
                                log.warn(
                                    readFile("manifest.yaml")
                                )
                                failCount++
                            }
                        }
                        log.info("Обработано ресурсов: ${backupCount}")
                        log.warn("Пропущено ресурсов: ${skipCount}")
                        log.error("Ошибок обработки: ${failCount}")
                        writeFile(
                            file: "manifests-clean.yaml",
                            text: cleanYaml
                        )
                        archiveArtifacts(
                            artifacts: "manifests-clean.yaml",
                            allowEmptyArchive: true
                        )
                        sh "tar -czf manifests-backup.tar.gz manifests-backup/"
                        archiveArtifacts(
                            artifacts: "manifests-backup.tar.gz",
                            allowEmptyArchive: true
                        )
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs(
                deleteDirs: true,
                notFailBuild: true,
                disableDeferredWipeout: true
            )
        }
    }
}