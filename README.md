# Encrypted and Externally Stored PostgreSQL Database Backup Script

This Bash script is designed to backup a PostgreSQL database, encrypt it using PGP, and store it externally to protect against ransomware attacks. The script also sends an email notification with the backup file as an attachment.

## Features

- Automatically backs up a PostgreSQL database
- Encrypts the backup using PGP
- Stores the backup externally to protect against ransomware attacks
- Sends an email notification with the backup file as an attachment
- Includes error handling, logging, and email notifications
- Implements a retention policy for backup files

## Prerequisites

- PostgreSQL
- GnuPG (GPG)
- Mutt or another email client

## Usage

1. Replace the placeholders in the script with your own values.
2. Make the script executable with `chmod +x db_backup.sh`.
3. Schedule the script to run using a cron job. For example, to run the script every night at 2 AM, add the following line to your crontab:

```bash 0 2 * * * /path/to/your/script/db_backup.sh ```

Replace `/path/to/your/script/db_backup.sh` with the actual path to your script.

## Notes

- This script is basic and may require modifications to meet your specific needs and environment.
- This script does not handle all possible errors. You may want to add additional error handling to ensure that the script fails gracefully if any commands fail.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

