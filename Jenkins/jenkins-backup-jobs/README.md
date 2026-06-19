# Jenkins Backup Jobs

Универсальный Jenkins Pipeline для резервного копирования всех проектов (jobs) и экспорта в артифакты по расписанию.

Настройка расписания по будням в 22:00:

```groovy
triggers {
    cron('00 22 * * 1-5')
}
```

![](img/cron.jpg)

Артифакты:

![](img/artifacts.jpg)