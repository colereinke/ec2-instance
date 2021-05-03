resource "aws_instance" "default" {
  ami                         = var.ami
  instance_type               = var.instance_type
  ebs_optimized               = true
  disable_api_termination     = var.termination_protection
  user_data                   = var.user_data

  associate_public_ip_address = var.public_ip_address
  key_name                    = var.ssh_key_pair
  subnet_id                   = var.subnet
  monitoring                  = var.detailed_monitoring

  vpc_security_group_ids = [(var.security_groups != "" ? var.security_groups : aws_security_group.default.id)]

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    delete_on_termination = var.delete_on_termination
    encrypted             = var.root_block_device_encrypted
    tags = var.tags
  }

  tags = var.tags
}
