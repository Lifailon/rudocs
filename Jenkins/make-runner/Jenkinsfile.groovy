def getVariables = "make -np | grep ':=' | grep -v '^#'"

pipeline {
    // Jenkins Agent with make installed
    agent {
        label 'linux'
    }
    options {
        timestamps()
        timeout(time: 10, unit: 'MINUTES')
    }
    parameters {
        string(
            name: 'repo',
            defaultValue: 'Lifailon/lazyjournal',
            description: 'Address for get targets from Makefile on GitHib.\nFormat: <USERNAME/REPOSITORY>.'
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

                        def url = "https://api.github.com/repos/${repo}/branches"
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
            referencedParameters: 'repo'
        )
        reactiveChoice(
            name: 'targets',
            description: 'Select version (tag) on GitHub.',
            choiceType: 'PT_CHECKBOX',
            filterable: true,
            filterLength: 1,
            script: [
                $class: 'GroovyScript',
                script: [
                    sandbox: true,
                    script: '''
                        def getGitFiles(repo) {
                            def url = "https://api.github.com/repos/${repo}/contents"
                            def data = new URL(url).text
                            def json = new groovy.json.JsonSlurper().parseText(data)
                            files = []
                            for (file in json) {
                            	files += file.name
                            }
                            return files
                        }
                        
                        def getMakefileTargets(repo,gitFiles) {
                            def makeFile = ""
                            def makefile = gitFiles.find{it == "Makefile"}
                            if (makefile) {
                                makefile = "Makefile"
                            } else {
                                def makefileCaseInsensitive = gitFiles.find { it.equalsIgnoreCase("makefile") }
                                if (makefileCaseInsensitive) {
                                    makefile = "makefile"
                                } else {
                                    println "Makefile not found"
                                }
                            }
                        
                            def rawMakefile = new URL("https://raw.githubusercontent.com/${repo}/refs/heads/main/${makefile}").text
                            def linesArray = rawMakefile.readLines()
                            def targets = linesArray.findAll { it =~ /^[a-zA-Z_-]+:/ }.collect { it.split(':')[0] }
                            return targets
                        }

                        def gitFiles = getGitFiles(repo)
                        getMakefileTargets(repo,gitFiles)
                    '''
                ]
            ],
            referencedParameters: 'repo'
        )
        booleanParam(
            name: "dryRun",
            defaultValue: true,
            description: "Do not run any commands (recipes), just output them."
        )
        booleanParam(
            name: "parallel",
            defaultValue: false,
            description: "Parallel execution of all selected targets."
        )
        booleanParam(
            name: "ignoreErrors",
            defaultValue: false,
            description: "Ignores errors within the commands (recipes) of the current target, but continues to execute the remaining commands in the same target."
        )
        booleanParam(
            name: "keepGoing",
            defaultValue: false,
            description: "Keep going if some targets fail (ignores errors in targets).\nUsed only for parallel mode."
        )
        booleanParam(
            name: "silent",
            defaultValue: false,
            description: "Do not output executable commands (recipes)."
        )
        booleanParam(
            name: "debug",
            defaultValue: false,
            description: "Print lots of debugging information."
        )
        text(
            name: 'variables',
            defaultValue: '',
            description: 'Set variables, each on a new line.\nFormat: "<KEY=VALUE>"'
        )
        booleanParam(
            name: "uploadArtifacts",
            defaultValue: false,
            description: "Upload files from selected path to Artifacts."
        )
        string(
            name: 'uploadPath',
            defaultValue: '',
            description: 'Specify the path from where to download files.\nExample: bin/*'
        )
    }
    stages {
        stage('Git checkout') {
            when {
                expression { params.repo && params.branch }
            }
            steps {
                script {
                    currentBuild.displayName = "#$BUILD_NUMBER Git checkout"
                    def branch = params.branch ? params.branch : "main"
                    checkout scmGit(
                        branches: [[name: branch]],
                        userRemoteConfigs: [[url: "https://github.com/${params.repo}"]]
                    )
                    sh(script: "ls -lh")
                }
            }
        }
        stage('Run make') {
            when {
                expression { params.repo && params.branch && params.targets }
            }
            steps {
                script {
                    def buildName = params.repo.split("/")[1]
                    currentBuild.displayName = "#${BUILD_NUMBER} ${buildName} (${params.branch}): ${params.targets}"
                    def options = ""
                    if (params.dryRun) {
                        options += "-n "
                    }
                    if (params.ignoreErrors) {
                        options += "-i "
                    }
                    if (params.keepGoing) {
                        options += "-k "
                    }
                    if (params.silent) {
                        options += "-s "
                    }
                    if (params.debug) {
                        options += "-d "
                    }
                    if (params.variables) {
                        def vars = params.variables.trim().split('\n').join(' ')
                        options += "$vars "
                    }
                    if (params.parallel) {
                        currentBuild.displayName += " (parallel mode)"
                        def targets = params.targets.replaceAll(","," ")
                        def jobsCount = params.targets.split(",").size()
                        echo "make $targets -j $jobsCount $options"
                        sh(
                            script: """
                                make $targets -j $jobsCount $options
                            """
                        )
                    } else {
                        def targets = params.targets.split(",")
                        for (target in targets) {
                            echo "make $target $options"
                            sh(
                                script: """
                                    make $target $options
                                """
                            )
                        }
                    }
                    sh(script: "ls -lhR")
                }
            }
        }
        stage('Upload files') {
            when {
                expression { params.repo && params.branch && params.targets && params.uploadPath && params.uploadArtifacts }
            }
            steps {
                script {
                    archiveArtifacts artifacts: params.uploadPath,
                    allowEmptyArchive: true
                }
            }
        }
    }
    post {
        always {
            script {
                sh """
                    ls -lh 
                    rm -rf ./*
                    ls -lh
                """
            }
        }
    }
}