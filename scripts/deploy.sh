#!/bin/bash

# Update system
echo "Updating system..."
sudo yum update -y

# Install Java
echo "Installing Java..."
sudo amazon-linux-extras install java-openjdk11 -y

# Install Redis
echo "Installing Redis..."
sudo amazon-linux-extras install redis4.0 -y
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
sudo yum install -y filebeat
sudo systemctl enable filebeat
sudo systemctl start filebeat

# Install MySQL 8.0
echo "Installing MySQL 8.0..."
sudo yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo yum install -y mysql-community-server
sudo systemctl enable mysqld
sudo systemctl start mys
