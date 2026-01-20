# Ignore pefix space in command for save in history
export HISTCONTROL=ignorespace
# History search
if [[ "$-" == *i* ]]; then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi
# History search over fzf
if command -v fzf > /dev/null; then
    function hstr() {
        local current_input="$READLINE_LINE"
        command=$(tac $HOME/.bash_history | sed '/^#/d' | awk '!seen[$0]++' |  fzf --exact --no-sort --height 20 --reverse --query="$current_input")
        if [[ -n "$command" ]]; then
            READLINE_LINE="$command"
            READLINE_POINT=${#READLINE_LINE}
        fi
    }
    alias h=hstr
    bind -x '"\C-r": h'
fi