variable "name" {
}
variable "ami" {
}
variable "instance_type" {
  default = "t3.micro"
}
variable "termination_protection" {
  default = true
}
variable "user_data" {
    default = null
}
variable "instance_profile" {
    default = null
}
variable "public_ip_address" {
  default = false
}
variable "ssh_key_pair" {
    default = null
}
variable "vpc_id" {
  
}
variable "security_group_rules" {
  default = null
}
variable "subnet" {}
variable "detailed_monitoring" {
  default = false
}
variable "security_groups" {
    default = ""
}
variable "root_volume_size" {
  default = 10
}
variable "delete_on_termination" {
  default = true
}
variable "root_block_device_encrypted" {
  default = true
}
variable "tags" {
  
}

variable = "user_data{
  default = ""
}
