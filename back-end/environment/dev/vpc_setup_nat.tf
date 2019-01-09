resource "aws_route_table" "dev-route-table-private" {
  vpc_id = "${aws_vpc.dev-vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.dev-nat-gateway.id}"
  }

  tags {
    Name = "${var.application_name}-dev-private-1"
  }
}

# route associations private
resource "aws_route_table_association" "dev-route-table-association-private-1" {
  subnet_id      = "${aws_subnet.dev-subnet-private-1.id}"
  route_table_id = "${aws_route_table.dev-route-table-private.id}"
}

resource "aws_route_table_association" "dev-route-table-association-private-2" {
  subnet_id      = "${aws_subnet.dev-subnet-private-2.id}"
  route_table_id = "${aws_route_table.dev-route-table-private.id}"
}

resource "aws_route_table_association" "dev-route-table-association-private-3" {
  subnet_id      = "${aws_subnet.dev-subnet-private-3.id}"
  route_table_id = "${aws_route_table.dev-route-table-private.id}"
}
