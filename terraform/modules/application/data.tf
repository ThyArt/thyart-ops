data "scaleway_image" "ubuntu-latest" {
  architecture = "x86_64"
  name         = "Ubuntu Bionic"
  most_recent  = true
}