@Library([
    'rudocs-shared-library@main'
]) _

pipeline {
    agent {
        label 'built-in'
    }
    triggers {
        cron('00 22 * * 1-5')
    }
    options {
        timeout(time: 10, unit: 'MINUTES')
    }
    parameters {
        string(
            name: 'jenkinsUrl',
            defaultValue: 'http://192.168.3.105:8010',
            description: 'Jenkins server address\nFormat: http[s]://<IP/HOSTNAME>:PORT.'
        )
        booleanParam(
            name: "export",
            defaultValue: true,
            description: 'Export config in artifacts.'
        )
    }
    stages {
        stage('Backup jobs') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'jenkins-api-cred',
                        usernameVariable: 'USERNAME',
                        passwordVariable: 'PASSWORD'
                    )]) {
                        def username = env.USERNAME
                        def password = env.PASSWORD
                        def jobsList = jenkins.getJobs(
                            params.jenkinsUrl,
                            username,
                            password
                        )
                        if (!(jobsList instanceof List)) {
                            echo jobsList
                            return
                        }
                        def exportPath = ""
                        if (params.export) {
                            exportPath = "${env.WORKSPACE}/jenkins-backup-jobs/"
                        } else {
                            exportPath = "/var/jenkins_home/jenkins-backup-jobs/"
                        }
                        jenkins.exportJobsConfig(
                            params.jenkinsUrl,
                            username,
                            password,
                            jobsList,
                            exportPath
                        )
                    }
                }
            }
        }
        stage('Export jobs') {
            when {
                expression { params.export }
            }
            steps {
                archiveArtifacts(
                    artifacts: "jenkins-backup-jobs/**/*",
                    allowEmptyArchive: true
                )
            }
        }
    }
    post {
        always {
            script {
                env.PROXY_HOST = '192.168.3.110'
                env.PROXY_PORT = '2080'
                try {
                    withCredentials([
                        string(
                            credentialsId: "telegram-token",
                            variable: "TELEGRAM_TOKEN"
                        ),
                        string(
                            credentialsId: "telegram-channel",
                            variable: "TELEGRAM_CHAT_ID"
                        ),
                    ]) {
                        telegram.sendStatus(
                            token: env.TELEGRAM_TOKEN, 
                            chatId: env.TELEGRAM_CHAT_ID, 
                            status: currentBuild.currentResult,
                            proxyHost: env.PROXY_HOST,
                            proxyPort: env.PROXY_PORT
                        )
                    }
                } catch (Exception e) {
                    echo "Telegram Error: ${e.getMessage()}"
                }
            }
        }
    }
}