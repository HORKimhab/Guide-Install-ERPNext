#!/bin/bash

# Variables
USERNAME="frappe4"
FULLNAME="Frappe4"
HOMEDIR="/home/$USERNAME"

echo "Install ERPNext on Ubuntu 22.04"

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
        break
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
