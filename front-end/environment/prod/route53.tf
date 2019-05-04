resource "aws_route53_record" "route53_cname_record" {
  zone_id = "${data.aws_route53_zone.route53_zone.id}"
  name    = "${data.aws_route53_zone.route53_zone.name}"
  type    = "CNAME"
  records = ["${aws_elastic_beanstalk_environment.prod-environment.cname}"]
  ttl     = "300"
}

resource "aws_route53_record" "route53_cname_record_certificate_validation" {
  name    = "${aws_acm_certificate.acm_certificate.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.acm_certificate.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.route53_zone.id}"
  records = ["${aws_acm_certificate.acm_certificate.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}
