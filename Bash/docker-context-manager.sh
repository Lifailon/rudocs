DCM_SSH_HOSTS=localhost,192.168.3.105,192.168.3.106
DCM_SSH_USER=lifailon
DCM_SSH_PORT=2121
DCM_SOCKET_PATH=/tmp/remote-docker.sock

# dcm (Docker Context Manager)
function dcm() {
    DCM_SSH_HOST=$(printf "%s\n" ${DCM_SSH_HOSTS//,/ } | fzf --exact --no-sort --height 20 --reverse)
    if [ -n "$DCM_SSH_HOST" ]; then
        if [ $DCM_SSH_HOST == "localhost" ]; then
            pkill -f "ssh -fNL $DCM_SOCKET_PATH"
            ps aux | grep "[s]sh -fNL" > /dev/null 2>&1 && echo -e "\e[31mError: socket not stopped\e[0m"
            rm -f /tmp/remote-docker.sock
            ls $DCM_SOCKET_PATH > /dev/null 2>&1 && echo -e "\e[31mError: socket not deleted\e[0m"
            unset DOCKER_HOST
        else
            pkill -f "ssh -fNL $DCM_SOCKET_PATH"
            ps aux | grep "[s]sh -fNL" > /dev/null 2>&1 && echo -e "\e[31mError: socket not stopped\e[0m"
            rm -f /tmp/remote-docker.sock
            ls $DCM_SOCKET_PATH > /dev/null 2>&1 && echo -e "\e[31mError: socket not deleted\e[0m"
            ssh -fNL $DCM_SOCKET_PATH:/var/run/docker.sock "$DCM_SSH_USER@$DCM_SSH_HOST" -p $DCM_SSH_PORT
            export DOCKER_HOST="unix://$DCM_SOCKET_PATH"
            ps aux | grep "[s]sh -fNL" 1> /dev/null || echo -e "\e[31mError: socket not forwarded\e[0m"
        fi
    fi
}

# lazydocker over dcm
alias ld=lazydocker
function dcl() {
    DCM_SSH_HOST=$(printf "%s\n" ${DCM_SSH_HOSTS//,/ } | fzf --exact --no-sort --height 20 --reverse)
    if [ -n "$DCM_SSH_HOST" ]; then
        # Delete socket 
        pkill -f "ssh -fNL $DCM_SOCKET_PATH"
        ps aux | grep "[s]sh -fNL" > /dev/null 2>&1 && echo -e "\e[31mError: socket not stopped\e[0m"
        rm -f /tmp/remote-docker.sock
        ls $DCM_SOCKET_PATH > /dev/null 2>&1 && echo -e "\e[31mError: socket not deleted\e[0m"
        # Create socket
        ssh -fNL $DCM_SOCKET_PATH:/var/run/docker.sock "$DCM_SSH_USER@$DCM_SSH_HOST" -p $DCM_SSH_PORT
        export DOCKER_HOST="unix://$DCM_SOCKET_PATH"
        ps aux | grep "[s]sh -fNL" 1> /dev/null || echo -e "\e[31mError: socket not forwarded\e[0m"
        ld
        # Delete socket 
        pkill -f "ssh -fNL $DCM_SOCKET_PATH"
        ps aux | grep "[s]sh -fNL" > /dev/null 2>&1 && echo -e "\e[31mError: socket not stopped\e[0m"
        rm -f /tmp/remote-docker.sock
        ls $DCM_SOCKET_PATH > /dev/null 2>&1 && echo -e "\e[31mError: socket not deleted\e[0m"
        unset DOCKER_HOST
    fi
}