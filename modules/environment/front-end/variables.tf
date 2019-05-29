variable "application_name" {
  type        = "string"
  description = "The ElasticBeanstalk application name"
}

variable "stage" {
  type        = "string"
  description = "The stage of the environment"
}

variable "route53_zone_name" {
  type        = "string"
  description = "The AWS Route53 zone name used to access the environment"
}
variable "vpc_id" {
  type        = "string"
  description = "The AWS VPC id"
}

variable "public_subnet_ids" {
  type        = "list"
  description = "The AWS public subnets which belong to the previous VPC"
}
variable "private_subnet_ids" {
  type        = "list"
  description = "The AWS private subnets which belong to the previous VPC"
}

variable "should_be_created" {
  type        = "string"
  description = "True if value should be created, false otherwise"
}