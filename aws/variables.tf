/* Providers */
variable "aws_region" {
  type        = "string"
  description = "The default AWS region used for deployment"
  default     = "eu-west-1"
}

variable "route53_zone_name" {
  type        = "string"
  description = "The AWS Route53 zone name used to access all environments"
  default     = "thyart.fr"
}

variable "aws_availability_zones" {
  type        = "list"
  description = "The AWS Availability zones used for the creation of subnets"
  default = [
    "eu-west-1a",
    "eu-west-1b",
    "eu-west-1c"
  ]
}

variable "acme_registration_email" {
  type        = "string"
  description = "Email address used for ACME registration"
}

/* Back-end */
variable "back_end_application_name" {
  type        = "string"
  description = "The AWS elasticbeansalk application name for the back-end"
  default     = "thyart-api"
}

/* Front-end */
variable "front_end_application_name" {
  type        = "string"
  description = "The AWS elasticbeansalk application name for the front-end"
  default     = "thyart-web"
}