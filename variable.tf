# variable.tf

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t3.medium"
}

#variable "instance_name" {
 # description = "The name of the EC2 instance"
 # type        = string
  #default     = "bigsport-instance"
#}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 8
}

#variable "instance_hostname" {
  #description = "Hostname for the EC2 instance"
  #stype        = string
 # default     = "example-hostname"
#}

variable "instance_count" {
  description = "Number of AWS instances to create"
  type        = number
  default     = 1
}
