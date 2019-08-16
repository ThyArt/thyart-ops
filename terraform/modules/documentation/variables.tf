variable "instance-type" {
  type        = "string"
  description = "The type of instance used for the application"
}

variable "route53_zone_name" {
  type        = "string"
  description = "The Route 53 zone name used for deployment"
  default     = "thyart.fr"
}

variable "cname_prefix" {
  type        = "string"
  description = "the CNAME prefix used for the server"
}