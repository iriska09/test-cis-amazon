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
