#!/usr/bin/env sh

set -e

mkdir -p /tmp

sqlite3 ${DB_PATH} ".backup '/tmp/db.sqlite3'"

if [ -n "${NO_INCREMENT}" ]; then
    BACKUP_FILE="db.sqlite3.tar.gz"
else
    BACKUP_FILE="db.sqlite3_$(date "+%F-%H%M%S").tar.gz"
fi

cd /tmp
tar -czvf ${BACKUP_FILE} ./db.sqlite3

echo "Uploading ${BACKUP_FILE} to dropbox ..."

echo "Pushing backup to dropbox ..."
curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization: Bearer ${DROPBOX_ACCESS_TOKEN}" \
    --header "Dropbox-API-Arg: {\"path\": \"${DROPBOX_PATH}${BACKUP_FILE}\", \"mode\": \"overwrite\"}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @/tmp/${BACKUP_FILE}

echo "Cleaning old backup ..."

rm -rf /tmp/*
