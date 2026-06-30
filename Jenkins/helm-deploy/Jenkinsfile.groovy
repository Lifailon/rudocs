@Library([
    'rudocs-shared-library@main'
]) _

pipeline {
    agent any
    options {
        ansiColor("xterm")
        timestamps()
        timeout(time: 30, unit: 'MINUTES')
    }
    environment {
        KUBECONFIG = "${WORKSPACE}/kubeconfig"
        HELM_PATH = tool(
            name: 'helm-4.2.0',
            type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
        )
        PATH = "${HELM_PATH}:${env.PATH}"
    }
    parameters {
        choice(
            name: "mode",
            description: "Режим работы: развертвывание или обновление (Deploy), откат (Rollback) или удаление (Uninstall)",
            choices: [
                "Deploy",
                "Rollback",
                "Uninstall"
            ]
        )
        string(
            name: "revision",
            defaultValue: "",
            description: "Указать номер ревизии или оставить пустым для отката на предыдущую установку в режиме Rollback. Историю ревизий можно получить из лога сборки в режиме dryRun."
        )
        separator(
            name: "gitParams",
            sectionHeader: "Git settings",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        string(
            name: "gitUrl",
            defaultValue: "https://github.com/Lifailon/rudocs"
        )
        string(
            name: "branch",
            defaultValue: "main"
        )
        separator(
            name: "helmChartParams",
            sectionHeader: "Helm chart settings",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        string(
            name: "chartPath",
            defaultValue: "Kubernetes/dozzle",
            description: "Путь к директории с Helm Chart относительно корня репозитория"
        )
        string(
            name: "valuesPath",
            defaultValue: "",
            description: "Путь к специфическому для стенда файлу с параметрами Helm Chart. По умолчанию, будет использоваться файл values.yaml из директории чарта."
        )
        booleanParam(
            name: "helmTemplate",
            defaultValue: true,
            description: 'Проверить рендеринг манифестов перед установкой'
        )
        booleanParam(
            name: "outputTemplate",
            defaultValue: false,
            description: 'Вывести содержимое манифестов после рендеринга в лог сборки'
        )
        separator(
            name: "kubernetesClusterParams",
            sectionHeader: "Kubernetes cluster settings",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        string(
            name: "clusterUrl",
            defaultValue: "https://192.168.3.101:6443"
        )
        string(
            name: "namespace",
            defaultValue: "monitoring",
        )
        credentials(
            name: 'token',
            credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.StringCredentialsImpl',
            defaultValue: 'k3s-token',
            description: 'Токен для доступа к Kubernetes API'
        )
        string(
            name: "timeout",
            defaultValue: "900s",
            description: 'Время ожидания успешного выполнения команды helm (формат: 1h, 30m, 900s)'
        )
        booleanParam(
            name: "dryRun",
            defaultValue: true,
            description: 'Пробный запуск в режиме отладки (без установки изменений в кластер)'
        )
        booleanParam(
            name: "atomic",
            defaultValue: true,
            description: 'Автоматический откат (удаление всех устанавливаемых ресурсов) при ошибке или таймауте'
        )
        booleanParam(
            name: "force",
            defaultValue: false,
            description: 'Принудительное обновление (пересоздание ресурсов при конфликтах)'
        )
    }
    stages {
        stage("Check tools") {
            steps {
                script {
                    log.stage()
                    sh "ls -lhR $HELM_PATH || true"
                    def helmVersion = sh(
                        script: """
                            helm version || true
                        """,
                        returnStatus: false,
                        returnStdout: true
                    )
                    log.success(helmVersion)
                    if (currentBuild.description == null) { currentBuild.description = "" }
                    currentBuild.description += "<b>Mode</b>: ${params.mode}<br/>"
                    currentBuild.description += "<b>Dry-run</b>: ${params.dryRun}<br/>"
                    def chartName = params.chartPath.tokenize('/')[-1]
                    currentBuild.description += "<b>Chart</b>: ${chartName}<br/>"
                }
            }
        }
        stage('Git checkout') {
            steps {
                script {
                    log.stage()
                    branchName = params.branch ? params.branch : "main"
                    checkout([
                        $class: 'GitSCM', 
                        userRemoteConfigs: [[
                            url: params.gitUrl
                        ]],
                        branches: [[
                            name: branchName
                        ]], 
                        extensions: [
                            [$class: 'CloneOption', depth: 1, shallow: true],
                            [$class: 'WipeWorkspace']
                        ]
                    ])
                    log.info("Содержимое репозитория:")
                    def lsGit = sh(
                        script: "ls -lh",
                        returnStatus: false,
                        returnStdout: true
                    )
                    log.success(lsGit)
                    log.info("Содержимое чарта:")
                    def lsChart = sh(
                        script: "ls -lhR ${params.chartPath}",
                        returnStatus: false,
                        returnStdout: true
                    )
                    log.success(lsChart)
                }
            }
        }
        stage("Check render template") {
            when {
                expression { params.helmTemplate }
            }
            steps {
                script {
                    log.stage()
                    // Проверяем параметр с кастомными переменными или передаем дефолтный
                    def valuesPath = params.valuesPath?.trim() ?: "${params.chartPath}/values.yaml"
                    def cmd = "helm template ${params.chartPath} --values ${valuesPath}"
                    // Логируем команду
                    log.warn(cmd)
                    // Подавляем вывод и извлекаем код возврата
                    def renderManifestsResult = sh(
                        script: "${cmd} > result.temp 2>&1",
                        returnStatus: true,
                        returnStdout: false
                    )
                    // Проверяем код возврата и логируем ошибку
                    if (renderManifestsResult == 0) {
                        log.success("Рендеринг манифестов прошел успешно")
                        if (params.outputTemplate) {
                            log.success(
                                readFile("result.temp").trim()
                            )
                        }
                    } else {
                        log.error("Ошибка рендеринга манифестов")
                        def err = readFile("result.temp").trim()
                        log.error("\n${err}\n")
                    }
                }
            }
        }
        stage("Helm deployment") {
            steps {
                script {
                    log.stage()
                    withCredentials([string(
                        credentialsId: params.token,
                        variable: "K8S_TOKEN"
                    )]) {
                        def contextName = "jenkins"
                        def chartName = params.chartPath.tokenize('/')[-1]
                        def valuesPath = params.valuesPath?.trim() ?: "${params.chartPath}/values.yaml"
                        def K8S_URL = params.clusterUrl
                        def K8S_NS = params.namespace
                        // Генерируем и логируем kubeconfig
                        def kubeConfig = helm.kubeConfigGenerate(
                            contextName,
                            K8S_URL,
                            K8S_NS,
                            K8S_TOKEN
                        )
                        log.warn(kubeConfig)
                        // Записываем содержиме kubeconfig в файл
                        writeFile(
                            file: "${WORKSPACE}/kubeconfig",
                            text: kubeConfig
                        )
                        // Проверяем код возврата и логируем историю версий (ревизий) перед установкой или откатом
                        def cmdHistory = "helm history ${chartName} --kube-context ${contextName}"
                        def checkHistory = sh(
                            script: cmdHistory,
                            returnStatus: true,
                            returnStdout: false
                        )
                        if (checkHistory == 0) {
                            def helmHistory = sh(
                                script: cmdHistory,
                                returnStatus: false,
                                returnStdout: true
                            )
                            log.success("\nИстория версий для ${chartName} в кластере ${K8S_URL}")
                            log.success("\n${helmHistory}\n")
                        } else {
                            log.error("\nИстория версий для ${chartName} в кластере ${K8S_URL} не получена\n")
                            // Останавливаем сборку в режиме отката, если история не получена
                            if (params.mode == "Rollback") {
                                error("Невозможно произвести Rollback")
                            }
                        }
                        // Откатываем релиз до указанной или предыдущей версии
                        if (params.mode  == "Rollback") {
                            log.warn("Откат ${chartName} в кластере ${K8S_URL}")
                            def cmd = "helm rollback ${chartName} ${params.revision} --kube-context ${contextName} --insecure-skip-tls-verify"
                            log.warn(cmd)
                            sh(cmd)
                        } else if (params.mode  == "Uninstall") {
                            log.warn("Удаление ${chartName} в кластере ${K8S_URL}")
                            def cmd = "helm uninstall ${chartName} --kube-context ${contextName} --insecure-skip-tls-verify"
                            log.warn(cmd)
                            sh(cmd)
                        } else {
                            log.warn("Установка ${chartName} в кластере ${K8S_URL}")
                            // Генерируем helm команду для установки/обновления
                            def cmd = helm.upgradeCommandGenerate(
                                chartName,
                                params.chartPath,
                                valuesPath,
                                contextName,
                                K8S_NS,
                                params.timeout,
                                params.dryRun,
                                params.atomic,
                                params.force
                            )
                            // Логируем собранную команду и запускаем установку
                            log.warn(cmd)
                            sh(cmd)
                        }
                        // Логируем историю версий после установки (если не пробный запуск) или отката
                        if ((params.mode == "Deploy" && !params.dryRun) || params.mode  == "Rollback") {
                            def helmHistoryAfterRollback = sh(
                                script: cmdHistory,
                                returnStatus: false,
                                returnStdout: true
                            )
                            if (params.mode  == "Rollback") {
                                log.success("\nИстория версий после отката для ${chartName} в кластере ${K8S_URL}")
                            } else {
                                log.success("\nИстория версий после установки для ${chartName} в кластере ${K8S_URL}")
                            }
                            log.success("\n${helmHistoryAfterRollback}\n")
                        }
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