# Jenkins Pipelines

Коллекция универсальных Jenkins Pipeline, которые я использую в своей домашней лаборатории для автоматизации базовых задач.

- [Parallel Execution Pipeline](parallel-execution-pipeline/README.md)
- [Parallel SSH Pipeline](parallel-ssh-pipeline/README.md)
- [Make Runner](make-runner/README.md)
- [GitHub Binary Deploy](github-binary-deploy/README.md)
- [Go CI/CD](go-ci-cd/README.md)
- [Docker CI](docker-ci/README.md)
- [Docker CD](docker-cd/README.md)
- [API Request](api-request/README.md)
- [Update authorized_keys](update-authorized_keys/README.md)
- [Backup Jobs](export-and-backup-jobs/README.md)

## Plugins

Список используемых плагинов.

| Плагин                                                                                            | Описание                                                                                                                        |
| -                                                                                                 | -                                                                                                                               |
| [Pipeline Nodes and Processes](https://jenkins.io/doc/pipeline/steps/workflow-durable-task-step)  | Плагин, который предоставляет доступ к интерпретаторам `sh`, `bat`, `powershell` и `pwsh`                                       |
| [Pipeline Utility Steps](https://jenkins.io/doc/pipeline/steps/pipeline-utility-steps)            | Добавляет методы `readJSON`, `writeJSON`, `readYaml`, `writeYaml`, `readTOML`, `writeTOM`, `untar`, `unzip`, и другие           |
| [HTTP Request](https://plugins.jenkins.io/http_request)                                           | Простой `REST` API Client для отправки и обработки `GET` и `POST` запросов через метод `httpRequest(url: url, httpMode: "GET")` |
| [Credentials Binding](https://jenkins.io/doc/pipeline/steps/credentials-binding)                  | Добавляет метод `withCredentials` для доступа к секретам                                                                        |
| [HashiCorp Vault](https://plugins.jenkins.io/hashicorp-vault-plugin)                              | Автоматизирует процесс получения содержимого значений из `HashCorp Vault` с помощью метода `withVault`                          |
| [Ansible](https://plugins.jenkins.io/ansible)                                                     | Параметраризует запуск `ansible-playbook` (требуется установка на агенте) через метод `ansiblePlaybook`                         |
| [SSH Pipeline Steps](https://plugins.jenkins.io/ssh-steps)                                        | Плагин для подключения к удаленным машинам через протокол `ssh` по ключу или паролю                                             |
| [SSH Agent](https://www.jenkins.io/doc/pipeline/steps/ssh-agent)                                  | Плагин для подключения к удаленным машинам с использованием `ssh-agent` и `Credentials`                                         |
| [Workspace Cleanup](https://plugins.jenkins.io/ws-cleanup)                                        | Плагин добавляет метод `cleanWs()` для удаления рабочей область сборки.                                                         |
| [Pipeline Stage View](https://plugins.jenkins.io/pipeline-stage-view)                             | Визуализация шагов (`stages`) в интерфейсе проекта с временем их выполнения                                                     |
| [Pipeline Graph View](https://plugins.jenkins.io/pipeline-graph-view)                             | Группирует все шаги и выполняемые команды, добавляя кнопку `Pipeline Overview` и заменяя стандартный лог сборки                 |
| [Rebuilder](https://plugins.jenkins.io/rebuild)                                                   | Позволяет перезапускать параметризованную сборку с предустановленными параметрами в выбранной сборке                            |
| [Schedule Build](https://plugins.jenkins.io/schedule-build)                                       | Позволяет запланировать сборку на указанный момент времени                                                                      |
| [Webhook Trigger](https://plugins.jenkins.io/generic-webhook-trigger)                             | Принимает `POST` запросы на конечной точке `/generic-webhook-trigger/invoke` для извлечения значений и запуска Pipeline         |
| [Job Configuration History](https://plugins.jenkins.io/jobConfigHistory)                          | Сохраняет копию файла сборки в формате `xml` (который хранится на сервере) в истории для сверки                                 |
| [Export Job Parameters](https://plugins.jenkins.io/export-job-parameters)                         | Добавляет кнопку `Export Job Parameters` для конвертации все параметров в декларативный синтаксис Pipeline                      |
| [Active Choices Parameters](https://plugins.jenkins.io/uno-choice)                                | Активные параметры, которые позволяют динамически обновлять содержимое параметров                                               |
| [File Parameters](https://plugins.jenkins.io/file-parameters)                                     | Добавляет параметры для загрузки файлов                                                                                         |
| [Separator Parameter](https://plugins.jenkins.io/parameter-separator)                             | Параметр для визуального разделения набора параметров на странице сборки задания с поддержкой `HTML`                            |
| [Custom Tools](https://plugins.jenkins.io/custom-tools-plugin)                                    | Позволяет загружать пакеты (исполняемые файлы) из Интернета с помощью предустановленного набора команд                          |
| [Copy Artifact](https://plugins.jenkins.io/copyartifact)                                          | Позволяет копировать артифакты из одной сборки в другую (например, из последней успешной `copyArtifacts(projectName: jobName)`) |
| [ANSI Color](https://plugins.jenkins.io/ansicolor)                                                | Добавляет поддержку стандартных escape-последовательностей `ANSI` для покраски вывода                                           |
| [Email Extension](https://plugins.jenkins.io/email-ext)                                           | Отправка сообщений на почту по протоколу `SMTP` из Pipeline                                                                     |
| [Config File Provider](https://plugins.jenkins.io/config-file-provider)                           | Хранение конфигураци (например, `settings.xml` для `Maven`) в интерфейсе Jenkins и их шаблонизация c `Credentials`              |
| [Allure](https://plugins.jenkins.io/allure-jenkins-plugin)                                        | Создает отчеты [Allure](https://allurereport.org) для автотестов в интерфейсе Pipeline с отправкой в TestOps                    |
| [SonarQube Scanner](https://plugins.jenkins.io/sonar)                                             | Интегрирует статический анализ кода с помощью метода [withSonarQubeEnv](https://jenkins.io/doc/pipeline/steps/sonar)            |
| [Test Results Analyzer](https://plugins.jenkins.io/test-results-analyzer)                         | Показывает историю результатов сборки `junit` тестов в табличном древовидном виде                                               |
| [Embeddable Build Status](https://plugins.jenkins.io/embeddable-build-status)                     | Предоставляет настраиваемые значки [Shields](https://shields.io), который возвращает статус сборки                              |
| [Prometheus Metrics](https://plugins.jenkins.io/prometheus)                                       | Предоставляет конечную точку `/prometheus` с метриками, которые используются для сбора данных                                   |
| [Web Monitoring](https://plugins.jenkins.io/monitoring)                                           | Добавляет конечную точку `/monitoring` для отображения графиков мониторинга в веб-интерфейсе                                    |
| [CloudBees Disk Usage](https://plugins.jenkins.io/cloudbees-disk-usage-simple)                    | Отображает использование диска всеми заданиями во вкладке `Manage-> Disk usage` для анализа                                     |
