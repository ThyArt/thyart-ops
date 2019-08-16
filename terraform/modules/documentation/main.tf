resource "scaleway_server" "frontend" {
  image               = data.scaleway_image.debian-latest.id
  name                = "doc.api.thyart"
  type                = var.instance-type
  dynamic_ip_required = true
}

resource "aws_route53_record" "route53_frontend_cname_record" {
  zone_id = data.aws_route53_zone.route53_zone.id
  name    = "${var.cname_prefix}.${data.aws_route53_zone.route53_zone.name}"
  type    = "A"
  records = [scaleway_server.frontend.public_ip]
  ttl     = "300"
}