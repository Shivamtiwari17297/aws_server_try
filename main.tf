provider "aws" {
  region = "ap-south-1"
}
# Variables for existing resources
variable "vpc_id" {
  description = "ID of the existing VPC"
  default     = "vpc-0668fbb3151d6ccfb"  # Replace with your existing VPC ID
}

variable "subnet_a_id" {
  description = "ID of the existing subnet A"
  default     = "subnet-0d4f7782aa963e139"  # Replace with your existing subnet A ID
}

variable "subnet_b_id" {
  description = "ID of the existing subnet B"
  default     = "subnet-07c4dabc611589b3b"  # Replace with your existing subnet B ID
}

variable "security_group_instance_id" {
  description = "ID of the existing Instance Security Group"
  default     = "sg-0bbc16fd865554ca4"  # Replace with your existing Instance Security Group ID
}

variable "igw_id" {
  description = "ID of the existing Internet Gateway"
  default     = "igw-0e856426e586413e3"  # Replace with your existing Internet Gateway ID
}

variable "route_table_id" {
  description = "ID of the existing Route Table"
  default     = "rtb-0ebc17e17d7431aed"  # Replace with your existing Route Table ID
}

variable "key_name" {
  description = "Name of the existing SSH key pair"
  default     = "emmi"  # Replace with your key pair name
}

# Launch  instance
resource "aws_instance" "servers" {
  ami           = "ami-08718895af4dfa033"  # Replace with your desired ARM-compatible AMI ID
  instance_type = "t3.micro"
  subnet_id     = var.subnet_a_id
  security_groups = [var.security_group_instance_id]
  key_name       = var.key_name

  # Note: We are not specifying a root_block_device configuration here as
  # we assume you will add the EBS volume via the AWS Console.

  tags = {
    Name = "servers"
  }
}

# Route Table Associations
resource "aws_route_table_association" "rta_b" {
  subnet_id      = var.subnet_b_id
  route_table_id = var.route_table_id
}

resource "aws_route_table_association" "rta_a" {
  subnet_id      = var.subnet_a_id
  route_table_id = var.route_table_id
}
