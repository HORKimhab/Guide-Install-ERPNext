#!/bin/bash

# install erpnext 11 on ubuntu 20.4 minimal with python 3.6 
sudo apt update
sudo apt install software-properties-common -y

# Install python 3.6 
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.6 python3.6-dev -y

# Set Python3.6 as the Default Python
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
sudo update-alternatives --config python3

# Install Dependencies
sudo apt-get install build-essential libssl-dev libffi-dev libmysqlclient-dev libjpeg8-dev zlib1g-dev libldap2-dev python3.6-pip git -y

# Create a Frappe User 
sudo adduser frappe #Password: frappesame45 
sudo usermod -aG sudo frappe

# Switch to the Frappe User 
sudo su - frappe 

# Install pip3.6 
sudo apt-get install python3.6-distutils
curl https://bootstrap.pypa.io/pip/3.6/get-pip.py -o get-pip.py
sudo python3.6 get-pip.py
sudo -H pip3 install --upgrade pip

sudo -H python3.6 -m pip install --upgrade pip setuptools


# ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behaviour is the source of the following dependency conflicts.
# launchpadlib 1.10.13 requires testresources, which is not installed.

# Install ERPNext 

sudo apt-get install -y python3 python3-pip mariadb-server redis-server nodejs npm

sudo apt-get install -y libxrender1 libxext6
sudo wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
sudo dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb
sudo apt-get install -f -y
sudo apt install python3.8-venv

# Configure MYSQL Server
sudo mysql_secure_installation

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

# Fix install yarn support erpnext version 11 
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install yarn
yarn --version


# --- Fix install yarn support erpnext version 11 


cd ~  # Change to your home directory or another directory where you have write permissions
sudo pip3 install frappe-bench
# bench init frappe-bench --frappe-branch version-11
pip3 install jinja2==3.0.3

# Downloading Jinja2-3.1.2-py3-none-any.whl (133 kB)
#      |████████████████████████████████| 133 kB 41.3 MB/s 
# ERROR: frappe-bench 5.19.0 has requirement jinja2~=3.0.3, but you'll have jinja2 3.1.2 which is incompatible.

bench init --frappe-branch version-11 frappe-bench


