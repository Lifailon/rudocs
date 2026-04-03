# fdfind over fzf
if command -v fzf > /dev/null; then
    function fd-fzf() {
        if [ -z "$1" ]; then
            # Current path by default
            fdfind . ${pwd} | fzf
        else
            # Specified path
            fdfind . $1 | fzf
        fi
    }
    # Alt+F for fd-fzf
    bind '"\ef": "fd-fzf\n"'
    # Alt+Shift+F for ripgrep-all over fzf
    bind '"\eF": "rga-fzf\n"'
fi