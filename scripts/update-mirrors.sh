#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

COUNTRY="Australia"
LATEST=20
FASTEST=10
PROTOCOL="https"
SORT="score"

EPOCH=$(date +%s)

echo "Updating mirrors for $COUNTRY..."

BACKUP_FILE="/etc/pacman.d/mirrorlist-$EPOCH.backup"

cp /etc/pacman.d/mirrorlist "$BACKUP_FILE"

if [ $? -ne 0 ]; then
  echo "Failed to create backup. Exiting."
  exit 1
fi

echo "Backup of current mirrorlist created at $BACKUP_FILE"

/usr/bin/reflector \
    --country "$COUNTRY" \
    --latest "$LATEST" \
    --fastest "$FASTEST" \
    --protocol "$PROTOCOL" \
    --sort "$SORT" \
    > /etc/pacman.d/mirrorlist

if [ $? -ne 0 ]; then
  echo "Failed to update mirrors."
  exit 1
fi
