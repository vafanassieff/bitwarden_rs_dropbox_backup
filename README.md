# bitWarden_rs Dropbox Backup
Run this image alongside your bitwarden_rs container for automated nightly (1AM UTC) backups of your BitWarden database to your Dropbox account.

## How to Use
- It's highly recommend you run via the `docker-compose.yml` provided.
- Pre-built images are available at `vafanassieff/bitwarden_rs_dropbox`.
- A `DROPBOX_ACCESS_TOKEN` access token will be needed to upload to your Dropbox account.
- To run backups on a different interval/time, modify the `Dockerfile` and build a custom image.
- This image will always run an extra backup on container start (regardless of cron interval) to ensure your setup is working.

| Env | Function | Default Value |
| :----: | --- | --- |
| `CRON_BACKUP` | Backup frequency | `0 1 * * *`
| `DB_PATH` | sqlite db path in container | `/data/db.sqlite3`
| `DROPBOX_ACCESS_TOKEN` | dropbox access token | `None`
| `DROPBOX_PATH` | path in the dropbox folder | `/`
| `NO_INCREMENT` | Increment file wit date | `None`

### Generating Dropbox Access Token
1. Visit: https://www.dropbox.com/developers/apps
2. Click on "Create App", then select "Dropbox API App".
4. Complete configuration and pick an app name (e.g. MyVaultBackups).
6. Once your app is created, click the Generate button under 'Generated access token'.
7. This token should be provided to the container as `DROPBOX_ACCESS_TOKEN` env var.


### Restoring Backup to BitWarden_RS
Volume mount the decrypted `.sqlite3` file to your bitwarden_rs container. Done!
