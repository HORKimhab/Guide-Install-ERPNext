#!/bin/bash

# Variables
USERNAME="frappe"
FULLNAME="Frappe"
HOMEDIR="/home/$USERNAME"

echo "Install ERPNext on Ubuntu 22.04"

# Set time zone
sudo timedatectl set-timezone "Asia/Phnom_Penh"

# Update and upgrade system
sudo apt update -y && sudo apt upgrade -y

# ---Start: Create a user

# Create user without giving password 
sudo adduser --gecos "$FULLNAME" --disabled-password --home "$HOMEDIR" "$USERNAME"

# Set password
sudo passwd "$USERNAME" # Password check in general doc

# Add user to sudo group (if needed)
sudo usermod -aG sudo "$USERNAME"

su - "$USERNAME"
cd "$HOMEDIR"

# ---End: Create a user

# Add all pacakage python 
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt udpate -y 

# Install Python 3.4 and development pacakages
sudo apt install python3.5 python3.5-dev

# Install required dependencies
sudo apt install -y python3.5 python3-pip build-essential python3-setuptools
# sudo apt install -y libffi-dev libssl-dev libmysqlclient-dev libjpeg8-dev liblcms2-dev libblas-dev libatlas-base-dev
sudo apt install -y nodejs npm
sudo apt install -y wkhtmltopdf
sudo apt install -y redis-server mariadb-server

sudo apt-get install git python3-setuptools python3-pip virtualenv mariadb-server mariadb-client libmariadb-dev redis-server nodejs yarn wkhtmltopdf

sudo apt install -y python3.5 python3-pip build-essential python3-setuptools

# Install Node.js
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

# Install wkhtmltopdf
sudo apt install -y wkhtmltopdf

# Install ERPNext version 11
sudo pip3 install frappe-bench


# Create a MariaDB Database and User
sudo mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE erpnext;
CREATE USER 'erpnext'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON erpnext.* TO 'erpnext'@'localhost';
FLUSH PRIVILEGES;
EXIT;
MYSQL_SCRIPT

# Install ERPNext
sudo pip3 install frappe-bench
bench init frappe-bench --frappe-branch version-13
cd frappe-bench
bench new-site your.site.name
bench --site your.site.name install-app erpnext

# Start ERPNext
bench start
