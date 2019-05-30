variable "application_name" {
  type        = "string"
  description = "The ElasticBeanstalk application name"
}

variable "aws_region" {
  type        = "string"
  description = "The default AWS region used for deployment"
}

variable "aws_availability_zones" {
  type        = "list"
  description = "The AWS Availability zones used for the creation of subnets"
}