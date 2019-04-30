variable "aws_region" {
  default = "eu-west-1"
}

variable "application_name" {}

variable "application_image" {
  image = "kkarczmarczyk/node-yarn:latest"
}
