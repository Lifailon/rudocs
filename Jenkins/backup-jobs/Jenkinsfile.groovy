import org.apache.http.client.methods.HttpGet
import org.apache.http.impl.client.HttpClients
import org.apache.http.util.EntityUtils
import org.apache.http.HttpHeaders
import groovy.json.JsonSlurper

// Функция для извлечения учетных данных в Pipeline
def getCred(credentials) {
    def username = ""
    def password = ""
    withCredentials([usernamePassword(
        credentialsId: credentials,
        usernameVariable: 'USERNAME',
        passwordVariable: 'PASSWORD'
    )]) {
        username = env.USERNAME
        password = env.PASSWORD
    }
    return [username, password]
}

// Функция для получения списка всех jobs
def getJobs(jenkinsUrl, username, password, includeFolders = true) {
    try {
        def authString = "${username}:${password}".bytes.encodeBase64().toString()
        def authHeader = "Basic ${authString}"
        def client = HttpClients.createDefault()
        // Запрашиваем только необходимые поля (name и class)
        // Поле class нужно для определения типа элемента (job или folder)
        def getRequest = new HttpGet("${jenkinsUrl}/api/json?tree=jobs[name,class]")
        getRequest.setHeader(HttpHeaders.AUTHORIZATION, authHeader)
        def response = client.execute(getRequest)
        try {
            def json = EntityUtils.toString(response.getEntity())
            def slurper = new JsonSlurper()
            def jobsData = slurper.parseText(json)
            def allJobs = []
            getJobsFolder(jenkinsUrl, authHeader, jobsData.jobs, allJobs, includeFolders)
            return allJobs
        } 
        finally {
            response.close()
            client.close()
        }
    }
    catch(Exception err) {
        println "Error getting jobs list: ${err.message}"
        return []
    }
}

// Функция для обработки вложенности jobs в директория
def getJobsFolder(baseUrl, authHeader, jobs, collector, includeFolders, currentPath = '') {
    jobs.each { job ->
        def fullJobName = currentPath ? "${currentPath}/${job.name}" : job.name
        if (job._class?.contains('Folder') && includeFolders) {
            try {
                def client = HttpClients.createDefault()
                def encodedPath = job.name.split('/').collect { 
                    URLEncoder.encode(it, 'UTF-8').replace('+', '%20') 
                }.join('/')
                def folderRequest = new HttpGet("${baseUrl}/job/${encodedPath}/api/json?tree=jobs[name,class]")
                folderRequest.setHeader(HttpHeaders.AUTHORIZATION, authHeader)
                def response = client.execute(folderRequest)
                try {
                    def json = EntityUtils.toString(response.getEntity())
                    def slurper = new JsonSlurper()
                    def folderData = slurper.parseText(json)
                    getJobsFolder(baseUrl, authHeader, folderData.jobs, collector, includeFolders, fullJobName)
                } finally {
                    response.close()
                    client.close()
                }
            } catch(Exception e) {
                println "Error processing folder ${job.name}: ${e.message}"
            }
        } else {
            collector << fullJobName
        }
    }
}

// Основная функция для экспорта
def exportJobsConfig(jenkinsUrl, username, password, jobsList, exportPath) {
    // Формируем авторизационные данные
    def authString = "${username}:${password}".bytes.encodeBase64().toString()
    def authHeader = "Basic ${authString}"
    // Пересоздаем директорию
    def exportDir = new File(exportPath)
    exportDir.deleteDir()
    exportDir.mkdirs()
    // Проходимся по всем конфигурациям в массиве
    jobsList.each { jobName ->
        try {
            def client = HttpClients.createDefault()
            // Формируем URL для вложенных jobs
            def jobUrlPath = jobName.split('/').collect { 
                // Экранируем пробелы в пути названия jobs
                URLEncoder.encode(it, 'UTF-8').replace('+', '%20')
            }.join('/job/')
            // Формируем URL для загрузки config.xml
            def getRequest = new HttpGet("${jenkinsUrl}/job/${jobUrlPath}/config.xml")
            // Передаем авторизационные данные в заголовки
            getRequest.setHeader(HttpHeaders.AUTHORIZATION, authHeader)
            // Читаем конфигурацию
            def response = client.execute(getRequest)
            try {
                if (response.statusLine.statusCode == 200) {
                    // Получаем содержимое config.xml
                    def configXml = EntityUtils.toString(response.getEntity())
                    // Формируем путь для сохранения и заменяем запрещенные символы в название
                    def jobPathComponents = jobName.split('/')
                    def safeFileName = jobPathComponents.last().replaceAll('[\\\\/:*?"<>| ]', '_')
                    // Создаём поддиректории
                    def targetDir = exportDir
                    if (jobPathComponents.size() > 1) {
                        def subDirs = jobPathComponents[0..-2].collect { 
                            it.replaceAll('[\\\\/:*?"<>| ]', '_') 
                        }
                        targetDir = new File(exportDir, subDirs.join(File.separator))
                        targetDir.mkdirs()
                    }
                    // Создаем файл для экспорта в целевой директории
                    def exportFile = new File(targetDir, "${safeFileName}.xml")
                    // Записываем содержимое в файл
                    exportFile.write(configXml)
                    println "Successfully export '${jobName}' to ${exportFile.absolutePath}"
                } else {
                    println "Failed export '${jobName}': HTTP ${response.statusLine.statusCode}"
                }
            }
            finally {
                response.close()
                client.close()
            }
        }
        catch(Exception err) {
            println "Failed export '${jobName}': ${err.message}"
        }
    }
}

pipeline {
    agent {
        label 'built-in' // Jenkins Server Agent
    }
    triggers {
        cron('30 23 * * 1-5')
    }
    options {
        timeout(time: 10, unit: 'MINUTES')
    }
    parameters {
        string(
            name: 'jenkinsUrl',
            defaultValue: 'http://192.168.3.101:8010',
            description: 'Jenkins server address\nFormat: http[s]://<IP/HOSTNAME>:PORT.'
        )
        credentials(
            name: 'credentials',
            description: 'Username with password from Jenkins Credentials for API connection.',
            credentialType: 'com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl',
            defaultValue: 'ssh-creds',
            required: true
        )
        booleanParam(
            name: "export",
            defaultValue: false,
            description: 'Export config in artifacts.'
        )
    }
    stages {
        stage('Backup') {
            steps {
                script {
                    if (!params.jenkinsUrl) {
                        echo "Jenkins url not set"
                        return
                    }
                    def creds = getCred(params.credentials)
                    def username = creds[0]
                    def password = creds[1]
                    if (!username || !password) {
                        echo "Credentials not found"
                        return
                    }
                    def jobsList = getJobs(params.jenkinsUrl,username,password)
                    if (!(jobsList instanceof List)) {
                        echo jobsList
                        return
                    }
                    def exportPath = ""
                    if (params.export) {
                        exportPath = "${env.WORKSPACE}/jobs-backup/"
                    } else {
                        exportPath = "/var/jenkins_home/jobs-backup/"
                    }
                    exportJobsConfig(params.jenkinsUrl, username, password, jobsList, exportPath)
                }
            }
        }
        stage('Export') {
            when {
                expression { params.export }
            }
            steps {
                archiveArtifacts artifacts: "jobs-backup/**/*", allowEmptyArchive: true
            }
        }
    }
}