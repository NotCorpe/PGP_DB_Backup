#!/bin/bash

# Database credentials
DB_USER="your_database_user"
DB_PASSWORD="your_database_password"
DB_NAME="your_database_name"

# Email credentials
EMAIL_FROM="your_email@example.com"
EMAIL_TO="recipient@example.com"
EMAIL_SUBJECT="Database Backup"
EMAIL_BODY="Please find the attached database backup."

# PGP key
PGP_KEY="recipient_pgp_key"

# Backup file name
BACKUP_FILE="/tmp/$DB_NAME-backup-$(date +%Y%m%d%H%M).sql"

# Log file name
LOG_FILE="/var/log/db_backup.log"

# Create backup
echo "Creating backup..." >> $LOG_FILE
pg_dump -U $DB_USER -F c $DB_NAME > $BACKUP_FILE
if [ $? -ne 0 ]; then
    echo "Backup failed" >> $LOG_FILE
    echo "Backup failed" | mail -s "Database Backup Failed" $EMAIL_TO
    exit 1
fi

# Encrypt backup
echo "Encrypting backup..." >> $LOG_FILE
gpg --output $BACKUP_FILE.gpg --encrypt --recipient $PGP_KEY $BACKUP_FILE
if [ $? -ne 0 ]; then
    echo "Encryption failed" >> $LOG_FILE
    echo "Encryption failed" | mail -s "Database Backup Failed" $EMAIL_TO
    exit 1
fi

# Send email
echo "Sending email..." >> $LOG_FILE
mutt -a $BACKUP_FILE.gpg -s "$EMAIL_SUBJECT" -- $EMAIL_TO <<EOF
$EMAIL_BODY
EOF
if [ $? -ne 0 ]; then
    echo "Email failed" >> $LOG_FILE
    echo "Email failed" | mail -s "Database Backup Failed" $EMAIL_TO
    exit 1
fi

# Remove backup files
echo "Removing backup files..." >> $LOG_FILE
find /tmp -name "$DB_NAME-backup-*.sql*" -mtime +7 -exec rm {} \;
