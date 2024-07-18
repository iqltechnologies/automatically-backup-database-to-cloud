#!/bin/bash

# Fill Your Variables
DB_NAME=""
DB_USER=""
DB_PASSWORD=""
BACKUP_DIR="/home/backup/"
CURRENT_DATE=$(date +\%F)
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_$(date +\%F_\%H-\%M).sql"
S3_BUCKET="s3://bucketname/backup/"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Dump the database
mysqldump -u $DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_FILE

# Upload to DigitalOcean Spaces
s3cmd put $BACKUP_FILE $S3_BUCKET

# Remove the backup file locally (optional)
rm $BACKUP_FILE



# Remove backups older than 3 days from the bucket
THREE_DAYS_AGO=$(date -d '3 days ago' +%F)
s3cmd ls $S3_BUCKET | grep "${DB_NAME}_" | while read -r line; do
    FILE_DATE=$(echo $line | awk '{print $1}' | cut -d 'T' -f 1)
    FILE_NAME=$(echo $line | awk '{print $4}')
    if [[ "$FILE_DATE" < "$THREE_DAYS_AGO" ]]; then
        s3cmd del $FILE_NAME
    fi
done
