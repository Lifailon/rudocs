import groovy.json.JsonOutput
import java.net.InetSocketAddress
import java.net.Proxy
import java.net.HttpURLConnection

@NonCPS

def sendMessage(Map config) {
    def token = config.token
    def chatId = config.chatId
    def message = config.message

    if (!token || !chatId || !message) {
        error "Telegram Error: Missing required parameters (token, chatId, or message)"
    }

    def payload = [
        chat_id: chatId,
        text: message,
        parse_mode: 'Markdown'
    ]
    def jsonPayload = JsonOutput.toJson(payload)

    try {
        def url = new URL("https://api.telegram.org/bot${token}/sendMessage")
        HttpURLConnection connection

        if (config.proxyHost && config.proxyPort) {
            def proxyType = config.proxyType?.toUpperCase() == 'SOCKS' ? Proxy.Type.SOCKS : Proxy.Type.HTTP
            def proxyAddress = new InetSocketAddress(config.proxyHost, config.proxyPort as Integer)
            def proxy = new Proxy(proxyType, proxyAddress)
            connection = (HttpURLConnection) url.openConnection(proxy)
            if (config.proxyUser && config.proxyPassword) {
                def authString = "${config.proxyUser}:${config.proxyPassword}".getBytes("UTF-8").encodeBase64().toString()
                connection.setRequestProperty(
                    "Proxy-Authorization",
                    "Basic ${authString}"
                )
            }
        } else {
            connection = (HttpURLConnection) url.openConnection()
        }
        
        connection.setRequestMethod("POST")
        connection.setRequestProperty(
            "Content-Type",
            "application/json; charset=UTF-8"
        )
        connection.setDoOutput(true)
        
        def outputStream = connection.getOutputStream()
        outputStream.write(jsonPayload.getBytes("UTF-8"))
        outputStream.flush()
        outputStream.close()

        def responseCode = connection.getResponseCode()
        if (responseCode != 200) {
            def errorResponse = connection.getErrorStream()?.text ?: "No error body"
            echo "Telegram API Error (Status ${responseCode}): ${errorResponse}"
        }

        connection.disconnect()
    } catch (Exception e) {
        echo "Telegram Notification Failed: ${e.getMessage()}"
    }
}

def sendStatus(Map config) {
    def token = config.token
    def chatId = config.chatId
    def status = config.status ? config.status.toUpperCase() : 'INFO'

    def icon = 'ℹ️'
    if (status == 'SUCCESS') icon = '✅'
    else if (status == 'FAILURE') icon = '❌'
    else if (status == 'UNSTABLE') icon = '⚠️'
    else if (status == 'ABORTED') icon = '🛑'

    def cause = currentBuild.rawBuild?.getCauses()?.get(0)
    def userName = cause && cause.class.simpleName == 'UserIdCause' ? cause.getUserName() : 'System / SCM'

    def changeLogSets = currentBuild.changeSets
    def commitAuthors = []
    for (int i = 0; i < changeLogSets.size(); i++) {
        def entries = changeLogSets[i].items
        for (int j = 0; j < entries.length; j++) {
            commitAuthors.add(entries[j].author.fullName)
        }
    }
    def authorsText = commitAuthors.unique().join(', ') ?: 'no changes'

    def duration = currentBuild.durationString.replace(' and no more', '')

    def text = """
${icon} *Build:* [${env.JOB_NAME}](${env.BUILD_URL})
*Number:* #${env.BUILD_ID}
*Status:* ${status}
*Started By:* ${userName}
*Commit Authors:* ${authorsText}
*Duration:* ${duration}
""".stripIndent().trim()

    sendMessage(
        token: token, 
        chatId: chatId, 
        message: text,
        proxyHost: config.proxyHost,
        proxyPort: config.proxyPort,
        proxyType: config.proxyType,
        proxyUser: config.proxyUser,
        proxyPassword: config.proxyPassword
    )
}
