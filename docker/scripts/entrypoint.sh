#!/bin/sh

set -e

if [ -z "${DROPBOX_ACCESS_TOKEN}" ]; then
    echo "Dropbox token not set ..."
    exit
fi

echo "Installing crontab ... ${BACKUP_CRON}"
echo "${BACKUP_CRON} /backup.sh" > /etc/crontabs/root

/backup.sh

exec "$@"
