resource "aws_eip" "backend-nat" {
  vpc = true
}

resource "aws_nat_gateway" "backend-nat-gateway" {
  allocation_id = "${aws_eip.backend-nat.id}"
  subnet_id     = "${aws_subnet.backend-subnet-public-1.id}"
  depends_on    = ["aws_internet_gateway.backend-gateway"]
}
