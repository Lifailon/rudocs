#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage:    gen <RPS> <DURATION> <URL>"
    echo "Example:  gen 20 30 https://httpbin.org/get"
    exit 1
fi

RPS=$1
DURATION=$2
URL=$3

SUCCESS_FILE=$(mktemp)
FAIL_FILE=$(mktemp)
TOTAL_FILE=$(mktemp)

request() {
    local start_time=$(date +%s%N)
    local code=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 --max-time 10 "$URL" 2>/dev/null || echo "000")
    local end_time=$(date +%s%N)
    local response_time=$(( (end_time - start_time) / 1000000 ))
    if [[ "$code" =~ ^2[0-9][0-9]$ ]]; then
        echo "$response_time" >> "$SUCCESS_FILE"
        echo "success" >> "$TOTAL_FILE"
    elif [ "$code" = "000" ]; then
        echo "$response_time" >> "$FAIL_FILE"
        echo "timeout" >> "$TOTAL_FILE"
    else
        echo "$response_time" >> "$FAIL_FILE"
        echo "fail" >> "$TOTAL_FILE"
    fi
}

START_TIME=$(date +%s)
END_TIME=$((START_TIME + DURATION))
INTERVAL=$(echo "scale=6; 1 / $RPS" | bc)

while [ $(date +%s) -lt $END_TIME ]; do
    CYCLE_START=$(date +%s.%N)
    for ((i=0; i<RPS; i++)); do
        request &
    done
    CYCLE_END=$(date +%s.%N)

    ELAPSED=$(echo "$CYCLE_END - $CYCLE_START" | bc)
    SLEEP_TIME=$(echo "1.000000 - $ELAPSED" | bc)

    if [ $(echo "$SLEEP_TIME > 0" | bc) -eq 1 ]; then
        sleep $SLEEP_TIME
    fi
done

wait

SUCCESS_COUNT=$(wc -l < "$SUCCESS_FILE" 2>/dev/null || echo 0)
FAIL_COUNT=$(wc -l < "$FAIL_FILE" 2>/dev/null || echo 0)
TOTAL_REQUESTS=$((SUCCESS_COUNT + FAIL_COUNT))

if [ $SUCCESS_COUNT -gt 0 ]; then
    sort -n "$SUCCESS_FILE" > "${SUCCESS_FILE}.sorted"
    p95_line=$(awk -v count=$SUCCESS_COUNT 'BEGIN {v=count*0.95; print (v==int(v)?v:int(v)+1)}')
    if [ "$p95_line" -gt "$SUCCESS_COUNT" ]; then p95_line=$SUCCESS_COUNT; fi
    min=$(head -1 "${SUCCESS_FILE}.sorted")
    max=$(tail -1 "${SUCCESS_FILE}.sorted")
    p95=$(sed -n "${p95_line}p" "${SUCCESS_FILE}.sorted")
    avg=$(awk '{sum+=$1} END {if (NR>0) printf "%.2f", sum/NR; else print 0}' "$SUCCESS_FILE")
else
    min=0; max=0; p95=0; avg=0
fi

echo -e "\033[32m"
echo "==============================================================="
echo -e "\033[0m"
echo "URL:                  $URL"
echo "Duration:             $DURATION sec"
echo "RPS:                  $(echo "scale=2; $TOTAL_REQUESTS / $DURATION" | bc)/$RPS"
echo "Total requests:       $TOTAL_REQUESTS"
if [ "$TOTAL_REQUESTS" -gt 0 ]; then
    echo "Success requests:     $SUCCESS_COUNT ($(echo "scale=2; $SUCCESS_COUNT * 100 / $TOTAL_REQUESTS" | bc)%)"
    echo "Failed requests:      $FAIL_COUNT ($(echo "scale=2; $FAIL_COUNT * 100 / $TOTAL_REQUESTS" | bc)%)"
else
    echo "Success requests:     0 (0%)"
    echo "Failed requests:      0 (0%)"
fi
echo "Response time avg:    $avg"
echo "Response time min:    $min"
echo "Response time max:    $max"
echo "Response time 95%:    $p95"
echo -e "\033[32m"
echo "==============================================================="
echo -e "\033[0m"

rm -f "$SUCCESS_FILE" "$FAIL_FILE" "$TOTAL_FILE" "${SUCCESS_FILE}.sorted"