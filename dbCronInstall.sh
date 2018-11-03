# Script to Initialize and Install Database ready for connection
#sudo wget -O dbInstall.sh https://raw.githubusercontent.com/kei-k/2018_Group11/master/Assignment2/DBInstall.sh?token=AEBP-uhcnt8iUA_qVLLGl_rZgW6WYhw7ks5bvq-cwA%3D%3D
#sudo bash ./DBInstall.sh

echo "================================================="
echo "mySQL Installing ........"
echo "================================================="

# Install mysql
# State all forms to be filled automatically by shell script when prompted by the installation process
echo "mysql-server mysql-server/admin-user string root" | debconf-set-selections
echo "mysql-server mysql-server/root_password password admin" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password admin" | debconf-set-selections

#Install MySQL-Server
sudo apt-get install mysql-server -y

 # Accessing and Logging In MySQL
sudo -S mysql -u root -padmin <<EOF
CREATE DATABASE moodle DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci; 
create user 'moodler'@'%' IDENTIFIED BY 'moodlerpassword'; 
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON moodle.* TO 'moodler'@'%' IDENTIFIED BY 'moodlerpassword';
exit
EOF

 # Change the MySQL Server configuration file
sudo sed -i '43d' /etc/mysql/mysql.conf.d/mysqld.cnf

echo "================================================="
echo "mySQL Installed!"
echo "================================================="


echo "Installing Cron-----------------------------------"

# The backup cron job initialization and installation of files pertaining to the backup system and script
# Start a scripts depository in the /var/ folder

# Recieve the script intended to commit the backups in a regular interval whilst removing sufficiently older ones
#sudo wget -O test.sh https://raw.githubusercontent.com/kei-k/2018_Group11/master/Assignment2/test.sh?token=AEBP-t0y8dt7lb2tO0f_4iRhcOzzC8rGks5bvp3RwA%3D%3D
#sudo wget -O backup.sh https://raw.githubusercontent.com/kei-k/2018_Group11/master/Assignment2/dbbackup.sh?token=AEBP-lYdag8qiNONFox214Yrrx4dwwt4ks5bvqRhwA%3D%3D
#sudo bash ./dbbackup.sh

# Move the downloaded script to the scripts folder
#sudo mv test.sh /var/scripts/


# Modify the permissions to allow for univeral user execution of script to allow for crons and user to execute
#sudo chmod +x /var/scripts/test.sh


echo "this is a log file" > /home/ubuntu/dbBackup.log

# Add the cron to the system
#(crontab -l 2>/dev/null; echo "1 * * * * /bin/sh /var/scripts/backup.sh >> /tmp/dbBackup.log") | crontab -
#(crontab -l 2>/dev/null; echo "*/1 * * * * /bin/sh /var/scripts/test.sh >> /tmp/test.log") | crontab -
echo "*/1 * * * * ubuntu bash /home/ubuntu/dbbackup.sh" | sudo tee -a /etc/crontab


echo "Cron Installed-----------------------------------"
