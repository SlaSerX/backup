#!/bin/bash
# Version 1.0-alpha4 / 24th Feb, 2016
# Ivan Bachvarov a.k.a SlaSerX  /  Web: https://linuxhelps.net  / Email: slaserx@debian.bg
# This script creates FULL Backup of MySQL DB and Linux Server related DATA files.
# We can adjust it to do incremental basis backup too, but I based on my personnel experiences, I prefer to have FULL backup instead of incremental,
# Because you never know what you will going to need in case of disaster recovery
# Adjust below DATA fields accordingly. remove / add desired folders.

# Colors Config  . . . [[ . . . ]]
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"

# IF YOU HAVE FEDORA or CENTOS, Change the /var/www  to  /var/www/html/
b_dir="/backup/"
m_pass="password"
db="database"
set $(date)
time=`date |awk '{print $4}'`
clear

# What to backup.
backup_files="/etc /root"

# Where to backup to.
dest="/backup"

# Create archive filename.
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$6-$2-$3.tgz"

# Creating MYSQL dump of databases
echo "++++++++++++++++" > /var/log/fullbackup.log
echo Main Backup started at $6-$2-$3 Time $time >> /var/log/fullbackup.log
echo " " >> /var/log/fullbackup.log
echo " " >> /var/log/fullbackup.log
echo
echo "******************************** TAR - Compressing & MYSQL DUMP LOG *************" >> /var/log/fullbackup.log
echo -e "$COL_GREEN *********   Exporting MYSQL DUMP to $b_dir ... $COL_RESET"
echo "++++++++++++++++" >> /var/log/fullbackup.log
echo
echo "Mysql SQL export started at $6-$2-$3 Time $time" >> /var/log/fullbackup.log
mysqldump -u root -p$m_pass $db > $b_dir/mysql_db_full_$6-$2-$3.sql
echo "++++++++++++++++" >> /var/log/fullbackup.log
echo "Mysql SQL export ended at $6-$2-$3 Time $time" >> /var/log/fullbackup.log
echo "++++++++++++++++" >> /var/log/fullbackup.log
echo " " >> /var/log/fullbackup.log
echo " " >> /var/log/fullbackup.log


# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Backup the files using tar.
tar czf $dest/$archive_file $backup_files

# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest

# Print END time
echo MAIN Backup ended at $6-$2-$3 Time $time
echo MAIN Backup ended at $6-$2-$3 Time $time >> /var/log/fullbackup.log
echo
echo -e "$COL_GREEN *********  Backup completed to $SAVEDIR_FULL ... $COL_RESET"
echo
echo -e "$COL_RED Backup ended at $6-$2-$3 Time $time . . . $COL_RESET"
end_time=`date +%s`
echo
echo
echo " " >> /var/log/fullbackup.log
echo " " >> /var/log/fullbackup.log
echo " " >> /var/log/fullbackup.log
 
