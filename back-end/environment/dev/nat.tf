# nat gw
resource "aws_eip" "dev-nat" {
  vpc = true
}

resource "aws_nat_gateway" "dev-nat-gateway" {
  allocation_id = "${aws_eip.dev-nat.id}"
  subnet_id     = "${aws_subnet.dev-subnet-public-1.id}"
  depends_on    = ["aws_internet_gateway.dev-gateway"]
}
