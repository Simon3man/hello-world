#!/bin/bash
# Script to Backup the Database

# Recieve ans Store System Time for future use
Date=`date +%Y%m%d_%H%M%S`

# Concatonate DateTimestamp into a SQL suffix
Backupfile=$Date.sql

# Concatonae DateTimestamp SQL Suddix into a file compression Suffix 
Zipbackupfile=$Date.sql.gz

# Initiate MySQL dump to initalize the Backup Proccess
mysqldump -uroot -padmin moodle> /home/ubuntu/$Backupfile

echo "$Date"
echo "$Backupfile"

# Compressing the MySQL dump backup file
mysqldump -uroot -padmin moodle | gzip> /home/ubuntu/$Zipbackupfile

# Delete the Backup File as it is compressed already
sudo rm /home/ubuntu/$Backupfile

# Delete the backup files that are more than 3 minutes old to prevent overflow of backup files
find /home/ubuntu -mmin +3 -name "*.sql.gz" -exec rm {} \;


#find ~/ -mmin +3 -name "*.sql.gz" -exec rm {} \;


# Output for the Logs
echo "File Backed up and backups sweeped!" | sudo tee -a /home/ubuntu/dbBackup.log
