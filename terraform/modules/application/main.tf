resource "scaleway_server" "frontend" {
  image               = data.scaleway_image.debian-latest.id
  name                = "${var.stage}.thyart.frontend"
  type                = var.instance-type
  dynamic_ip_required = true
}

resource "scaleway_server" "backend" {
  image               = data.scaleway_image.debian-latest.id
  name                = "${var.stage}.thyart.backend"
  type                = var.instance-type
  dynamic_ip_required = true
}

resource "scaleway_server" "mysql" {
  image               = data.scaleway_image.debian-latest.id
  name                = "${var.stage}.thyart.mysql"
  type                = var.instance-type
  dynamic_ip_required = true
}

resource "aws_route53_record" "route53_frontend_cname_record" {
  zone_id = data.aws_route53_zone.route53_zone.id
  name    = "${var.frontend_cname_prefix}.${data.aws_route53_zone.route53_zone.name}"
  type    = "A"
  records = [scaleway_server.frontend.public_ip]
  ttl     = "300"
}

resource "aws_route53_record" "route53_backend_cname_record" {
  zone_id = data.aws_route53_zone.route53_zone.id
  name    = "${var.backend_cname_prefix}.${data.aws_route53_zone.route53_zone.name}"
  type    = "A"
  records = [scaleway_server.backend.public_ip]
  ttl     = "300"
}

resource "aws_route53_record" "route53_mysql_cname_record" {
  zone_id = data.aws_route53_zone.route53_zone.id
  name    = "${var.mysql_cname_prefix}.${data.aws_route53_zone.route53_zone.name}"
  type    = "A"
  records = [scaleway_server.mysql.public_ip]
  ttl     = "300"
}