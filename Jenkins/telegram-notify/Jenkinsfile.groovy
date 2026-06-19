@Library([
    'rudocs-shared-library@main'
]) _

pipeline {
    agent any
    environment {
        PROXY_HOST = '192.168.3.110'
        PROXY_PORT = '2080'
    }
    stages {
        stage('Send notify to Telegram') {
            steps {
                script {
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
                        // sh "HTTPS_PROXY=http://192.168.3.110:2080 curl -X GET https://api.telegram.org/bot${TELEGRAM_TOKEN}/getMe"
                        telegram.sendMessage(
                            token: env.TELEGRAM_TOKEN, 
                            chatId: env.TELEGRAM_CHAT_ID,
                            proxyHost: env.PROXY_HOST,
                            proxyPort: env.PROXY_PORT,
                            message: "Start job [${env.JOB_NAME}](${env.BUILD_URL})"
                        )
                    }
                }
            }
        }
    }
    post {
        always {
            script {
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
            }
        }
    }
}
