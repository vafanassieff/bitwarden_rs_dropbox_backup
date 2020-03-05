#!/usr/bin/env sh

set -e

mkdir -p /tmp

sqlite3 ${DB_PATH} ".backup '/tmp/db.sqlite3'"

BACKUP_FILE="db.sqlite3_$(date "+%F-%H%M%S").tar.gz"

echo "Pushing backup to dropbox ..."
curl --silent -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
    --header "Dropbox-API-Arg: {\"path\": \"${DROPBOX_PATH}${BACKUP_FILE}\"}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @/tmp/${BACKUP_FILE}

echo \n
echo "Cleaning old backup ..."

rm -rf /tmp/*
