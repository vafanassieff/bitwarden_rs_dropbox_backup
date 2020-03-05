FROM alpine:latest

LABEL maintainer="victor@afanassieff.com"

ENV CRON_BACKUP "0 1 * * *"
ENV DB_PATH "/db.sqlite3"
ENV DROPBOX_ACCESS_TOKEN ""
ENV DROPBOX_PATH="/"

RUN apk add --no-cache sqlite curl

COPY scripts /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["crond", "-f"]
