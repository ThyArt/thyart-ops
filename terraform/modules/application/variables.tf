variable "stage" {
  type        = "string"
  description = "The stage of the application"
}

variable "instance-type" {
  type        = "string"
  description = "The type of instance used for the application"
}

variable "route53_zone_name" {
  type        = "string"
  description = "The Route 53 zone name used for deployment"
  default     = "thyart.fr"
}

variable "backend_cname_prefix" {
  type        = "string"
  description = "the CNAME prefix used for the backend"
}

variable "frontend_cname_prefix" {
  type        = "string"
  description = "the CNAME prefix used for the backend"
}

variable "mysql_cname_prefix" {
  type        = "string"
  description = "the CNAME prefix used for the mysql"
}