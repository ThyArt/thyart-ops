resource "aws_eip" "codebuild-nat" {
  vpc = true
}

resource "aws_nat_gateway" "codebuild-nat-gateway" {
  allocation_id = "${aws_eip.codebuild-nat.id}"
  subnet_id     = "${aws_subnet.codebuild-subnet-public-1.id}"
  depends_on    = ["aws_internet_gateway.codebuild-gateway"]
}
