# duin

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 4.31.0](https://img.shields.io/badge/AppVersion-4.31.0-informational?style=flat-square)

Telegram notifications for Docker registry image updates

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.config.logJson | string | `"false"` | Логи в формате json |
| app.config.logLevel | string | `"info"` | Режим логирования |
| app.config.scheduler | string | `"0 */6 * * *"` | Периодичность проверок обновления образов (каждые 6 часов по умолчанию) |
| app.config.timezone | string | `"Etc/GMT+3"` | Временная зона |
| app.config.watch | string | `"true"` | Если значение false, то поды не имеющие аннотации - diun.enable: "true" будут игнорироваться |
| app.proxy.enabled | bool | `true` | Включить использование прокси |
| app.proxy.env.HTTPS_PROXY | string | `"http://192.168.3.105:20171"` | Прокси сервер для зашифрованных запросов HTTP+TLS     |
| app.proxy.env.HTTP_PROXY | string | `"http://192.168.3.105:20171"` | Прокси сервер для HTTP запросов |
| app.proxy.env.NO_PROXY | string | `"kubernetes.default,svc.cluster.local,cluster.local,localhost,10.96.0.1,127.0.0.1,192.168.3.0/24"` | Список адресов, запросы к котором идут напрямую без прокси |
| app.secrets.telegram.id | string | `""` | Идентификатор чата или канала Telegram для получения уведомлений |
| app.secrets.telegram.token | string | `""` | API ключ для доступа к боту Telegram для отправки уведомлений |

