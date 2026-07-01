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
        separator(
            name: "gitParams",
            sectionHeader: "Git repository settings",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
        string(
            name: "gitUrl",
            defaultValue: "https://github.com/Lifailon/rudocs"
        )
        reactiveChoice(
            name: 'branch',
            choiceType: "PT_SINGLE_SELECT",
            filterable: true,
            script: [
                $class: "GroovyScript",
                script: [
                    sandbox: true,
                    script: '''
                        import groovy.json.JsonSlurper
                        def comIndex = gitUrl.indexOf(".com")
                        def repoPath = gitUrl.substring(comIndex + 5).replace(".git", "")
                        def apiUrl = "https://api.github.com/repos/${repoPath}/branches"
                        def URL = new URL(apiUrl)
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
            referencedParameters: "gitUrl"
        )
        separator(
            name: "helmChartParams",
            sectionHeader: "Helm chart settings",
            separatorStyle: "border-color: blue",
            sectionHeaderStyle: "font-size: 1.5em; font-weight: bold;"
        )
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
        // string(
        //     name: "chartPath",
        //     defaultValue: "Kubernetes/dozzle",
        //     description: "Путь к директории с Helm Chart относительно корня репозитория"
        // )
        reactiveChoice (
            name: "chartPath",
            choiceType: "PT_SINGLE_SELECT",
            filterable: true,
            script: [
                $class: "GroovyScript",
                script: [
                    sandbox: true,
                    script: '''
                        try {
                            def comIndex = gitUrl.indexOf(".com")
                            if (comIndex == -1) {
                                return ['Ошибка: Неверный формат gitUrl']
                            }
                            def repoPath = gitUrl.substring(comIndex + 5).replace(".git", "")
                            def repoBranch = (binding.hasVariable('branch') && branch) ? branch : "main"
                            def apiUrl = "https://api.github.com/repos/${repoPath}/git/trees/${repoBranch}?recursive=1"
                            def connection = new URL(apiUrl).openConnection()
                            connection.requestMethod = "GET"
                            connection.setRequestProperty("User-Agent", "Jenkins-Active-Choices")
                            connection.setRequestProperty("Accept", "application/vnd.github+json")
                            connection.connectTimeout = 5000
                            connection.readTimeout = 5000
                            if (connection.responseCode != 200) {
                                return ["Ошибка ${connection.responseCode} от GitHub API: ${connection.responseMessage}"]
                            }
                            def json = new groovy.json.JsonSlurper().parseText(connection.inputStream.text)
                            def paths = []
                            json.tree.each { item ->
                                if (item.type == "blob" && item.path.endsWith("Chart.yaml")) {
                                    def filePath = item.path
                                    def dirPath = filePath.substring(0, filePath.lastIndexOf("Chart.yaml")).replaceAll("/+\\$", "")
                                    paths.add(dirPath.isEmpty() ? "." : dirPath)
                                }
                            }
                            paths.sort()
                            return paths.isEmpty() ? ['В репозитории не найдено Helm-чартов'] : paths
                        } catch (Exception e) {
                            return ["Ошибка поиска чартов: ${e.message}"]
                        }
                    '''
                ]
            ],
            referencedParameters: "gitUrl,branch"
        )
        activeChoiceHtml(
            name: 'chartValues',
            description: "Содержимое файла values.yaml по умолчанию для изменения параметров выбранного Helm Chart перед запуском.",
            choiceType: 'ET_FORMATTED_HTML',
            script: [
                $class: 'GroovyScript',
                script: [
                    sandbox: true,
                    script: '''
                        try {
                            def comIndex = gitUrl.indexOf(".com")
                            def repoPath = gitUrl.substring(comIndex + 5).replace(".git", "")
                            def repoBranch = (binding.hasVariable('branch') && branch) ? branch : "main"
                            def cleanSlashChartPath = chartPath.replaceAll("^/+", "").replaceAll("/+\\$", "")
                            def rawUrl = "https://raw.githubusercontent.com/${repoPath}/refs/heads/${repoBranch}/${cleanSlashChartPath}/values.yaml"
                            def connection = new URL(rawUrl).openConnection()
                            connection.requestMethod = "GET"
                            connection.connectTimeout = 5000
                            connection.readTimeout = 5000
                            def fileText = ""
                            if (connection.responseCode == 200) {
                                fileText = connection.inputStream.text
                            } else {
                                return "Файл values.yaml не найден. Ошибка ${connection.responseCode}: ${connection.responseMessage}"
                            }
                            def content = fileText.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
                            return """
                            <textarea
                                name="value"
                                id="yaml_editor"
                                style="width: 100%; height: 300px; font-family: monospace; font-size: 13px; padding: 8px; border: 1px solid #ccc; border-radius: 4px;"
                                onchange="this.innerText = this.value">${content}
                            </textarea>
                            """
                        } catch (Exception e) {
                            return "Ошибка загрузки параметров: <b style='color:red;'>${e.message}</b>"
                        }
                    '''
                ],
                fallbackScript: [
                    sandbox: true,
                    script: "return ['Ошибка загрузки формы']"
                ]
            ],
            referencedParameters: 'gitUrl,branch,chartPath'
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
        stage("Update values") {
            when {
                expression { params.chartValues }
            }
            steps {
                script {
                    log.stage()
                    def valuesPath = "${params.chartPath}/values.yaml"
                    env.VALUES_PATH = "${params.chartPath}/values-from-jenkins.yaml"
                    // Удаляем лишние пробелы и переносы строк в исходном файле values.yaml
                    writeFile(
                        file: valuesPath,
                        text: readFile(valuesPath).trim()
                    )
                    log.info("Создаем файл ${env.VALUES_PATH} с обновленными параметрами для Helm Chart")
                    def valuesContent = params.chartValues.toString().trim()
                    // Заменяем экранированные символы переноса строки и кавычек
                    valuesContent = valuesContent.replace('\\n', '\n')
                    valuesContent = valuesContent.replace('\\"', '"')
                    writeFile(
                        file: env.VALUES_PATH,
                        text: valuesContent
                    )
                    sh "ls -lh ${params.chartPath}/values*"
                    log.info("Проверяем изменения (diff) с исходным values.yaml")
                    sh "diff --color=always -u ${valuesPath} ${env.VALUES_PATH} || true"
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
                    def cmd = "helm template ${params.chartPath} --values ${env.VALUES_PATH}"
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
                            def cmd = "helm rollback ${chartName} ${params.revision} --kube-context ${contextName}"
                            log.warn(cmd)
                            sh(cmd)
                        } else if (params.mode  == "Uninstall") {
                            log.warn("Удаление ${chartName} в кластере ${K8S_URL}")
                            def cmd = "helm uninstall ${chartName} --kube-context ${contextName}"
                            log.warn(cmd)
                            sh(cmd)
                        } else {
                            log.warn("Установка ${chartName} в кластере ${K8S_URL}")
                            // Генерируем helm команду для установки/обновления
                            def cmd = helm.upgradeCommandGenerate(
                                chartName,
                                params.chartPath,
                                env.VALUES_PATH,
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