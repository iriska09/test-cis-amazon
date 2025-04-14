# Packer template

# Define required plugins
packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

# Define variables for dynamic configuration
variable "subnet_id" {
  type        = string
  description = "The subnet ID for the EC2 instance."
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile for the EC2 instance."
}

variable "region" {
  type        = string
  description = "AWS region."
}

variable "source_ami" {
  type        = string
  description = "The source AMI ID."
}

# Define the source block for Amazon EBS
source "amazon-ebs" "al3-cis" {
  ami_name                = "al2023-cis-hardened-{{timestamp}}"
  ami_description         = "Amazon Linux 2023 with AWS CIS hardening"
  region                  = var.region
  instance_type           = "t4g.micro"
  ssh_username            = "ec2-user"
  source_ami              = var.source_ami
  subnet_id               = var.subnet_id
  associate_public_ip_address = true

  launch_block_device_mappings {
    device_name = "/dev/xvda"
    volume_size = 20
    volume_type = "gp3"
    delete_on_termination = true
  }
}

# Define build block
build {
  sources = ["source.amazon-ebs.al3-cis"]

  provisioner "shell" {
    script = "scripts/bootstrap.sh"
  }

  provisioner "ansible" {
    playbook_file = "ansible/playbook.yml"
    extra_arguments = ["--extra-vars", "ansible_python_interpreter=/usr/bin/python3"]
  }
}
