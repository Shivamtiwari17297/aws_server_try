#!/bin/bash

# Automatically set directory name via parameter or prompt
directory_name=${1:-$(read -p "Enter the target directory name: " dir && echo $dir)}  # Accepts as argument or prompt

# Define source and target directories
source_dir="/root/.terraform/Bigcash-Sin-Global/Master/"
target_dir="/root/.terraform/Bigcash-Sin-Global/Master/$directory_name"

# Ensure source directory exists
if [ ! -d "$source_dir" ]; then
  echo "Source directory '$source_dir' does not exist. Exiting."
  exit 1
fi

# Create target directory automatically if it doesn't exist
mkdir -p "$target_dir"
echo "Target directory '$target_dir' is ready."

# Copy and modify all Terraform files (main.tf, backend.tf, provider.tf, variables.tf)
for tf_file in main.tf backend.tf provider.tf variables.tf; do
  cp "$source_dir/$tf_file" "$target_dir/$tf_file"
  sed -i "s/Master/$directory_name/g" "$target_dir/$tf_file"
  echo "$tf_file has been updated for directory '$directory_name'."
done

# Initialize Terraform in the target directory
cd "$target_dir"
terraform init

# Plan and apply Terraform to launch server
terraform plan -out=tfplan
terraform apply -auto-approve tfplan

echo "Terraform setup and server launch for '$directory_name' completed successfully."

# (Optional) Filebeat installation steps
# Install Filebeat on the server
echo "Installing Filebeat..."
sudo yum install -y filebeat

# Start and enable Filebeat
sudo systemctl start filebeat
sudo systemctl enable filebeat

# Verify Filebeat installation
filebeat --version

echo "Filebeat installed and running."
