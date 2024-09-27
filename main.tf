# main.tf

# Create an AWS EC2 instance
resource "aws_instance" "Prod-server" {                                                  # Prod-Singapore-Prod-API
  ami                          = "ami-0ebfd941bbafe70c6"  # Replace with your desired AMI ID
  instance_type                =  var.instance_type        # Replace with your desired instance type
  subnet_id                    ="subnet-075f8de18e999dcad" # Avialibility Zone ap-southeast-1
vpc_security_group_ids = [
    "sg-0cba5ff6fb7a80237",
    # "sg-06ef6aef694c0f34e"    ## API and game dono me 2nd wala alag hai


    ]
  associate_public_ip_address  = true
key_name = "emmi"
  count         = var.instance_count
 # count = 0
    user_data = <<-EOF
    #cloud-config
    hostname: instance-${count.index}
    fqdn: instance-${count.index + 1}.example.com
    manage_etc_hosts: true

    runcmd:
      - hostnamectl set-hostname Prod-server-${count.index + 1}    ## Name change API or game. 
    EOF



tags = {

 Name = "Prod-server-${count.index + 1}"   ## Name change API or game.
    Environment = "Prod"
  }


root_block_device {
    volume_size = var.root_volume_size  # Replace with your desired root volume size in GB
    volume_type = "gp3"  # Replace with your desired root volume type
  }


  # iam_instance_profile = "aws-ec2-prod-role"
# Enable termination protection and stop protection
  #disable_api_termination = true



}

#output "Prod-server" {                               ## Name change API or game.
 # value = aws_instance.Prod-server[*].public_ip      ## Name change API or game.
#}
