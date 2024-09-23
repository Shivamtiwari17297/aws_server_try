#!/bin/bash

# Update system
echo "Updating system..."
sudo apt update -y && sudo apt upgrade -y

# Install Java
echo "Installing Java..."
sudo apt install -y openjdk-8-jdk

# Install Redis
echo "Installing Redis..."
sudo apt install -y redis-server
sudo systemctl enable redis-server
sudo systemctl start redis-server

# Install Filebeat
echo "Installing Filebeat..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo sh -c 'echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" > /etc/apt/sources.list.d/elastic-7.x.list'
sudo apt update -y
sudo apt install -y filebeat
sudo systemctl enable filebeat
sudo systemctl start filebeat

# Install MySQL 8.0
echo "Installing MySQL 8.0..."
wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.22-1_all.deb
sudo apt update -y
sudo apt install -y mysql-server
sudo systemctl enable mysql
sudo systemctl start mysql

# Check installed services status
echo "Checking installed services status..."
sudo systemctl status redis-server
sudo systemctl status filebeat
sudo systemctl status mysql

echo "Script execution completed."
