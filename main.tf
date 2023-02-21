provider "aws" {
  region = var.region
}

# VPC
data "aws_vpc" "rhel_vpc" {
  filter {
    name = "tag:Name"
    values = [ var.vpc_name ]
  }
}

# Subnet
data "aws_subnet" "inside" {
  filter {
    name   = "tag:Name"
    values = [ var.subnet_name ]
  }
}

# AMI

# aws ec2 describe-images --region ca-central-1 --image-ids ami-02e44367276fe7adc
data "aws_ami" "rhel9" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-9*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }


  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
  owners  = ["309956199498"] 
}
data "aws_ami" "rhel8" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-8*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
  owners  = ["309956199498"] 
}

# EC2
resource "aws_instance" "rhel9" {
  count                       = var.rhel9_host_count
  ami                         = data.aws_ami.rhel9.id
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  vpc_security_group_ids      = [ var.sg_id ]
  subnet_id                   = data.aws_subnet.inside.id
  associate_public_ip_address = false
  root_block_device {
    volume_size           = var.root_fs_size
    volume_type           = var.root_fs_type
    delete_on_termination = true
    encrypted             = true
  }
  tags = {
    Name = "${var.prefix}${count.index}"
  }
}

resource "aws_instance" "rhel8" {
  count                       = var.rhel8_host_count
  ami                         = data.aws_ami.rhel8.id
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  vpc_security_group_ids      = [ var.sg_id ]
  subnet_id                   = data.aws_subnet.inside.id
  associate_public_ip_address = false
  root_block_device {
    volume_size           = var.root_fs_size
    volume_type           = var.root_fs_type
    delete_on_termination = true
    encrypted             = true
  }
  tags = {
    Name = "${var.prefix}${count.index+var.rhel9_host_count}"
  }

}

###Output###
#Public IP
output "RHEL9" {
  value= aws_instance.rhel9.*.private_ip
  description = "The public IP address"
}
output "RHEL8" {
  value= aws_instance.rhel8.*.private_ip
  description = "The public IP address"
}
