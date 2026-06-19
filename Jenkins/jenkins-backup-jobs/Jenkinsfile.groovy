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
                        credentialsId: 'ssh-creds',
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
}