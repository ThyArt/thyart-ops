resource "aws_route53_record" "route53_cname_record" {
  zone_id = data.aws_route53_zone.route53_zone.id
  name    = var.environment_cname
  type    = "CNAME"
  records = [aws_elastic_beanstalk_environment.environment.cname]
  ttl     = "300"
}