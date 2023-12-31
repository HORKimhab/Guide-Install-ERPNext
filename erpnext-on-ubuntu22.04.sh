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
