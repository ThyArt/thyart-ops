variable "aws_region" {
  default = "eu-west-1"
}

variable "ssh_public_key" {
  default = "~/.ssh/aws-eb.pub"
}

variable "application_name" {}