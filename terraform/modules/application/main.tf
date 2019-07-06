resource "scaleway_server" "frontend" {
  image               = data.scaleway_image.ubuntu-latest.id
  name                = "${var.stage}.thyart.frontend"
  type                = var.instance-type
  dynamic_ip_required = true
}

resource "scaleway_server" "backend" {
  image               = data.scaleway_image.ubuntu-latest.id
  name                = "${var.stage}.thyart.backend"
  type                = var.instance-type
  dynamic_ip_required = true
}

resource "scaleway_server" "mysql" {
  image               = data.scaleway_image.ubuntu-latest.id
  name                = "${var.stage}.thyart.mysql"
  type                = var.instance-type
  dynamic_ip_required = true
}