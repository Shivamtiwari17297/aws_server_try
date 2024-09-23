#!/bin/bash

# Update the system
echo "Updating system..."
sudo dnf update -y

# Install Java (OpenJDK 11)
echo "Installing Java..."
sudo dnf install java-11-openjdk -y

# Install Redis
echo "Installing Redis..."
sudo dnf install redis -y
sudo systemctl enable redis
sudo systemctl start redis

# Install Filebeat
echo "Installing Filebeat..."
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
sudo dnf install https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.16.2-x86_64.rpm -y

# Enable and start Filebeat
sudo systemctl enable filebeat
sudo systemctl start filebeat

# Install MySQL 8.0
echo "Installing MySQL 8.0..."
sudo dnf install mysql-server -y
sudo systemctl start mysqld
sudo systemctl enable mysqld

# Check installed services
echo "Checking installed services status..."
sudo systemctl status mysqld redis filebeat

echo "Script execution completed."
