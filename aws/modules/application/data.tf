data "aws_availability_zone" "availability_zones" {
  count = "${length(var.aws_availability_zones)}"
  name  = "${element(var.aws_availability_zones, count.index)}"
}