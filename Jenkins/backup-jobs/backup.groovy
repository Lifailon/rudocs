import org.apache.http.client.methods.HttpGet
import org.apache.http.impl.client.HttpClients
import org.apache.http.util.EntityUtils
import org.apache.http.HttpHeaders
import groovy.json.JsonSlurper

// Функция для извлечения учетных данных на сервере
def getCred(credentials) {
    def creds = com.cloudbees.plugins.credentials.CredentialsProvider
        .lookupCredentials(
            com.cloudbees.plugins.credentials.common.StandardUsernamePasswordCredentials.class,
            Jenkins.instance
        )
        .find { it.id == credentials }
    if (!creds) {
        return ["Credentials not found"]
    }
    def username = creds.username
    def password = creds.password.plainText
    return [
        username,
        password
    ]
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

def jenkinsUrl = "http://192.168.3.101:8010"                // Change url for Jenkins server
def credentials = "ssh-creds"    // Change ID for Username with password from credentials

if (!jenkinsUrl) {
    return ["Jenkins url not set"]
}
def creds = getCred(credentials)
def username = creds[0]
def password = creds[1]
if (!username || !password) {
    return ["Credentials not found"]
}

def jobsList = getJobs(jenkinsUrl,username,password)
if (!(jobsList instanceof List)) {
    return [jobsList]
}

def exportPath = "/var/jenkins_home/jobs-backup/"
exportJobsConfig(jenkinsUrl, username, password, jobsList, exportPath)