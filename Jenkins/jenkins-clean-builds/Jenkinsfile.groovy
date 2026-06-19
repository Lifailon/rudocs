@Library([
    'rudocs-shared-library@main'
]) _

pipeline {
    agent {
        label 'built-in'
    }
    options {
        ansiColor('xterm')
    }
    triggers {
        cron('0 23 * * 1-5')
    }
    stages {
        stage('Clean builds') {
            steps {
                script {
                    def result = jenkins.cleanBuilds(3, env.JOB_NAME)
                    log.info("Removed ${result.builds} build in ${result.jobs} jobs")
                }
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