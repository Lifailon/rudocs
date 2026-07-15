#!/bin/bash

set -e -E

GEMINI_API_KEY="$GEMINI_API_KEY"

cat << EOF > request.json
{
    "model": "models/gemini-3-flash-preview",
    "input": "",
    "tools": [
        {
            "type": "google_search"
        }
    ],
    "generation_config": {
        "temperature": 1,
        "max_output_tokens": 65536,
        "top_p": 0.95,
        "thinking_level": "high"
    }
}
EOF

curl -X POST \
    -H "Content-Type: application/json" \
    "https://generativelanguage.googleapis.com/v1beta/interactions?key=${GEMINI_API_KEY}" -d '@request.json'