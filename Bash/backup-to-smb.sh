#!/bin/bash

# apk add samba-client coreutils
apt update && apt install -y smbclient

BACKUP_DIR="/backup/homepage"
SMB_PATH=//192.168.3.100/Backup
SMB_USER=Lifailon
SMB_PASS=
TELEGRAM_CHAT_ID=
TELEGRAM_API_KEY=

function tg-send() {
    msg="$1"
    msg=$(echo -e "$1\n\n*Source*: \`$BACKUP_DIR\`\n*Destination*: \`$SMB_PATH\`\n*Archive*: \`$BACKUP_NAME\`\n*Size*: $BACKUP_SIZE")
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_API_KEY/sendMessage" \
         -d "chat_id=$TELEGRAM_CHAT_ID" \
         -d "text=$msg" \
         -d "parse_mode=markdown"
}

BACKUP_NAME=$(echo "$(basename "$BACKUP_DIR")-$(date +%d.%m.%Y-%H-%M).tar.gz")
tar -cz -C "$(dirname "$BACKUP_DIR")" "$(basename $BACKUP_DIR)" | dd of=/tmp/$BACKUP_NAME status=progress
BACKUP_SIZE=$(du -h /tmp/$BACKUP_NAME | awk '{print $1}')
# dd if=/tmp/$BACKUP_NAME status=progress | smbclient "$SMB_PATH" -U "$SMB_USER%$SMB_PASS" -c "put - $BACKUP_NAME"
if smbclient "$SMB_PATH" -U "$SMB_USER%$SMB_PASS" -c "put /tmp/$BACKUP_NAME $BACKUP_NAME"; then
    tg-send "✅ *Backup successful*"
else
    tg-send "❌ *Backup error*"
fi
rm /tmp/$BACKUP_NAME