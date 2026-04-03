function sysStat() {
    top=$(top -bn1)
    cpu=$(echo "$top" | grep "%Cpu(s)" | awk '{printf "%.0f%%", 100-$8}')
    # sys=$(echo "$top" | grep "%Cpu(s)" | awk '{printf "%.0f%%", $4}')
    # usr=$(echo "$top" | grep "%Cpu(s)" | awk '{printf "%.0f%%", $2}')
    avg=$(echo "$top" | grep "load average" | awk -F ': ' '{print $2}' | awk -F ', ' '{print $1"/"$2"/"$3}')
    mem=$(echo "$top" | grep "MiB Mem" | awk '{printf "%.1fG/%.1fG", ($8)/1024, $4/1024}')
    disk=$(df -h | awk '$NF=="/"{print $3"/"$2}')
    echo "📊 $cpu ($avg) $mem 💾 $disk"
}

function gitStatus() {
    status=$(git status --porcelain 2>/dev/null)
    if [ -z "$status" ]; then
        echo ""
        return
    fi
    branch=$(git rev-parse --abbrev-ref HEAD)
    result="🔸 ($branch) "
    added=$(echo "$status" | grep -c '^?')
    modified=$(echo "$status" | grep -c '^ M')
    deleted=$(echo "$status" | grep -c '^ D')
    [ "$added" -gt 0 ] && result+="\e[32m+${added} \e[0m"
    [ "$modified" -gt 0 ] && result+="\e[33m~${modified} \e[0m"
    [ "$deleted" -gt 0 ] && result+="\e[31m-${deleted} \e[0m"
    echo "$result"
}

export PROMPT_COMMAND+='
    SYSSTAT=$(sysStat);
    GITSTATUS=$(gitStatus);
'

PS1='\[\e[34m\]$SYSSTAT \[\e[0m\]'
PS1+='\[\e[32m\]👤 \u \[\e[0m\]'
PS1+='\[\e[33m\]📁 \w \[\e[0m\]'
PS1+='$(echo -e "$GITSTATUS")'
PS1+='\[\e[34m\]> \[\e[0m\]'