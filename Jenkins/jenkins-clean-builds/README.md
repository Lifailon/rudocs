# Jenkins Clear Builds

Универсальный Jenkins Pipeline для очистики старых сборок (до указанного количества последних сборок, которые требуется оставить) во всех проектах по расписанию.

Для работы Pipeline требуется подключить библиотеку `rudocs-shared-library`, где содержится скрипт `jenkins` c методом `cleanBuilds`:

![](img/add-shared-library.jpg)

Пример сборки:

![](img/clean-builds.jpg)