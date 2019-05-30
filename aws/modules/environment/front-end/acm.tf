resource "aws_acm_certificate" "acm_certificate" {
  domain_name       = "${var.stage}.${var.route53_zone_name}"
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = "${aws_acm_certificate.acm_certificate.arn}"
  validation_record_fqdns = ["${aws_route53_record.route53_cname_record_certificate_validation.fqdn}"]
}
