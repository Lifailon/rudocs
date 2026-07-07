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
        ansiColor("xterm")
        timestamps()
        timeout(time: 30, unit: 'MINUTES')
    }
    environment {
        KUBECONFIG = "${WORKSPACE}/kubeconfig.yaml"
        KUBECTLPATH = tool(
            name: "kubectl-1.36.0",
            type: "com.cloudbees.jenkins.plugins.customtools.CustomTool"
        )
        HELM_PATH = tool(
            name: 'helm-4.2.0',
            type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
        )
        PATH = "${KUBECTLPATH}:${HELM_PATH}:${env.PATH}"
    }
    parameters {
       credentials(
            name: 'kubeconfigFile',
            credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl',
            defaultValue: 'kubeconfig-file'
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
        string(
            name: "chartPath",
            defaultValue: "Kubernetes/dozzle",
            description: "Путь к директории с Helm Chart относительно корня репозитория"
        )
        string(
            name: "chartValues",
            defaultValue: "Kubernetes/dozzle/values.yaml",
            description: "Путь к файлу values.yaml с параметрами Helm Chart"
        )
        string(
            name: "diffOptions",
            defaultValue: "diff -u", // --color=always
            description: "Параметры для сверки (например, -b для игнорирования пробелов или -B для пустых строк)"
        )
    }
    stages {
        stage("Check tools") {
            steps {
                script {
                    log.stage()
                    log.info("Проверка версии helm")
                    def helmVersion = sh(
                        script: """
                            helm version || true
                        """,
                        returnStatus: false,
                        returnStdout: true
                    )
                    log.success(helmVersion)
                    log.info("Проверка версии kubectl")
                    def kubectlVersion = sh(
                        script: """
                            kubectl version --output=json || true
                        """,
                        returnStatus: false,
                        returnStdout: true
                    )
                    log.success(kubectlVersion)
                    log.info("Проверка версии linux diff")
                    def diffVersion = sh(
                        script: """
                            diff --version || true
                        """,
                        returnStatus: false,
                        returnStdout: true
                    )
                    log.success(diffVersion)
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
                        extensions: [[
                            $class: 'CloneOption',
                            depth: 1,
                            shallow: true
                        ]]
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
        stage('Helm diff') {
            environment {
                KUBECONFIG = credentials("${params.kubeconfigFile}")
            }
            steps {
                script {
                    log.stage()
                    env.KUBECTL_EXTERNAL_DIFF = params.diffOptions
                    def reportFile = "${WORKSPACE}/helm-diff-report.html"
                    def chartName = params.chartPath.split("/")[-1]
                    def html = """
                    <html>
                    <head>
                        <title>Helm Diff Report</title>
                        <style>
                            body { font-family: monospace; background-color: #1e1e1e; color: #d4d4d4; padding: 20px; }
                            h2 { color: #569cd6; border-bottom: 1px solid #3c3c3c; padding-bottom: 10px; }

                            .chart-title { background: #422e24; color: #ce9178; padding: 10px 15px; border-left: 6px solid #ce9178; border-radius: 4px; margin-top: 20px; margin-bottom: 10px; font-size: 14px; font-weight: bold; }
                            .chart-divider { border: 0; height: 1px; background: linear-gradient(to right, #ce9178, #3c3c3c, transparent); margin: 25px 0 15px 0; }
                            
                            details { margin-top: 15px; margin-bottom: 15px; }
                            summary { color: #4fc1ff; font-size: 12px; background: #2d2d30; padding: 8px; border-left: 4px solid #569cd6; border-radius: 4px; cursor: pointer; outline: none; user-select: none; list-style-position: inside; }
                            summary:hover { background: #333337; }
                            summary::-webkit-details-marker { color: #569cd6; margin-right: 5px; }
                            
                            pre { background-color: #252526; padding: 15px; border-radius: 0 0 5px 5px; border: 1px solid #3c3c3c; border-top: none; overflow-x: auto; white-space: pre-wrap; margin-top: 0; }
                            .addition { color: #6a9955; }
                            .deletion { color: #f44747; }
                            .info { color: #4fc1ff; }
                            .no-changes { color: #888888; font-style: italic; }
                        </style>
                    </head>
                    <body>
                        <h2>☸️ Helm Diff Report</h2>
                    """
                    html += "<div class=\"chart-title\">📦 Chart: ${chartName}</div>"
                    sh """
                        helm template ${params.chartPath} --values ${params.chartValues} > ${chartName}-template.yaml
                        kubectl diff -f ${chartName}-template.yaml --insecure-skip-tls-verify=true > ${chartName}-raw.diff 2>&1 || true
                    """
                    def rawDiff = readFile(
                        file: "${chartName}-raw.diff",
                        encoding: 'UTF-8'
                    ).trim()
                    if (rawDiff.length() > 0) {
                        def lines = rawDiff.split('\n')
                        def currentFileBlock = ""
                        def isFirstFile = true
                        for (int i = 0; i < lines.length; i++) {
                            def line = lines[i]
                            def safeLine = line.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                            if (safeLine.startsWith("diff ")) {
                                if (!isFirstFile && currentFileBlock.length() > 0) {
                                    html += currentFileBlock + "</pre></details>"
                                    currentFileBlock = ""
                                }
                                def fullResourceName = safeLine.tokenize('/')[-1] ?: ""
                                def parts = fullResourceName.tokenize('.')
                                def fileName = parts.size() > 3 ? parts[3..-1].join('.') : (fullResourceName ?: "Unknown Resource")
                                html += "<details open><summary>📄 File: ${fileName}</summary>"
                                currentFileBlock = "<pre>"
                                isFirstFile = false
                            } else {
                                if (currentFileBlock == "") {
                                    html += "<details open><summary>📄 Общий заголовок Diff</summary><pre>"
                                    currentFileBlock = "<pre>"
                                    isFirstFile = false
                                }                                
                                if (safeLine.startsWith("--- ") || safeLine.startsWith("+++ ")) {
                                    currentFileBlock += "<span class=\"info\">${safeLine}</span>\n"
                                } else if (safeLine.startsWith("+")) {
                                    currentFileBlock += "<span class=\"addition\">${safeLine}</span>\n"
                                } else if (safeLine.startsWith("-")) {
                                    currentFileBlock += "<span class=\"deletion\">${safeLine}</span>\n"
                                } else if (safeLine.startsWith("@@")) {
                                    currentFileBlock += "<span class=\"info\">${safeLine}</span>\n"
                                } else {
                                    currentFileBlock += "${safeLine}\n"
                                }
                            }
                        }
                        if (currentFileBlock.length() > 0) {
                            html += currentFileBlock + "</pre></details>"
                        }
                    } else {
                        html += "<p class=\"no-changes\">Изменений нет</p>"
                    }
                    sh "rm -f ${chartName}-template.yaml ${chartName}-raw.diff"
                    html += "</body></html>"
                    writeFile file: reportFile, text: html, encoding: 'UTF-8'
                    publishHTML([
                        allowMissing: false,
                        alwaysLinkToLastBuild: true,
                        keepAll: true,
                        reportDir: "${WORKSPACE}",
                        reportFiles: 'helm-diff-report.html',
                        reportName: 'Helm Diff Report',
                        reportTitles: 'Helm Diff Summary'
                    ])
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