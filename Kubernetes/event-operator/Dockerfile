# Базовый образ (содержит shell-operator, jq и kubectl)
FROM flant/shell-operator:latest

COPY notify-operator.sh /hooks/handler.sh

RUN chmod +x /hooks/handler.sh