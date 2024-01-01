
sudo apt-get update
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


