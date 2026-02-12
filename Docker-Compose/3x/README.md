## VDS preparation

### SSH

```bash
sed -i 's/#Port 22/Port 2121/' /etc/ssh/sshd_config
sed -i 's/#GatewayPorts no/GatewayPorts yes/' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/#X11Forwarding no/GatewayPorts yes/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart ssh

cat .ssh/id_rsa.pub | ssh lifailon@192.168.3.105 -p 2121 'cat >> .ssh/authorized_keys'
# Linux only
ssh-copy-id -i ~/.ssh/id_rsa -p 2121 lifailon@192.168.3.105
# Windows only
Get-Content "$env:USERPROFILE\.ssh\id_rsa.pub" | Set-Clipboard
cat "CTRL+V" > $HOME/.ssh/authorized_keys

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

sudo su
passwd

echo "lifailon ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/lifailon
```

### Timezone

```bash
timedatectl set-timezone 'Europe/Moscow'
timedatectl
```

### Packages

```bash
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y snapd auditd curl git jq fzf gdu bat fd-find micro

gdu
fzf --preview "batcat --color=always {}"
fdfind "\.yml" / | fzf

# ripgrep-all + rga-fzf
sudo apt install -y ripgrep
curl -sSL https://github.com/phiresky/ripgrep-all/releases/download/v0.10.10/ripgrep_all-v0.10.10-x86_64-unknown-linux-musl.tar.gz -o ripgrep.tar.gz
tar -xzf ripgrep.tar.gz
cp ripgrep_all-*/rga ripgrep_all-*/rga-fzf /usr/local/bin/
rm -rf ripgrep*

rga "fatal" /var/log/syslog*
rga-fzf

# TUI for kill
curl -sSL https://github.com/jacek-kurlit/pik/releases/download/0.28.1/pik-0.28.1-x86_64-unknown-linux-gnu.tar.gz -o pik.tar.gz
tar -xzf pik.tar.gz
cp pik-*/pik /usr/local/bin/
rm -rf pik*
pik

# TUI for logs
curl -sS https://raw.githubusercontent.com/Lifailon/lazyjournal/main/install.sh | bash

# TUI for systemd/systemctl
curl https://raw.githubusercontent.com/rgwood/systemctl-tui/master/install.sh | bash

snap install astral-uv --classic
uv tool install --python=3.11 isd-tui
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
isd

# TUI for SCP
curl --proto '=https' --tlsv1.2 -sSLf "https://git.io/JBhDb" | sh

# TUI for REST API
uv tool install --python 3.13 posting
posting
```

### Profile

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
ls ~/.oh-my-bash/themes/
sed -iE "s/^OSH_THEME=.*/OSH_THEME=powerline/" $HOME/.bashrc

git clone https://github.com/rockandska/fzf-obc $HOME/.local/opt/fzf-obc
echo "source $HOME/.local/opt/fzf-obc/bin/fzf-obc.bash" >> $HOME/.bashrc

curl https://hishtory.dev/install.py | python3 -

cat << 'EOF' >> ~/.bashrc
export HISTCONTROL=ignorespace
if [[ "$-" == *i* ]]; then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi
EOF

source $HOME/.bashrc
```

### Docker

```bash
sudo apt install docker.io -y
systemctl status docker

sudo usermod -aG docker $USER
newgrp docker

curl -sSL https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
curl -sSL https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-arm64 -o $HOME/.local/bin/ctop && chmod +x $HOME/.local/bin/ctop
```

### k3s

```bash
curl -sfL https://get.k3s.io | sh -
sudo kubectl get nodes

# Enable cgroups v1
sudo nano /boot/firmware/cmdline.txt
cgroup_enable=memory cgroup_memory=1
sudo reboot

# Get token on master
sudo cat /var/lib/rancher/k3s/server/node-token

# Install on worker
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.3.101:6443 K3S_TOKEN=K1032534c97598fcd9b7793efde55656502f3224b6480358a36d90ec9d1c9f80868::server:10541bad35b6d3cec46d46a19613232e sh -
```

### Compose

```bash
mkdir -p $HOME/.local/bin
version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
curl -sSL "https://github.com/docker/compose/releases/download/$version/docker-compose-$(uname -s)-$(uname -m)" -o $HOME/.local/bin/docker-compose
chmod +x $HOME/.local/bin/docker-compose
mkdir -p $HOME/.docker/cli-plugins
cp $HOME/.local/bin/docker-compose $HOME/.docker/cli-plugins/docker-compose
docker compose version
```

### 3x-ui

```bash
mkdir -p $HOME/docker/3x

