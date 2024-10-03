# Automatically backup database to s3 compatible Storage
Shell Script to Backup database to Aws S3 or DigitalOcean Automatically.

This script creates a dump of database on your server and backs it up to digitalocean spaces. You can also set it up as a cron to automatically backup periodically
**important** You must have s3cmd installed and configured for this script to work. 

What it does
 - ## Dump the database
 - ## Upload to DigitalOcean Spaces
 - ## Remove the backup file locally (optional)
 - ## Remove backups older than 3 days from the bucket


# Setup to dump 

- download `wget https://cdn.jsdelivr.net/gh/iqltechnologies/automatically-backup-database-to-cloud/backup_cron.sh`
- make executable `chmod +x backup_cron.sh`
- try run `./backup_cron.sh`
- get current directory path `pwd`


# Setup to dump automatically

open crontab in editor: 
- `crontab -e`
- add following line at last `0 0,6 * * * /current-directory-path/backup_cron.sh`
