#!/bin/bash

# Variables
USERNAME="frappe1"
FULLNAME="Frappe1"
HOMEDIR="/home/$USERNAME"
siteERPNext1="erpnext11.seksaaacademy.com"

echo "Install ERPNext 11 on Ubuntu 20.04"

# Set time zone
sudo timedatectl set-timezone "Asia/Phnom_Penh"

# Update and upgrade system
sudo apt update -y && sudo apt upgrade -y

# ---Start: Create a user

# Create user without giving password 
sudo adduser --gecos "$FULLNAME" --disabled-password --home "$HOMEDIR" "$USERNAME"

# Set password, if new and confirm password not match, input it again till match
while true; do
    read -s -p "Enter the desired password for $USERNAME: " NEW_PASSWORD
    echo
    read -s -p "Confirm password: " CONFIRM_PASSWORD
    echo

    if [ "$NEW_PASSWORD" == "$CONFIRM_PASSWORD" ]; then
        echo "Password successfully set."
        sudo passwd "$USERNAME" <<< "$NEW_PASSWORD" # Password check in general doc
        contine
    else
        echo "Passwords do not match. Please try again."
    fi
done

# Check if the password change was successful
if [ $? -eq 0 ]; then
    echo "Password successfully set."
else
    echo "Error: Password set failed."
    exit 1
fi

# Add user to sudo group (if needed)
sudo usermod -aG sudo "$USERNAME"

su - "$USERNAME"
cd "$HOMEDIR"

# ---End: Create a user

# Install Required pacakages

# Install git 
sudo apt install git -y 

# Add all pacakage python 
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update && sudo apt install curl -y

# Install prerequisites
# Install Python 3.5 and related packages
sudo apt install python3.5 python3.5-dev python3.5-minimal 

# Install pip for Python3.5 
curl https://bootstrap.pypa.io/pip/3.5/get-pip.py -o get-pip.py
sudo python3.5 get-pip.py

sudo pip3.5 install setuptools

sudo apt install python3.5-venv 
#  python3.5-pip Done 

# install Software Properties Common 
sudo apt install software-properties-common -y 

# Install MariaDB (MYSQL server)
sudo apt install mariadb-server mariadb-client -y 

# Install Redis Server 
sudo apt install redis-server -y 

# Install other necessary pacakges (for fonts, PDFS and etc)
sudo apt install xvfb libfontconfig wkhtmltopdf -y && sudo apt install libmysqlclient-dev -y

# Configure MYSQL Server
sudo sudo mysql_secure_installation

# Root Password: rootsame45

# Backup and Customize /etc/mysql/my.cnf 
cp /etc/mysql/my.cnf /etc/mysql/my.cnf-bak

echo "------------Add the below code block at the bottom of the file /etc/mysql/my.cnf------------"
echo "[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci

[mysql]
default-character-set = utf8mb4"
echo "------------++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------"

# Customize /etc/mysql/my.cnf 
sudo nano /etc/mysql/my.cnf 

# Restart MySQL Server 
sudo systemctl restart mysql

# Install Node, NPM and Yarn 
# Install Node.js
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install nodejs -y 

# Fix Install yarn 
## You may also need development tools to build native addons:
sudo apt-get install gcc g++ make

## To install the Yarn package manager, run:
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
# --- Fix Install yarn 

# Fix Install npm 
# Use nvm nodejs manager 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash



# --- Fix Install npm 

# Install frappe bench
sudo pip3 install frappe-bench
bench init frappe-bench --frappe-branch version-11

cd /frappe-bench 

chmod -R o+rx "$HOMEDIR/"

bench new-site "$siteERPNext1"

# Install ERPNext Version 11 
bench get-app --branch version-11 erpnext 

# Install all the apps 
bench --site "$siteERPNext1" install-app erpnext 

# Setupt Production Server 

# Enable scheduler service 
bench --site "$siteERPNext1" enable-scheduler

# Disable maintenance mode
bench --site "$siteERPNext1" set-maintenance-mode off

# Setup production config
sudo bench setup production "$USERNAME" 

# Setup NGINX web server
bench setup nginx

# Finsal server setup 
sudo supervisorctl restart all
sudo bench setup production "$USERNAME" 

echo "Ref: https://discuss.frappe.io/t/guide-how-to-install-erpnext-v14-on-linux-ubuntu-step-by-step-instructions/92960" 