cat << 'EOF' >> $HOME/docker/3x/docker-compose.yml
services:
  3x:
    image: ghcr.io/mhsanaei/3x-ui:latest
    container_name: 3x
    restart: always
    # ports:
    #   - 443:443   # VPN Xray VLESS
    #   - 2053:2053 # 3x Web UI
    network_mode: host
    tty: true
    environment:
      - XRAY_VMESS_AEAD_FORCED=false
      - XUI_ENABLE_FAIL2BAN=true
    volumes:
      - ./db/:/etc/x-ui/
      - ./cert/:/root/cert/
    logging:
      driver: journald
      options:
        tag: 3x
EOF

docker compose up -d

journalctl SYSLOG_IDENTIFIER=3x

openssl req -x509 -nodes -days 1825 -newkey rsa:2048 \
  -keyout /root/docker/3x/cert/private.key \
  -out /root/docker/3x/cert/public.crt \
  -subj "/CN=3x.docker.local"

# http://127.0.0.1:2053/panel/settings
# Panel port: 20533
# Panel certificate public key file path:  /root/cert/public.crt
# Panel certificate private key file path: /root/cert/private.key
```

Vless Settings:

Inbound:
- Remark: vless+reality
- Protocol: vless
- Port: 443
- Security: Reality
- uTLS: chrome
- Dest: www.microsoft.com:443
- SNI: www.microsoft.com
- Private Key: Get New Cert

WG Settings:

```bash
sysctl -w net.ipv4.ip_forward=1
sysctl -p
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
ufw allow 51318/tcp
ufw allow 51318/udp
```

### Firewall

```bash
ufw allow 22/tcp
ufw allow 443/tcp
ufw allow 443/udp
ufw allow 20533/tcp
ufw logging on
ufw enable
ufw status
ufw show listening
iptables -L ufw-user-input -n
```

### fail2ban

```bash
sudo apt install -y fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

cat << 'EOF' >> /etc/fail2ban/jail.local
[sshd]
enabled  = true
port     = 2121
logpath  = /var/log/auth.log
maxretry = 3
findtime = 10m
bantime  = 6h
EOF

fail2ban-client status sshd
iptables -L f2b-sshd -n

cat << 'EOF' > /etc/fail2ban/filter.d/3x.conf
[Definition]
failregex = ^.*wrong username:.*IP: "<HOST>".*$
EOF

cat << 'EOF' >> /etc/fail2ban/jail.local
[3x]
enabled      = true
port         = 20533
filter       = 3x
backend      = systemd
journalmatch = SYSLOG_IDENTIFIER=3x
maxretry     = 3
findtime     = 10m
bantime      = 1h
EOF

fail2ban-client reload
fail2ban-client status 3x
```

### Go

```bash
ARCH=$(uname -m) &&
case "$ARCH" in
    "aarch64" | "arm64") ARCH="arm64" ;;
    "x86_64"  | "amd64") ARCH="amd64" ;;
esac
LATEST_GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -1)
curl -L "https://go.dev/dl/${LATEST_GO_VERSION}.linux-${ARCH}.tar.gz" | sudo tar -xz -C /usr/local

echo 'export PATH="/usr/local/go/bin:$PATH"' >> ~/.bashrc
source $HOME/.bashrc

# TUI for ss
curl -sL https://raw.githubusercontent.com/v9mirza/lazyports/main/install.sh | bash

# TUI for SQL
go install github.com/jorgerojas26/lazysql@latest
```

### NPM

```bash
sudo apt install npm -y

# IDE style autocomplete for Shell
sudo npm install -g @microsoft/inshellisense
is init bash >> ~/.bashrc

# TUI for translate
sudo npm install -g multranslate
# TUI TOP
sudo npm install -g gtop
# TUI Docker
sudo npm install -g dockly
```

### PyPI

```bash
sudo apt install python3-pip

# TUI TOP
pip install glances
# Log Viewer
pipx install toolong
# Markdown Viewer
pip install frogmouth
```

### Ansible

```bash
add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
```