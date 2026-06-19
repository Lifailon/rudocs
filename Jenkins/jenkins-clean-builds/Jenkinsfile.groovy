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
                    def result = cleanBuilds(3, env.JOB_NAME)
                    log.info("Removed ${result.builds} build in ${result.jobs} jobs")
                }
            }
        }
    }
}
