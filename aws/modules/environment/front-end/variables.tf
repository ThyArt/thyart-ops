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

variable "certificate_name" {
  type        = "string"
  description = "The IAM certificate name used for https"
}

variable "environment_cname" {
  type        = "string"
  description = "The CNAME used for the environment"
}