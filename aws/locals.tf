locals {
  cnames = {
    web_prod    = "www.${var.route53_zone_name}"
    web_staging = "staging.${var.route53_zone_name}"
    api_prod    = "api.${var.route53_zone_name}"
    api_staging = "staging.api.${var.route53_zone_name}"
  }
}