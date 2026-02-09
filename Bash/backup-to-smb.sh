#!/bin/bash
# apt install -y smbclient

BACKUP_DIR="/home/lifailon/docker/homepage"
SMB_PATH=//192.168.3.100/Backup
SMB_USER=Lifailon
SMB_PASS=

BACKUP_NAME=$(echo "$(basename "$BACKUP_DIR")-$(date +%d.%m.%Y-%H-%M).tar.gz")
tar -cz -C "$(dirname "$BACKUP_DIR")" "$(basename $BACKUP_DIR)" | dd of=/tmp/$BACKUP_NAME status=progress
# dd if=/tmp/$BACKUP_NAME status=progress | smbclient "$SMB_PATH" -U "$SMB_USER%$SMB_PASS" -c "put - $BACKUP_NAME"
smbclient "$SMB_PATH" -U "$SMB_USER%$SMB_PASS" -c "put /tmp/$BACKUP_NAME $BACKUP_NAME"
rm /tmp/$BACKUP_NAME