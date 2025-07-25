# DNS and Proxy Stack

Используемый стек:

- [CoreDNS](https://github.com/coredns/coredns) - движок DNS сервера с базовой конфигурацией для блокировки рекламы (like `pi-hole`) и обработки запросов к хостам через прокси сервер.
- [Nginx Proxy](https://github.com/nginx-proxy/nginx-proxy) в связке с [docker-gen](https://github.com/nginx-proxy/docker-gen) для добавления новых Docker хостов в конфигурацию Nginx по переменной `VIRTUAL_HOST`.
- [hosts-gen](./entrypoint) - скрипт, который запускается в контейнере для автоматического обновляния списка запрещеных адресов и синхронизации списка хостов для прокси сервера.

> Для запуска DNS сервера, необходимо отключить встроенный `DNSStubListener` в `systemd`.

Практический пример:

Добавили новый контейнер в `docker-compose.yml`:

```yml
nginx2:
  image: nginx
  environment:
    - VIRTUAL_HOST=nginx2.local
```

Перезапустили стект для запуска нового контейнера

```bash
docker-compose up -d
```

В течение 10 секунд автоматически обновляются конфигурации на серверах Nginx с помощью `docker-gen` и DNS с помощью `hosts-gen`.