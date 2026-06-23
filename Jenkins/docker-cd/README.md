# Docker CD

Универсальный конструктор для генерации файла `docker-compose` и развертывания контейнеров на удаленном хосте.

> [!NOTE]
> Для работы Pipeline требуется подключить библиотеку `rudocs-shared-library`, где содержится скрипт `compose` c методом `generate`:
>
> ![](../jenkins-clean-builds/img/add-shared-library.jpg)

- Параметры для генерации:

![](img/params-build.jpg)

- Параметры для развертвывания:

![](img/params-deploy.jpg)

- Содержимое `docker-compose` файла после генерации:

> [!NOTE]
> Используйте плагин [Rebuilder](https://plugins.jenkins.io/rebuild) для быстрого перезапуска контейнера с помощью обновления параметров из последней сборки или развертвывания на другом хосте.

![](img/description.jpg)