#!/bin/sh

set -e

if [ -z "${DROPBOX_ACCESS_TOKEN}" ]; then
    echo "Dropbox token not set ..."
    exit
fi

if [ -n "${NO_INCREMENT}" ]; then
    echo "Only the last version of backup will exist"
fi

echo "Installing crontab ... ${CRON_BACKUP}"
echo "${CRON_BACKUP} /backup.sh" > /etc/crontabs/root

/backup.sh

exec "$@"
