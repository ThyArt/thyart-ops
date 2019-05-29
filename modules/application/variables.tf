variable "application_name" {
  type        = "string"
  description = "The name of the ElasticBeanstalk application"
}

variable "aws_region" {
  type        = "string"
  description = "The default AWS region used for deployment"
}

variable "aws_availability_zones" {
  type        = "list"
  description = "The AWS Availability zones used for the creation of subnets"
}

variable "should_be_created" {
  type        = "string"
  description = "True if value should be created, false otherwise"
}