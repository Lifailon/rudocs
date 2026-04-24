#!/bin/bash

if [[ $1 == "--config" ]]; then
    cat <<EOF
configVersion: v1
kubernetes:
- apiVersion: v1
  kind: Event
  executeHookOnEvent: ["Added"]
EOF
else
    KIND=$(jq -r '.[0].object.kind' "$BINDING_CONTEXT_PATH")
    case "$KIND" in
        "Event")
            EVENT_TYPE=$(jq -r '.[0].object.type' "$BINDING_CONTEXT_PATH")
            if [[ "$WARNING_ONLY" == "true" && "$EVENT_TYPE" != "Warning" ]]; then
                exit 0
            fi
            REASON=$(jq -r '.[0].object.reason' "$BINDING_CONTEXT_PATH")
            RAW_MSG=$(jq -r '.[0].object.message' "$BINDING_CONTEXT_PATH")
            OBJECT_KIND=$(jq -r '.[0].object.involvedObject.kind' "$BINDING_CONTEXT_PATH")
            OBJECT_NAME=$(jq -r '.[0].object.involvedObject.name' "$BINDING_CONTEXT_PATH")
            ICON="💡"; [[ "$EVENT_TYPE" == "Warning" ]] && ICON="⚠️"
            MESSAGE=$(cat <<EOF
${ICON} Kubernetes Event

*Type:* ${EVENT_TYPE}/${REASON}
*Object:* ${OBJECT_KIND}/${OBJECT_NAME}
*Message:* ${RAW_MSG}
EOF
)
            shoutrrr send --url "$SHOUTRRR_TELEGRAM" --message "$MESSAGE"
        ;;
    esac
fi