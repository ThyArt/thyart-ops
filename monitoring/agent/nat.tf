resource "aws_eip" "monitoring-agent-nat" {
  vpc = true
}

resource "aws_nat_gateway" "monitoring-agent-nat-gateway" {
  allocation_id = "${aws_eip.monitoring-agent-nat.id}"
  subnet_id     = "${aws_subnet.monitoring-agent-subnet-public-1.id}"
  depends_on    = ["aws_internet_gateway.monitoring-agent-gateway"]
}
