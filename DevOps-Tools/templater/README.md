## TemplateR (Go Template Render)

Шаблонизатор на базе пакет [Go Tamplate](https://pkg.go.dev/text/template) с поддержкой передачи параметров из переменных окружения и/или конфигурации в формате `JSON` или `YAML`.

Пример шаблонизации файла [nginx](./nginx.tmpl) из [конфигурационного файла](./config.json):

```bash
WEB_PORT=443 go run main.go -t ./nginx.tmpl -c ./config.yml
# или
export WEB_PORT=443
go run main.go -t ./nginx.tmpl -c ./config.yml
```

Windows:

```PowerShell
$env:WEB_PORT=443; go run main.go -t .\nginx.tmpl -c .\config.yml
```

Вывод:

```nginx
server {
    # Берем порт из переменных окружения или выставляем 80 по умолчанию
    listen 443 ssl;

    server_name web.frontend.local;

    ssl_certificate /opt/nginx/ssl/server.crt;
    ssl_certificate_key /opt/nginx/ssl/server.key;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_stapling on;
    ssl_stapling_verify on;

    root /opt/nginx/html/web;
    index index.html;

    if ($request_method !~ ^(GET|POST)$) {
        return 405;
    }

    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /assets/ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    location /api/ {
        proxy_pass https://api.backend.local/;

        # Цикл для переопределения заголовков из config
        proxy_set_header Host api.backend.local;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_connect_timeout 5s;
        proxy_read_timeout 30s;
        proxy_send_timeout 30s;

        proxy_ssl_protocols TLSv1.2 TLSv1.3;
        proxy_ssl_server_name on;
        proxy_ssl_name api.backend.local;

        # Проверка серверного сертификата на backend
        proxy_ssl_verify on;
        proxy_ssl_trusted_certificate /opt/nginx/ssl/ca.crt;
        proxy_ssl_verify_depth 2;

        # Отправка клиентского сертификата на backend для работы в режиме mTLS
        proxy_ssl_certificate /opt/nginx/ssl/client.crt;
        proxy_ssl_certificate_key /opt/nginx/ssl/client.key;
    }
}
```