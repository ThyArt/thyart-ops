data "scaleway_image" "debian-latest" {
  architecture = "x86_64"
  name         = "Debian Stretch"
  most_recent  = true
}

data "aws_route53_zone" "route53_zone" {
  name         = var.route53_zone_name
  private_zone = false
}
