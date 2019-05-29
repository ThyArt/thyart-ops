resource "aws_eip" "frontend-nat" {
  vpc = true
}

resource "aws_nat_gateway" "frontend-nat-gateway" {
  allocation_id = "${aws_eip.frontend-nat.id}"
  subnet_id     = "${aws_subnet.frontend-subnet-public-1.id}"
  depends_on    = ["aws_internet_gateway.frontend-gateway"]
}
