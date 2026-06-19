# Telegram Notify

Пример Jenkins Pipeline для отправки оповещений в Telegram с поддержкой подключения Proxy для доступа к Telegram API.

Поддверживает 2 режима работы:

- Отправка произвольного сообщения с помощью метода `telegram.sendMessage()`
- Отправка статуса сборки, используя метод `telegram.sendStatus()`, примемущественно в блоке `post{}`

Параметры:

- `token` - токен бота Telegram для доступа к Telegram API
- `chatId` - идентификатор чата или канала/группы
- `message` - произвольный текст для метода `sendMessage()` с поддержкой формата Markdown
- `status` - статус работы для метода `sendStatus()`
- `proxyHost` - адрес прокси-сервера (опционально)
- `proxyPort` - порт прокси-срвера (опционально)
- `proxyUser` - имя пользователя для доступа к прокси-серверу (опционально)
- `proxyPassword` - пароль для доступа к прокси-серверу (опционально)

Для работы конвейра, создайте секреты `telegram-token` и `telegram-channel`, а также подключите библиотеку `rudocs-shared-library` с скриптом `telegram`:

![](../jenkins-clean-builds/img/add-shared-library.jpg)
