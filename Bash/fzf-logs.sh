alias ts=tailspin

# docker logs over fzf
function logd() {
    contaner_name=$(docker ps --format "{{.Names}}" | fzf --exact --height 20 --reverse)
    if [ -n "$contaner_name" ]; then
        docker logs $contaner_name | ts | fzf --ansi --exact
    fi
}

# varlog over fzf (including including archives)
function log() {
    file_name=$(ls -p /var/log/ | grep -v / | fzf --exact --height 20 --reverse)
    if [ -n "$file_name" ]; then
        if [ "$file_name" == *.gz ]; then
            zcat "/var/log/$file_name" | tac | ts | fzf --ansi --exact
        else
            tac "/var/log/$file_name" | ts | fzf --ansi --exact
        fi
    fi
}

# all file logs over fzf
function logs() {
    if command -v fdfind > /dev/null; then
        file_name=$(fdfind ".log$" / | fzf --exact --height 20 --reverse)
    else
        file_name=$(find / -name "*.log" 2> /dev/null | fzf --exact --height 20 --reverse)
    fi
    if [ -n "$file_name" ]; then
        if [ "$file_name" == *.gz ]; then
            zcat "/var/log/$file_name" | tac | ts | fzf --ansi --exact
        else
            tac "/var/log/$file_name" | ts | fzf --ansi --exact
        fi
    fi
}