provider "aws" {
  region = "us-east-1"
}

# Variables for existing resources
variable "vpc_id" {
  description = "ID of the existing VPC"
  default     = "vpc-07237fbcbcdc537d1"  # Replace with your existing VPC ID
}

variable "subnet_a_id" {
  description = "ID of the existing subnet A"
  default     = "subnet-0d55ec792478c3859"  # Replace with your existing subnet A ID
}

variable "subnet_b_id" {
  description = "ID of the existing subnet B"
  default     = "subnet-0a575292cd2727788"  # Replace with your existing subnet B ID
}

variable "security_group_instance_id" {
  description = "ID of the existing Instance Security Group"
  default     = "sg-02d92909948cffb2b"  # Replace with your existing Instance Security Group ID
}

variable "igw_id" {
  description = "ID of the existing Internet Gateway"
  default     = "igw-081c4bc2419fe9ce7"  # Replace with your existing Internet Gateway ID
}

variable "route_table_id" {
  description = "ID of the existing Route Table"
  default     = "rtb-08a6a402509fad8e5"  # Replace with your existing Route Table ID
}

variable "key_name" {
  description = "Name of the existing SSH key pair"
  default     = "tests"  # Replace with your key pair name
}

# Launch  instance
resource "aws_instance" "test-server" {
  ami           = "ami-037774efca2da0726"  # Replace with your desired ARM-compatible AMI ID
  instance_type = "t3.medium"
  subnet_id     = var.subnet_a_id
  security_groups = [var.security_group_instance_id]
  key_name       = var.key_name

  # Note: We are not specifying a root_block_device configuration here as
  # we assume you will add the EBS volume via the AWS Console.

  tags = {
    Name = "test-server"
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
