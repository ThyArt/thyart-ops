resource "aws_route53_record" "route53_cname_record" {
  count   = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  zone_id = "${data.aws_route53_zone.route53_zone.id}"
  name    = "${replace(var.stage, "production", "www")}.${data.aws_route53_zone.route53_zone.name}"
  type    = "CNAME"
  records = ["${aws_elastic_beanstalk_environment.environment.0.cname}"]
  ttl     = "300"
}

resource "aws_route53_record" "route53_cname_record_certificate_validation" {
  count   = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  name    = "${aws_acm_certificate.acm_certificate.0.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.acm_certificate.0.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.route53_zone.id}"
  records = ["${aws_acm_certificate.acm_certificate.0.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}
