resource "aws_route53_record" "route53_cname_record" {
  zone_id = data.aws_route53_zone.route53_zone.id
  name    = "${replace(var.stage, "production", "www")}.${data.aws_route53_zone.route53_zone.name}"
  type    = "CNAME"
  records = [aws_elastic_beanstalk_environment.environment.cname]
  ttl     = "300"
}