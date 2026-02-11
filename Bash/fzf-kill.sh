function fzf-kill() {
    ps -ef | sed "1d" | fzf --header="UID          PID    PPID  C STIME TTY          TIME CMD" --height=50% --layout=reverse | awk '{print $2}' | xargs -r kill -9
}