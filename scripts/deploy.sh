#!/bin/bash

# Update system
echo "Updating system..."
sudo dnf update -y

# Install Java
echo "Installing Java..."
sudo dnf install -y java-1.8.0-openjdk

# Install Redis
echo "Installing Redis..."
sudo dnf install -y redis
sudo systemctl enable redis
sudo systemctl start redis

# Install Filebeat
echo "Installing Filebeat..."
sudo dnf install -y filebeat
sudo systemctl enable filebeat
sudo systemctl start filebeat

# Install MySQL 8.0
echo "Installing MySQL 8.0..."
sudo dnf install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo dnf install -y mysql-community-server
sudo systemctl enable mysqld
sudo systemctl start mysqld

# Check installed services status
echo "Checking installed services status..."
sudo systemctl status redis
sudo systemctl status filebeat
sudo systemctl status mysqld

echo "Script execution completed."
