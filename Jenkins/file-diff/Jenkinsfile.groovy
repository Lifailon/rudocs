pipeline {
    agent any
    parameters {
        base64File "FILE_1"
        base64File "FILE_2"
    }
    environment {
        NODEPATH = tool(
            name: 'node-js-24.17.0',
            type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
        )
        PATH = "${NODEPATH}/bin:${env.PATH}"
    }
    stages {
        stage("Check tools") {
            steps {
                sh "node -v"
                sh "npm -v"
                sh "npx -v"
            }
        }
        stage("Read files") {
            steps {
                withFileParameter("FILE_1") {
                    writeFile(
                        text: readFile(FILE_1),
                        file: "${env.WORKSPACE}/file_1.txt"
                    )
                }
                withFileParameter("FILE_2") {
                    writeFile(
                        text: readFile(FILE_2),
                        file: "${env.WORKSPACE}/file_2.txt"
                    )
                }
            }
        }
        stage("Diff files") {
            steps {
                sh '''
                    diff -u file_1.txt file_2.txt > changes.diff || true                    
                    npx diff2html-cli -i file -s side -F diff_report.html -- changes.diff
                '''
            }
        }
        stage("Publish HTML report") {
            steps {
                publishHTML([
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: "${WORKSPACE}",
                    reportFiles: 'diff_report.html',
                    reportName: 'File Diff Report',
                    reportTitles: 'File Diff Summary'
                ])
            }
        }
    }
}