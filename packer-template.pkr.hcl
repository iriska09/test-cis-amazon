# packer {
#   required_plugins {
#     amazon = {
#       version = ">= 1.0.0"
#       source  = "github.com/hashicorp/amazon"
#     }
#     ansible = {
#       version = ">= 1.0.0"
#       source  = "github.com/hashicorp/ansible"
#     }
#   }
# }

# # variable "subnet_id" {}
# # variable "iam_instance_profile" {}
# # variable "region" {}
# # variable "source_ami" {}

# source "amazon-ebs" "al3-cis" {
#   ami_name                = "al2023-cis-hardened-{{timestamp}}"
#   ami_description         = "Amazon Linux 2023 with AWS CIS hardening"
#   region                  = var.region
#   instance_type           = "t4g.micro"
#   ssh_username            = "ec2-user"
#   source_ami              = var.source_ami
#   subnet_id               = var.subnet_id
#   associate_public_ip_address = true

#   launch_block_device_mappings {
#     device_name = "/dev/xvda"
#     volume_size = 20
#     volume_type = "gp3"
#     delete_on_termination = true
#   }
# }

# build {
#   sources = ["source.amazon-ebs.al3-cis"]

#   provisioner "shell" {
#     script = "scripts/bootstrap.sh"
#   }

#   provisioner "ansible" {
#     playbook_file = "ansible/playbook.yml"
#     extra_arguments = ["--extra-vars", "ansible_python_interpreter=/usr/bin/python3"]
#   }
# }
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
