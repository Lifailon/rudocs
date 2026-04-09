#!/bin/bash

if [[ $1 == "--config" ]] ; then
    cat <<EOF
configVersion: v1
kubernetes:
- apiVersion: "api.tg.com/v1"
  kind: TelegramNotify
  executeHookOnEvent: ["Added"]
- apiVersion: v1
  kind: Event
  executeHookOnEvent: ["Added"]
EOF
else
    SHELL_TYPE=$(cat "$BINDING_CONTEXT_PATH" | jq -r .[0].type)
    if [[ "$SHELL_TYPE" == "Added" ]]; then
        KIND=$(cat "$BINDING_CONTEXT_PATH" | jq -r .[0].object.kind)
        case "$KIND" in
            "TelegramNotify")
                TELEGRAM_CHAT_ID=$(cat "$BINDING_CONTEXT_PATH" | jq -r '.[0].object.spec.chatId')
                TELEGRAM_CHAT_ID=${TELEGRAM_CHAT_ID:-$TELEGRAM_CHAT_ID_DEFAULT}
                MESSAGE=$(cat "$BINDING_CONTEXT_PATH" | jq -r '.[0].object.spec.message')
                curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_API_KEY/sendMessage" \
                    -d "chat_id=$TELEGRAM_CHAT_ID" \
                    -d "text=🔔 [K8s Alert]\n\n$MESSAGE" \
                    -d "parse_mode=markdown"
            ;;
            "Event")
                EVENT_TYPE=$(jq -r '.[0].object.type' "$BINDING_CONTEXT_PATH")
                if [[ "$EVENT_TYPE" == "Warning" ]]; then
                    REASON=$(cat "$BINDING_CONTEXT_PATH" | jq -r '.[0].object.reason')
                    MESSAGE=$(cat "$BINDING_CONTEXT_PATH" | jq -r '.[0].object.message')
                    OBJECT_KIND=$(cat "$BINDING_CONTEXT_PATH" | jq -r '.[0].object.involvedObject.kind')
                    OBJECT_NAME=$(cat "$BINDING_CONTEXT_PATH" | jq -r '.[0].object.involvedObject.name')
                    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_API_KEY/sendMessage" \
                        -d "chat_id=$TELEGRAM_CHAT_ID_DEFAULT" \
                        -d "text=⚠ [K8s Warning Event]\n\n*Object:* $OBJECT_KIND/$OBJECT_NAME\n*Reason:* $REASON\n*Message:* $MESSAGE" \
                        -d "parse_mode=markdown"
                fi
            ;;
        esac
    fi
fi