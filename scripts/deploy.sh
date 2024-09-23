#!/bin/bash

# Update system
echo "Updating system..."
sudo dnf update -y

# Install Java
echo "Installing Java..."
sudo dnf install -y java-11-openjdk

# Install Redis
echo "Installing Redis..."
sudo dnf install -y redis
sudo systemctl enable redis
sudo systemctl start redis

# Install Filebeat
echo "Installing Filebeat..."
sudo tee /etc/yum.repos.d/elastic-7.x.repo <<EOL
[elastic-7.x]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
enabled=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
EOL
sudo dnf install -y filebeat
sudo systemctl enable filebeat
sudo systemctl start filebeat

# Install MySQL 8.0
echo "Installing MySQL 8.0..."
sudo dnf install -y https://dev.mysql.com/get/mysql80-community-release-el8-3.noarch.rpm
sudo dnf install -y mysql-community-server
sudo systemctl enable mysqld
sudo systemctl start mysqld

# Check installed services status
echo "Checking installed services status..."
sudo systemctl status redis
sudo systemctl status filebeat
sudo systemctl status mysqld
