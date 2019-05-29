resource "aws_acm_certificate" "acm_certificate" {
  count             = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  domain_name       = "${var.stage}.${var.route53_zone_name}"
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  count                   = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  certificate_arn         = "${aws_acm_certificate.acm_certificate.0.arn}"
  validation_record_fqdns = ["${aws_route53_record.route53_cname_record_certificate_validation.0.fqdn}"]
}
