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

def NAMESPACE = "--all-namespaces"

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
        PATH = "${KUBECTLPATH}:${env.PATH}"
    }
    parameters {
        base64File 'UPLOAD_KUBECONFIG_FILE'
        credentials(
            name: 'kubeconfigFile',
            credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl',
            defaultValue: 'kubeconfig-file'
        )
        string(
            name: 'namespace',
            defaultValue: 'all',
            description: 'Введите название пространства имен (по умолчанию, "all-namespaces")'
        )
        booleanParam(
            name: 'nodes',
            defaultValue: true,
            description: 'Получение информации о состояние нод в кластере (статус, роли, время работы и версию)'
        )
        booleanParam(
            name: 'components',
            defaultValue: true,
            description: 'Получение информации о состояние компонентов кластера (etcd, scheduler, controller-manager и других)'
        )
        booleanParam(
            name: 'top',
            defaultValue: true,
            description: 'Отображает текущую утилизацию ресурсов (процессору и памяти) по нодам и подам'
        )
        booleanParam(
            name: 'resources',
            defaultValue: true,
            description: 'Отображает состояние всех ресурсов в кластере (поды, сервисы, задания, хранилища, сетевые контроллеры и другие)'
        )
        booleanParam(
            name: 'events',
            defaultValue: true,
            description: 'Получить информация обо всех событиях для всех ресурсов в кластере'
        )
        booleanParam(
            name: 'dump',
            defaultValue: false,
            description: 'Снятие дампа с информаций о кластере и загрузкой в артифакты сборки'
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
                    log.info("Определяем параметр пространства имен")
                    if (params.namespace == "" || params.namespace == "all" || params.namespace == "all-namespaces") {
                        log.info("Опрашиваем все namespace")
                    } else {
                        log.info("Опрашиваем namespace: ${params.namespace}")
                        NAMESPACE = "--namespace=${params.namespace}"
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
                }
            }
        }
        stage("Get cluster info") {
            when {
                expression { params.nodes || params.components || params.top || params.resources || params.events}
            }
            steps {
                script {
                    log.stage()
                    if (params.nodes) {
                        log.info("Получаем информацию о состояние нод в кластере (статус, роли, время работы и версию)")
                        def nodes = sh(
                            script: "kubectl get nodes --insecure-skip-tls-verify=true ${NAMESPACE}",
                            returnStdout: true
                        )
                        log.success(nodes)
                    }
                    if (params.components) {
                        log.info("Получаем информацию о состояние компонентов кластера (etcd, scheduler, controller-manager и другие)")
                        def components = sh(
                            script: "kubectl get componentstatuses --insecure-skip-tls-verify=true ${NAMESPACE}",
                            returnStdout: true
                        )
                        log.success(components)
                        log.info("Получаем информацию о состояние готовности всех компонентов в кластере")
                        components = sh(
                            script: "kubectl get --raw '/readyz?verbose' --insecure-skip-tls-verify=true ${NAMESPACE}",
                            returnStdout: true
                        ).trim()
                        components.split('\n').each { line ->
                            if (line.endsWith("ok")) {
                                log.success(line)
                            } else {
                                log.warn(line)
                            }
                        }
                    }
                    if (params.top) {
                        log.info("Получаем текущую утилизацию ресурсов на нодах")
                        def topNodes = sh(
                            script: "kubectl top nodes --insecure-skip-tls-verify=true || true",
                            returnStdout: true
                        )
                        log.success(topNodes)
                        log.info("Получаем текущую утилизацию ресурсов на подах")
                        def topPods = sh(
                            script: "kubectl top pods --insecure-skip-tls-verify=true ${NAMESPACE} || true",
                            returnStdout: true
                        )
                        log.success(topPods)
                    }
                    if (params.resources) {
                        log.info("Получаем состояние всех ресурсов в кластере (поды, сервисы, задания и другие)")
                        def resources = sh(
                            script: "kubectl get all --insecure-skip-tls-verify=true ${NAMESPACE}",
                            returnStdout: true
                        )
                        log.success(resources)
                        log.info("Получаем состояние всех хранилищ в кластере")
                        def volumes = sh(
                            script: "kubectl get pv,pvc,storageclasses --insecure-skip-tls-verify=true ${NAMESPACE}",
                            returnStdout: true
                        )
                        log.success(volumes)
                        log.info("Получаем состояние сетевых контроллеров")
                        def network = sh(
                            script: "kubectl get ingress,ingressclasses,networkpolicies --insecure-skip-tls-verify=true ${NAMESPACE}",
                            returnStdout: true
                        )
                        log.success(network)
                        log.info("Получаем список всех конфигураций и секретов")
                        def configs = sh(
                            script: "kubectl get configmaps,secrets --insecure-skip-tls-verify=true ${NAMESPACE}",
                            returnStdout: true
                        )
                        log.success(configs)
                    }
                    if (params.events) {
                        log.info("Получаем информацию обо всех событиях для всех ресурсов в кластере")
                        sh """
                            kubectl get events --insecure-skip-tls-verify=true ${NAMESPACE} --sort-by='.metadata.creationTimestamp' | \
                                awk '/Warning/ {print "\033[33m" \$0 "\033[0m"; next} /Normal/ {print "\033[34m" \$0 "\033[0m"; next} {print}'
                        """
                    }
                }
            }
        }
        stage("Dump cluster info") {
            when {
                expression { params.dump }
            }
            steps {
                script {
                    log.stage()
                    log.info("Выгружаем дамп")
                    sh "kubectl cluster-info dump --insecure-skip-tls-verify=true ${NAMESPACE} --output-directory=./cluster-info"
                    zip(
                        dir: "cluster-info",
                        zipFile: "cluster-info.zip",
                        archive: true
                    )
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